#!/usr/bin/env python3
"""
Generate grid plots for a given set of neurons.

File: gridPlotter.py

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


import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy
import os


class gridPlotter():

    """Plot firing rates in spatial grids."""

    def __init__(self):
        """Initialise."""
        self.filenameE = "00-neuron-locations-E.txt"
        self.filenameI = "00-neuron-locations-I.txt"
        self.filename_lpz_E = "00-lpz-neuron-locations-E.txt"
        self.filename_lpz_I = "00-lpz-neuron-locations-I.txt"
        self.pattern_files_prefix = "00-pattern-neurons-"
        self.neuronsE = []
        self.neuronsI = []
        self.neurons_lpz_E = []
        self.neurons_lpz_I = []
        self.patterns = []
        self.number_patterns = 0
        matplotlib.rcParams.update({'font.size': 30})

    def setup(self, filenameE, filenameI, filename_lpz_E, filename_lpz_I):
        """Set up plotter."""
        self.filenameE = filenameE
        self.filenameI = filenameI
        self.filename_lpz_E = filename_lpz_E
        self.filename_lpz_I = filename_lpz_I

    def plot_EI_graph(self):
        """Plot I E neurons."""
        xE = []
        yE = []
        for nrn in self.neuronsE:
            xE.append(nrn[1])
            yE.append(nrn[2])

        xI = []
        yI = []
        for nrn in self.neuronsI:
            xI.append(nrn[1])
            yI.append(nrn[2])

        plt.figure(num=None, figsize=(32, 18), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        plt.plot(xE, yE, ".", markersize=6, label="E")
        plt.plot(xI, yI, ".", markersize=6, label="I")
        plt.legend(loc="upper right")
        plt.savefig("IE-gridplot.png")
        plt.close()

    def plot_E_graph(self):
        """Plot graph with E and LPZ E neurons."""
        only_E = self.neuronsE - self.neurons_lpz_E
        xE = []
        yE = []
        for nrn in only_E:
            xE.append(nrn[1])
            yE.append(nrn[2])
        x_lpzE = []
        y_lpzE = []
        for nrn in self.neurons_lpz_E:
            x_lpzE.append(nrn[1])
            y_lpzE.append(nrn[2])

        # E and LPZ E
        plt.figure(num=None, figsize=(32, 18), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        plt.plot(xE, yE, ".", markersize=6, label="E")
        plt.plot(x_lpzE, y_lpzE, ".", markersize=6, label="LPZ E")
        plt.legend(loc="upper right")
        plt.savefig("E-gridplot.png")
        plt.close()

    def plot_I_graph(self):
        """Plot graph with I and LPZ I neurons."""
        only_I = self.neuronsI - self.neurons_lpz_I
        xI = []
        yI = []
        for nrn in only_I:
            xI.append(nrn[1])
            yI.append(nrn[2])
        x_lpzI = []
        y_lpzI = []
        for nrn in self.neurons_lpz_I:
            x_lpzI.append(nrn[1])
            y_lpzI.append(nrn[2])

        # I and LPZ I
        plt.figure(num=None, figsize=(32, 18), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        plt.plot(xI, yI, ".", markersize=6, label="I")
        plt.plot(x_lpzI, y_lpzI, ".", markersize=6, label="LPZ I")
        plt.legend(loc="upper right")
        plt.savefig("I-gridplot.png")
        plt.close()

    def plot_single_pattern_graphs(self):
        """Plot E , lpz E and pattern neurons."""
        for i in range(0, self.number_patterns):
            patX = []
            patY = []
            xE_this = []
            yE_this = []
            x_lpzE_this = []
            y_lpzE_this = []
            thispattern = self.patterns[i]

            neuronsE_this = self.neuronsE - thispattern - self.neurons_lpz_E
            neurons_lpz_E_this = self.neurons_lpz_E - thispattern

            for nrn in thispattern:
                patX.append(nrn[1])
                patY.append(nrn[2])
            for nrn in neuronsE_this:
                xE_this.append(nrn[1])
                yE_this.append(nrn[2])
            for nrn in neurons_lpz_E_this:
                x_lpzE_this.append(nrn[1])
                y_lpzE_this.append(nrn[2])

            plt.figure(num=None, figsize=(32, 18), dpi=80)
            plt.xlabel("extent (micro metres)")
            plt.ylabel("extent (micro metres)")
            plt.plot(xE_this, yE_this, ".", markersize=6, label="E")
            plt.plot(patX, patY, "x", markersize=6, label="PAT" + str(i+1))
            plt.plot(x_lpzE_this, y_lpzE_this, "o", markersize=6, label="LPZ E")
            plt.legend(loc="upper right")
            plt.savefig("Pattern-{}-gridplot.png".format((i+1)))

    def plot_all_pattern_graph(self):
        """Plot E, lpz E, all patterns."""
        plt.figure(num=None, figsize=(32, 18), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        non_patE = self.neuronsE
        non_pat_lpzE = self.neurons_lpz_E
        xE = []
        yE = []
        x_lpzE = []
        y_lpzE = []
        for i in range(0, self.number_patterns):
            patX = []
            patY = []
            thispattern = self.patterns[i]

            non_patE = non_patE - thispattern - self.neurons_lpz_E
            non_pat_lpzE = non_pat_lpzE - thispattern

            for nrn in thispattern:
                patX.append(nrn[1])
                patY.append(nrn[2])
            plt.plot(patX, patY, "x", markersize=6, label="PAT" + str(i+1))

        for nrn in non_patE:
            xE.append(nrn[1])
            yE.append(nrn[2])
        for nrn in non_pat_lpzE:
            x_lpzE.append(nrn[1])
            y_lpzE.append(nrn[2])
        plt.plot(xE, yE, ".", markersize=6, label="E")
        plt.plot(x_lpzE, y_lpzE, ".", markersize=6, label="LPZ E")
        plt.legend(loc="upper right")
        plt.savefig("All-patterns-gridplot.png")

    def plot_I_E_graph(self):
        """Plot I and E neurons - both LPZ and not."""
        # could do list comprehension or zip or something else, but this is just
        # much clearer
        xI = []
        yI = []
        for nrn in self.neuronsI:
            xI.append(nrn[1])
            yI.append(nrn[2])
        x_lpzI = []
        y_lpzI = []
        for nrn in self.neurons_lpz_I:
            x_lpzI.append(nrn[1])
            y_lpzI.append(nrn[2])
        xE = []
        yE = []
        for nrn in self.neuronsE:
            xE.append(nrn[1])
            yE.append(nrn[2])
        x_lpzE = []
        y_lpzE = []
        for nrn in self.neurons_lpz_E:
            x_lpzE.append(nrn[1])
            y_lpzE.append(nrn[2])

        plt.figure(num=None, figsize=(32, 18), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        plt.plot(xE, yE, ".", markersize=6, label="E")
        plt.plot(x_lpzE, y_lpzE, ".", markersize=6, label="LPZ E")
        plt.plot(xI, yI, ".", markersize=6, label="I")
        plt.plot(x_lpzI, y_lpzI, ".", markersize=6, label="LPZ I")
        plt.legend(loc="upper right")
        plt.savefig("I-E-gridplot.png")

    def read_files(self):
        """Read all files.

        Convert all the data into sets: lets one use set arithmetic on them.
        """
        if not (
            os.path.exists(self.filenameE) and
            os.path.exists(self.filenameI) and
            os.stat(self.filenameE).st_size > 0 and
            os.stat(self.filenameI).st_size > 0
        ):
            return False

        self.neuronsE = set(map(tuple,
                                numpy.loadtxt(self.filenameE, delimiter='\t')))
        self.neuronsI = set(map(tuple,
                                numpy.loadtxt(self.filenameI, delimiter='\t')))
        # Now the LPZ bits
        if not (
            os.path.exists(self.filename_lpz_E) and
            os.path.exists(self.filename_lpz_I) and
            os.stat(self.filename_lpz_E).st_size > 0 and
            os.stat(self.filename_lpz_I).st_size > 0
        ):
            return False

        self.neurons_lpz_I = set(
            map(tuple, numpy.loadtxt(self.filename_lpz_I, delimiter='\t')))
        self.neurons_lpz_E = set(
            map(tuple, numpy.loadtxt(self.filename_lpz_E, delimiter='\t')))

        self.number_patterns = self.__get_numpats()

        for i in range(0, self.number_patterns):
            this_pat_filename = self.pattern_files_prefix + str(i+1) + ".txt"
            if (
                os.path.exists(this_pat_filename) and
                os.stat(this_pat_filename).st_size > 0
            ):
                this_pat = set(
                    map(tuple,
                        numpy.loadtxt(this_pat_filename, delimiter='\t')))
                self.patterns.append(this_pat)

    def __get_numpats(self):
        """Get number of patterns from list of files in directory."""
        filelist = os.listdir()
        i = 0
        for entry in filelist:
            if entry.startswith('00-pattern-neurons-'):
                i = i+1
        return i


if __name__ == "__main__":
    plotter = gridPlotter()
    plotter.read_files()
    plotter.plot_E_graph()
    plotter.plot_I_graph()
    plotter.plot_EI_graph()
    plotter.plot_single_pattern_graphs()
    plotter.plot_all_pattern_graph()
