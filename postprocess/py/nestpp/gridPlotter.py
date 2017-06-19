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
        self.neuronListE = "00-neuron-locations-E.txt"
        self.neuronListI = "00-neuron-locations-I.txt"
        self.neuronListLPZE = "00-lpz-neuron-locations-E.txt"
        self.neuronListLPZI = "00-lpz-neuron-locations-I.txt"
        self.neuronListPrefixP = "00-pattern-neurons-"
        self.neuronsE = []
        self.neuronsI = []
        self.neurons_lpz_E = []
        self.neurons_lpz_I = []
        self.patterns = []
        self.numpats = 0
        matplotlib.rcParams.update({'font.size': 30})

    def setup(self, config):
        """Set up plotter."""
        self.neuronListE = config.neuronListE
        self.neuronListI = config.neuronListI
        self.neuronListLPZE = config.neuronListLPZE
        self.neuronListLPZI = config.neuronListLPZI
        self.neuronListPrefixP = config.neuronListPrefixP
        self.numpats = config.numpats

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

        plt.figure(num=None, figsize=(16, 20), dpi=80)
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
        plt.figure(num=None, figsize=(16, 20), dpi=80)
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
        plt.figure(num=None, figsize=(16, 20), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        plt.plot(xI, yI, ".", markersize=6, label="I")
        plt.plot(x_lpzI, y_lpzI, ".", markersize=6, label="LPZ I")
        plt.legend(loc="upper right")
        plt.savefig("I-gridplot.png")
        plt.close()

    def plot_single_pattern_graphs(self):
        """Plot E , lpz E and pattern neurons."""
        for i in range(1, self.numpats + 1):
            patX = []
            patY = []
            xE_this = []
            yE_this = []
            x_lpzE_this = []
            y_lpzE_this = []
            thispattern = self.patterns[i - 1]

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

            plt.figure(num=None, figsize=(16, 20), dpi=80)
            plt.xlabel("extent (micro metres)")
            plt.ylabel("extent (micro metres)")
            plt.plot(xE_this, yE_this, ".", markersize=6, label="E")
            plt.plot(patX, patY, "x", markersize=6, label="PAT" + str(i))
            plt.plot(x_lpzE_this, y_lpzE_this, "o", markersize=6, label="LPZ E")
            plt.legend(loc="upper right")
            plt.savefig("Pattern-{}-gridplot.png".format((i)))

    def plot_all_pattern_graph(self):
        """Plot E, lpz E, all patterns."""
        plt.figure(num=None, figsize=(16, 20), dpi=80)
        plt.xlabel("extent (micro metres)")
        plt.ylabel("extent (micro metres)")
        non_patE = self.neuronsE
        non_pat_lpzE = self.neurons_lpz_E
        xE = []
        yE = []
        x_lpzE = []
        y_lpzE = []
        for i in range(1, self.numpats + 1):
            patX = []
            patY = []
            thispattern = self.patterns[i - 1]

            non_patE = non_patE - thispattern - self.neurons_lpz_E
            non_pat_lpzE = non_pat_lpzE - thispattern

            for nrn in thispattern:
                patX.append(nrn[1])
                patY.append(nrn[2])
            plt.plot(patX, patY, "x", markersize=6, label="PAT" + str(i))

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

        plt.figure(num=None, figsize=(16, 20), dpi=80)
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
            os.path.exists(self.neuronListE) and
            os.path.exists(self.neuronListI) and
            os.stat(self.neuronListE).st_size > 0 and
            os.stat(self.neuronListI).st_size > 0
        ):
            return False

        self.neuronsE = set(map(tuple, numpy.loadtxt(self.neuronListE,
                                                     delimiter='\t',
                                                     usecols=[0, 3, 4])))
        self.neuronsI = set(map(tuple, numpy.loadtxt(self.neuronListI,
                                                     delimiter='\t',
                                                     usecols=[0, 3, 4])))
        # Now the LPZ bits
        if not (
            os.path.exists(self.neuronListLPZE) and
            os.path.exists(self.neuronListLPZI) and
            os.stat(self.neuronListLPZE).st_size > 0 and
            os.stat(self.neuronListLPZI).st_size > 0
        ):
            return False

        self.neurons_lpz_I = set(
            map(tuple, numpy.loadtxt(self.neuronListLPZI, delimiter='\t')))
        self.neurons_lpz_E = set(
            map(tuple, numpy.loadtxt(self.neuronListLPZE, delimiter='\t')))

        for i in range(1, self.numpats + 1):
            this_pat_filename = self.neuronListPrefixP + str(i) + ".txt"
            if (
                os.path.exists(this_pat_filename) and
                os.stat(this_pat_filename).st_size > 0
            ):
                this_pat = set(
                    map(tuple,
                        numpy.loadtxt(this_pat_filename, delimiter='\t')))
                self.patterns.append(this_pat)

if __name__ == "__main__":

    class config:

        """Dummy config class."""

        neuronListE = "00-neuron-locations-E.txt"
        neuronListI = "00-neuron-locations-I.txt"
        neuronListLPZE = "00-lpz-neuron-locations-E.txt"
        neuronListLPZI = "00-lpz-neuron-locations-I.txt"
        neuronListPrefixP = "00-pattern-neurons-"
        numpats = 3

    plotter = gridPlotter()
    plotter.setup(config)
    plotter.read_files()
    plotter.plot_E_graph()
    plotter.plot_I_graph()
    plotter.plot_EI_graph()
    plotter.plot_single_pattern_graphs()
    plotter.plot_all_pattern_graph()
