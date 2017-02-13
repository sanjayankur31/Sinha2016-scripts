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
                ratesE = pandas.load_csv(self.config.filenameMeanRatesE, sep='\s+',
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
                ratesI = pandas.load_csv(self.config.filenameMeanRatesI, sep='\s+',
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
                ratesR = pandas.load_csv(self.config.filenameMeanRatesR, sep='\s+',
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
                ratesB = pandas.load_csv(self.config.filenameMeanRatesB, sep='\s+',
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
                ratesS = pandas.load_csv(self.config.filenameMeanRatesS, sep='\s+',
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
                ratesL = pandas.load_csv(self.config.filenameMeanRatesL, sep='\s+',
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
                ratesP = pandas.load_csv(self.config.filenameMeanRatesP, sep='\s+',
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

        if (
            os.path.isfile(self.config.filenameR) and
            os.stat(self.config.filenameR).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameR,
                                    self.config.filenameMeanRatesR,
                                    self.config.filenameSTDRatesR,
                                    self.config.filenameMeanCVR,
                                    self.config.filenameMeanFanoR,
                                    self.config.neuronsR,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameB) and
            os.stat(self.config.filenameB).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameB,
                                    self.config.filenameMeanRatesB,
                                    self.config.filenameSTDRatesB,
                                    self.config.filenameMeanCVB,
                                    self.config.filenameMeanFanoB,
                                    self.config.neuronsB,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameS) and
            os.stat(self.config.filenameS).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameS,
                                    self.config.filenameMeanRatesS,
                                    self.config.filenameSTDRatesS,
                                    self.config.filenameMeanCVS,
                                    self.config.filenameMeanFanoS,
                                    self.config.neuronsS,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameDP) and
            os.stat(self.config.filenameDP).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameDP,
                                    self.config.filenameMeanRatesDP,
                                    self.config.filenameSTDRatesDP,
                                    self.config.filenameMeanCVDP,
                                    self.config.filenameMeanFanoDP,
                                    self.config.neuronsDP,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameP) and
            os.stat(self.config.filenameP).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameP,
                                    self.config.filenameMeanRatesP,
                                    self.config.filenameSTDRatesP,
                                    self.config.filenameMeanCVP,
                                    self.config.filenameMeanFanoP,
                                    self.config.neuronsP,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameDBGE) and
            os.stat(self.config.filenameDBGE).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameDBGE,
                                    self.config.filenameMeanRatesDBGE,
                                    self.config.filenameSTDRatesDBGE,
                                    self.config.filenameMeanCVDBGE,
                                    self.config.filenameMeanFanoDBGE,
                                    self.config.neuronsDBGE,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        if (
            os.path.isfile(self.config.filenameDBGI) and
            os.stat(self.config.filenameDBGI).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameDBGI,
                                    self.config.filenameMeanRatesDBGI,
                                    self.config.filenameSTDRatesDBGI,
                                    self.config.filenameMeanCVDBGI,
                                    self.config.filenameMeanFanoDBGI,
                                    self.config.neuronsDBGI,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

    def plot_all(self):
        """Plot them all."""
        self.__get_firing_rates_from_spikes()
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

    def __plot_using_gnuplot_binary(self):
        """Use the binary because it doesnt support py3."""
        args = (os.path.join(
            self.config.postprocessHome,
            self.config.gnuplotFilesDir,
            'plot-firing-rates.plt'))
        subprocess.call(['gnuplot',
                         args])

if __name__ == "__main__":
    runner = timeGraphPlotter()
