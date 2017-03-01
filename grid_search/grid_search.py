#!/usr/bin/env python3
"""
Common methods used by grid searches.

File: utils.py

Copyright 2016 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import numpy
import ast
import datetime
import itertools
import sys
import subprocess


class GridSearch:

    """A general grid search utility.


    It takes a list of dictionaries from a file.
    These dictionaries define the parameters of a grid search:

        name: name of parameter
        variable: corresponding variable in the simulation source file
        start: start value
        stop: stop value
        numpts: number of points to get

    It then modifies the source, and creates different commits for each point
    in the parameter space to be explored.


    BEWARE: it is a dumb script - it does not make any intelligent checks
    or guesses at all. Making sure the input is correct is YOUR responsiblity!
    """

    def __init__(self):
        """Init."""
        self.paramlist = []
        self.source = ""

    def setup_search(self, filename):
        """Set up search parameters."""
        with open(filename, 'r') as f:
            s = f.read()
            self.paramlist = ast.literal_eval(s)

        newparams = []
        for params in self.paramlist:
            params = self.__unroll(params)
            newparams.append(params)
        self.paramlist = newparams

    def setup_simulations(self, sourcefile, basebranch):
        """Use the params to set up the simulation branches."""
        self.source = sourcefile
        self.branch = basebranch
        branch_prefix = "grid-search-{}".format(datetime.date.today())
        commit_prefix = "Grid search run on {} with params: ".format(
            datetime.date.today())
        values = []
        for p in self.paramlist:
            values.append(list(p['values']))

        permlists = (list(itertools.product(*values)))
        print("{} permutations of parameters generated.".format(
            len(permlists)))

        for aset in permlists:
            branchname = "" + branch_prefix
            commit_msg = "" + commit_prefix
            sedcmds = []
            for i in range(0, len(aset)):
                branchname = branchname + ("-{}-{}".format(
                    self.paramlist[i]['name'], aset[i]))
                commit_msg = commit_msg + ("({} = {})".format(
                    self.paramlist[i]['name'], aset[i]))
                print(branchname)

                sedcmds.append(['sed', '-i', "s/{0} = .*$/{0} = {1}/".format(
                    self.paramlist[i]['variable'], aset[i]), self.source])

            # Do the modifications
            git_args = ["checkout", "-b", branchname, self.branch]
            subprocess.call(['git'] + git_args)

            for cmd in sedcmds:
                subprocess.call(cmd)

            git_args = ["add", self.source]
            subprocess.call(['git'] + git_args)

            git_args = ["commit", "-m", branchname]
            subprocess.call(['git'] + git_args)

        git_args = ["checkout", "-b", branch_prefix, self.branch]
        subprocess.call(['git'] + git_args)

        git_args = ["checkout", self.branch]
        subprocess.call(['git'] + git_args)

    def __unroll(self, d):
            """
            Unroll the parameter dictionary to all expected values.

            d: dict of parameters

            return:
                d with a key that contains the unrolled values.
            """
            d['values'] = numpy.linspace(d['start'], d['stop'], d['numpts'],
                                         endpoint=True)
            d.pop('start')
            d.pop('stop')
            d.pop('numpts')
            return d


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Requires two arguments:")
        print("- paramdict file")
        print("- fullpath to source file")
        print("- basebranch")
        print("To be run inside the simulation source repository, obviously.")
        sys.exit(1)
    search = GridSearch()
    search.setup_search(sys.argv[1])
    search.setup_simulations(sys.argv[2], sys.argv[3])
