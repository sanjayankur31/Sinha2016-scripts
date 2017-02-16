#!/usr/bin/env python3
"""
Plot the main time graphs.

File: plot-time-graphs.py

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

import os
import pandas
import subprocess
import sys


class timeGraphPlotter:

    """Plot the main time graphs."""

    def __init__(self, config):
        """Initialise."""
        self.config = config
        # Lets check to see if Gnuplot works
        try:
            __import__('Gnuplot')
        except ImportError:
            print("Could not import Gnuplot module.", file=sys.stderr)
        else:
            self.plotter = Gnuplot.Gnuplot()
            self.plotter.reset()

            if (
                os.path.isfile(self.config.filenameMeanRatesE) and
                os.stat(self.config.filenameMeanRatesE).st_size != 0
            ):
                ratesE = pandas.load_csv(self.config.filenameMeanRatesE,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineE = Gnuplot.data(ratesE.values[:0], ratesE.values[:1],
                                          title="E", with_="lines lw 4")
            else:
                self.lineE = [0, 0]

            if (
                os.path.isfile(self.config.filenameMeanRatesI) and
                os.stat(self.config.filenameMeanRatesI).st_size != 0
            ):
                ratesI = pandas.load_csv(self.config.filenameMeanRatesI,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineI = Gnuplot.data(ratesI.values[:0], ratesI.values[:1],
                                          title="I", with_="lines lw 4")
            else:
                self.lineI = [0, 0]

            if (
                os.path.isfile(self.config.filenameMeanRatesR) and
                os.stat(self.config.filenameMeanRatesR).st_size != 0
            ):
                ratesR = pandas.load_csv(self.config.filenameMeanRatesR,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineR = Gnuplot.data(ratesR.values[:0], ratesR.values[:1],
                                          title="R", with_="lines lw 4")
            else:
                self.lineR = [0, 0]

            if (
                os.path.isfile(self.config.filenameMeanRatesB) and
                os.stat(self.config.filenameMeanRatesB).st_size != 0
            ):
                ratesB = pandas.load_csv(self.config.filenameMeanRatesB,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineB = Gnuplot.data(ratesB.values[:0], ratesB.values[:1],
                                          title="B", with_="lines lw 4")
            else:
                self.lineB = [0, 0]

            if (
                os.path.isfile(self.config.filenameMeanRatesS) and
                os.stat(self.config.filenameMeanRatesS).st_size != 0
            ):
                ratesS = pandas.load_csv(self.config.filenameMeanRatesS,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineS = Gnuplot.data(ratesS.values[:0], ratesS.values[:1],
                                          title="S", with_="lines lw 4")
            else:
                self.lineS = [0, 0]

            if (
                os.path.isfile(self.config.filenameMeanRatesL) and
                os.stat(self.config.filenameMeanRatesL).st_size != 0
            ):
                ratesL = pandas.load_csv(self.config.filenameMeanRatesL,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineL = Gnuplot.data(ratesL.values[:0], ratesL.values[:1],
                                          title="L", with_="lines lw 4")
            else:
                self.lineL = [0, 0]

            if (
                os.path.isfile(self.config.filenameMeanRatesP) and
                os.stat(self.config.filenameMeanRatesP).st_size != 0
            ):
                ratesP = pandas.load_csv(self.config.filenameMeanRatesP,
                                         sep='\s+',
                                         names=["neuronID", "spike_time"],
                                         dtype={'neuronID': numpy.uint16,
                                                'spike_time': numpy.float32},
                                         lineterminator="\n",
                                         skipinitialspace=True, header=None,
                                         index_col=None)
                self.lineP = Gnuplot.data(ratesP.values[:0], ratesP.values[:1],
                                          title="P", with_="lines lw 4")
            else:
                self.lineP = [0, 0]

    def __plot_main(self):
        """Main plot with everything in it."""
        self.plotter('set term pngcairo font "OpenSans, 28" size 1920,1028')
        self.plotter.title("Mean firing rate for all available neuron sets")
        self.plotter.xlabel("Time (ms)")
        self.plotter.ylabel("Firing rate (Hz)")
        self.plotter("set yrange [0:200]")
        self.plotter("set ytics border nomirror 20")
        self.plotter("set xtics border nomirror")
        self.plotter.plot(self.lineE, self.lineI, self.lineB, self.lineL,
                          self.lineP, self.lineR, self.lineS)
        self.hardcopy(filename="firing-rate-all.png")

    def __plot_individuals(self):
        """Main plot with everything in it."""
        # TODO after Gnuplot is py3 compatible

    def __plot_I_E(self):
        """Plot one for I and E."""
        self.plotter('set term pngcairo font "OpenSans, 28" size 1920,1028')
        self.plotter.title("Mean firing rate for all I E neuron sets")
        self.plotter.xlabel("Time (ms)")
        self.plotter.ylabel("Firing rate (Hz)")
        self.plotter("set yrange [0:200]")
        self.plotter("set ytics border nomirror 20")
        self.plotter("set xtics border nomirror")
        self.plotter.plot(self.lineE, self.lineI)
        self.hardcopy(filename="firing-rate-I-E.png")

    def __plot_P_B(self):
        """Plot one for I and E."""
        self.plotter('set term pngcairo font "OpenSans, 28" size 1920,1028')
        self.plotter.title("Mean firing rate for all P B neuron sets")
        self.plotter.xlabel("Time (ms)")
        self.plotter.ylabel("Firing rate (Hz)")
        self.plotter("set yrange [0:200]")
        self.plotter("set ytics border nomirror 20")
        self.plotter("set xtics border nomirror")
        self.plotter.plot(self.lineP, self.lineB)
        self.hardcopy(filename="firing-rate-P-B.png")

    def __get_firing_rates_from_spikes(self):
        """Get firing rate files from spikes."""
        from nest.spike2hz import spike2hz
        if (
            os.path.isfile(self.config.filenameE) and
            os.stat(self.config.filenameE).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameE,
                                    self.config.filenameMeanRatesE,
                                    self.config.filenameSTDRatesE,
                                    self.config.filenameMeanCVE,
                                    self.config.filenameMeanFanoE,
                                    self.config.neuronsE,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameI) and
            os.stat(self.config.filenameI).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameI,
                                    self.config.filenameMeanRatesI,
                                    self.config.filenameSTDRatesI,
                                    self.config.filenameMeanCVI,
                                    self.config.filenameMeanFanoI,
                                    self.config.neuronsI,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        # various pattern related spike files
        numpats = self.__get_numpats()
        for i in range(1, numpats + 1):
            if (
                os.path.isfile(
                    self.config.filenamePrefixR + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixR + str(i) + ".gdf").st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixR + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesR + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesR + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVR + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoR + str(i) + ".gdf",
                    self.config.neuronsR,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

            if (
                os.path.isfile(
                    self.config.filenamePrefixB + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixB + str(i) + ".gdf").st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixB + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesB + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesB + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVB + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoB + str(i) + ".gdf",
                    self.config.neuronsB,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

            if (
                os.path.isfile(
                    self.config.filenamePrefixS + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixS + str(i) + ".gdf").st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixS + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesS + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesS + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVS + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoS + str(i) + ".gdf",
                    self.config.neuronsS,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

            if (
                os.path.isfile(
                    self.config.filenamePrefixDP + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixDP + str(i) + ".gdf"
                ).st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixDP + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesDP + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesDP + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVDP + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoDP + str(i) + ".gdf",
                    self.config.neuronsDP,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

            if (
                os.path.isfile(
                    self.config.filenamePrefixP + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixP + str(i) + ".gdf").st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixP + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesP + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesP + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVP + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoP + str(i) + ".gdf",
                    self.config.neuronsP,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

            if (
                os.path.isfile(
                    self.config.filenamePrefixDBGE + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixDBGE + str(i) + ".gdf"
                ).st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixDBGE + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesDBGE + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesDBGE + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVDBGE + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoDBGE + str(i) + ".gdf",
                    self.config.neuronsDBGE,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

            if (
                os.path.isfile(
                    self.config.filenamePrefixDBGI + str(i) + ".gdf") and
                os.stat(
                    self.config.filenamePrefixDBGI + str(i) + ".gdf"
                ).st_size != 0
            ):
                spikeconverter = spike2hz()
                if spikeconverter.setup(
                    self.config.filenamePrefixDBGI + str(i) + ".gdf",
                    self.config.filenamePrefixMeanRatesDBGI + str(i) + ".gdf",
                    self.config.filenamePrefixSTDRatesDBGI + str(i) + ".gdf",
                    self.config.filenamePrefixMeanCVDBGI + str(i) + ".gdf",
                    self.config.filenamePrefixMeanFanoDBGI + str(i) + ".gdf",
                    self.config.neuronsDBGI,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

    def plot_all(self):
        """Plot them all."""
        # Ask if regenerate firing rate files
        filelist = os.listdir()
        filesfound = []
        for entry in filelist:
            if 'firing-' in entry or 'std-' in entry or 'cv-' in entry:
                if ".png" not in entry:
                    filesfound.append(entry)

        filesfound.sort()
        if len(filesfound) > 0:
            print("Generated files found: {}".format(len(filesfound)))
            for entry in filesfound:
                print("- {}".format(entry))

            regen = input("Regenerate firing rate files (Y for yes)? ")
            if regen == "Y":
                self.__get_firing_rates_from_spikes()

        print("Generating graphs.")
        try:
            __import__('Gnuplot')
        except ImportError:
            print("Could not import Gnuplot. Using binary and plotting file.",
                  file=sys.stderr)
            self.__plot_using_gnuplot_binary()
        else:
            self.__plot_main()
            self.__plot_individuals()
            self.__plot_I_E()
            self.__plot_P_B()

    def __get_numpats(self):
        """Get number of patterns from list of files in directory."""
        filelist = os.listdir()
        i = 0
        for entry in filelist:
            if 'patternneurons-' in entry:
                i = i+1
        return i

    def __plot_using_gnuplot_binary(self):
        """Use the binary because it doesnt support py3."""
        numpats = self.__get_numpats()
        print("Plotting E I firing rate graphs.")
        args = (os.path.join(
            self.config.postprocessHome,
            self.config.gnuplotFilesDir,
            'plot-firing-rates-IE.plt'))
        subprocess.call(['gnuplot',
                         args])

        print("Plotting pattern related firing rate graphs.")
        args = (os.path.join(
            self.config.postprocessHome,
            self.config.gnuplotFilesDir,
            'plot-firing-rates-patterns.plt'))
        command = ['gnuplot', '-e', 'numpats={}'.format(numpats),
                   args]
        subprocess.call(command)

        print("Plotting CV graphs.")
        args = (os.path.join(
            self.config.postprocessHome,
            self.config.gnuplotFilesDir,
            'plot-cvs.plt'))
        subprocess.call(['gnuplot',
                         args])

        print("Plotting STD graphs.")
        args = (os.path.join(
            self.config.postprocessHome,
            self.config.gnuplotFilesDir,
            'plot-std.plt'))
        subprocess.call(['gnuplot',
                         args])

if __name__ == "__main__":
    runner = timeGraphPlotter()
