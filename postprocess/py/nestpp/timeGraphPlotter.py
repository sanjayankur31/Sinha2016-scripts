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
import numpy


class timeGraphPlotter:

    """Plot the main time graphs."""

    def __init__(self, config):
        """Initialise."""
        self.config = config

    def get_firing_rates_from_spikes(self):
        """Get firing rate files from spikes."""
        from nestpp.spike2hz import spike2hz
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
            os.path.isfile(self.config.filenameLPZE) and
            os.stat(self.config.filenameLPZE).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameLPZE,
                                    self.config.filenameMeanRatesLPZE,
                                    self.config.filenameSTDRatesLPZE,
                                    self.config.filenameMeanCVLPZE,
                                    self.config.filenameMeanFanoLPZE,
                                    self.config.neuronsLPZE,
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
            os.path.isfile(self.config.filenameLPZI) and
            os.stat(self.config.filenameLPZI).st_size != 0
        ):
            spikeconverter = spike2hz()
            if spikeconverter.setup(self.config.filenameLPZI,
                                    self.config.filenameMeanRatesLPZI,
                                    self.config.filenameSTDRatesLPZI,
                                    self.config.filenameMeanCVLPZI,
                                    self.config.filenameMeanFanoLPZI,
                                    self.config.neuronsLPZI,
                                    self.config.rows_per_read):
                spikeconverter.run()
            del spikeconverter

        # various pattern related spike files
        numpats = self.config.numpats
        for i in range(1, numpats + 1):
            neuronsP = len(numpy.loadtxt(
                self.config.neuronListPrefixP + str(i) + ".txt",
                delimiter='\t'))
            neuronsB = len(numpy.loadtxt(
                self.config.neuronListPrefixB + str(i) + ".txt",
                delimiter='\t'))
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
                    neuronsB,
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
                    neuronsP,
                    self.config.rows_per_read
                ):
                    spikeconverter.run()
                del spikeconverter

    def plot_all(self):
        """Plot them all."""
        print("Generating graphs.")
            self.__plot_using_gnuplot_binary()

    def __plot_using_gnuplot_binary(self):
        """Use the binary because it doesnt support py3."""
        numpats = self.config.numpats
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
    runner.get_firing_rates_from_spikes()
    runner.plot_all()
