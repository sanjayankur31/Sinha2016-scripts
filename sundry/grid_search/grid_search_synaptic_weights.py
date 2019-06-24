#!/usr/bin/env python3
"""
Set up files for a grid search.

File: grid_search_synaptic_weights.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import sys
import os
import numpy
import subprocess
import datetime


class GridSearch:

    """Set up your simulations for a grid search.


    This will modify the source in a branch, make changes, commit
    and then you can set these commits up on the cluster.
    """

    def __init__(self):
        """Initialise."""
        self.source = "/home/asinha/Documents/02_Code/00_mine/Sinha2016/src/Sinha2016.py"
        self.branch = "master"

    def usage(self):
        """Print usage."""
        print("Usage:", file=sys.stderr)
        print("python3 grid_search.py <branch>", file=sys.stderr)
        print("Branch MUST be specified.", file=sys.stderr)

    def setup(self, branch, range_dict):
        """Set it up."""
        self.branch = branch

        if len(range_dict['EE']) == 1:
            self.EE_increment = 0.5
            self.EE_min = range_dict['EE'][0]
            self.EE_max = range_dict['EE'][0] + self.EE_increment
        elif len(range_dict['EE']) == 3:
            self.EE_increment = range_dict['EE'][2]
            self.EE_min = range_dict['EE'][0]
            self.EE_max = range_dict['EE'][1] + self.EE_increment
        else:
            print("EE not found in dict. Exiting.", file=sys.stderr)
            return False

        if len(range_dict['EI']) == 1:
            self.EI_increment = 0.5
            self.EI_min = range_dict['EI'][0]
            self.EI_max = range_dict['EI'][0] + self.EI_increment
        elif len(range_dict['EI']) == 3:
            self.EI_increment = range_dict['EI'][2]
            self.EI_min = range_dict['EI'][0]
            self.EI_max = range_dict['EI'][1] + self.EI_increment
        else:
            print("EI not found in dict. Exiting.", file=sys.stderr)
            return False

        if len(range_dict['II']) == 1:
            self.II_increment = 0.5
            self.II_min = range_dict['II'][0]
            self.II_max = range_dict['II'][0] + self.II_increment
        elif len(range_dict['II']) == 3:
            self.II_increment = range_dict['II'][2]
            self.II_min = range_dict['II'][0]
            self.II_max = range_dict['II'][1] + self.II_increment
        else:
            print("II not found in dict. Exiting.", file=sys.stderr)
            return False

        return True

    def run(self):
        """Run."""
        # checkout the branch
        git_args = ["checkout", "-b", "grid_search-{}".format(
            str(datetime.date.today())), self.branch]
        subprocess.call(['git'] + git_args)

        for weightEE in numpy.arange(self.EE_min, self.EE_max, self.EE_increment):
            for weightEI in numpy.arange(self.EI_min, self.EI_max, self.EI_increment):
                for weightII in numpy.arange(self.II_min, self.II_max, self.II_increment):

                    sed_args_EE = ['sed', '-i',
                                "s/weightEE = .*$/weightEE = {}/".format(weightEE),
                                self.source]
                    subprocess.call(sed_args_EE)

                    sed_args_EI = ['sed', '-i',
                                "s/weightEI = .*$/weightEI = {}/".format(weightEI),
                                self.source]
                    subprocess.call(sed_args_EI)

                    sed_args_II = ['sed', '-i',
                                "s/weightII = .*$/weightII = {}/".format(weightII),
                                self.source]
                    subprocess.call(sed_args_II)

                    git_args = ["add", self.source]
                    subprocess.call(['git'] + git_args)

                    commit_msg = """{} {} {} {}""".format(
                        str(datetime.date.today()), weightEE,
                        weightEI, weightII)

                    git_args = ["commit", "-m", commit_msg]
                    subprocess.call(['git'] + git_args)

        git_args = ["checkout", self.branch]
        subprocess.call(['git'] + git_args)

if __name__ == "__main__":
    search = GridSearch()
    if len(sys.argv) != 2:
        search.usage()
        sys.exit(-1)
    else:
        branch = sys.argv[1]
        # dictionary that holds the required grid ranges
        # specify min, max if want a grid search, else specify only one value
        # if you specify max, min, you must specify increment
        setup_dict = {
            'EE': [3.],
            'EI': [0.5, 3., 0.5],
            'II': [-5., -30., -5.],
        }
        if search.setup(branch, setup_dict):
            search.run()
