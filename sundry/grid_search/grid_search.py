#!/usr/bin/env python3
"""
Common methods used by grid searches.

File: utils.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
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

        git_args = ["checkout", "-b", branch_prefix, self.branch]
        subprocess.call(['git'] + git_args)

        for aset in permlists:
            commit_msg = "" + commit_prefix
            sedcmds = []
            for i in range(0, len(aset)):
                commit_msg = commit_msg + ("({} = {})".format(
                    self.paramlist[i]['name'], aset[i]))

                sedcmds.append(['sed', '-i', "s/{0} = .*$/{0} = {1}/".format(
                    self.paramlist[i]['variable'], aset[i]), self.source])

            for cmd in sedcmds:
                subprocess.call(cmd)

            git_args = ["add", self.source]
            subprocess.call(['git'] + git_args)

            git_args = ["commit", "-m", commit_msg]
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
