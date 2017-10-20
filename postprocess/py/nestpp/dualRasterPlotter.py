#!/usr/bin/env python3
"""
Plot raster of two sets of neurons. Called from postprocess.py.

File: dualRasterPlotter.py

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
import pandas
import gc
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os
import sys


class dualRasterPlotter:

    """Plot raster of two sets of neurons."""

    def __init__(self):
        """Initialise."""
        self.filename1 = ""
        self.filename2 = ""
        self.neurons1 = 0
        self.neurons2 = 0

    def setup(self, set1, set2, num_neurons1, num_neurons2,
              rows=100000):
        """Setup things."""
        self.set1 = set1
        self.set2 = set2
        self.num_neurons1 = int(num_neurons1)
        self.num_neurons2 = int(num_neurons2)
        self.rows = int(rows)

        self.filename1 = "spikes-" + set1 + ".gdf"
        self.filename2 = "spikes-" + set2 + ".gdf"

        return True

    def run(self, timelist):
        """Main runner method to be used for command line invocation."""
        sorted_timelist = numpy.sort(timelist)

        self.print_spikes(sorted_timelist, self.filename1, self.set1)
        self.print_spikes(sorted_timelist, self.filename2, self.set2)

        self.plot_rasters(sorted_timelist)

    def plot_rasters(self, timelist):
        """Plot the rater."""
        for time in timelist:
            matplotlib.rcParams.update({'font.size': 30})
            plt.figure(num=None, figsize=(32, 18), dpi=80)
            plt. xlabel("Neurons")
            plt.ylabel("Time (ms)")
            plt.xticks(numpy.arange(0, 10020, 1000))

            filename1 = ("spikes-" + self.set1 + "-" + str(time) + ".gdf")
            filename2 = ("spikes-" + self.set2 + "-" + str(time) + ".gdf")

            if not (
                os.path.exists(filename1) and
                os.stat(filename1).st_size > 0
            ):
                print("{} not found. Skipping.".format(filename1),
                      file=sys.stderr)
                return False

            if not (
                os.path.exists(filename2) and
                os.stat(filename2).st_size > 0
            ):
                print("{} not found. Skipping.".format(filename2),
                      file=sys.stderr)
                return False

            neurons1DF = pandas.read_csv(filename1, sep='\s+',
                                         lineterminator="\n",
                                         skipinitialspace=True,
                                         header=None, index_col=None)
            neurons1 = neurons1DF.values
            neurons2DF = pandas.read_csv(filename2, sep='\s+',
                                         lineterminator="\n",
                                         skipinitialspace=True,
                                         header=None, index_col=None)
            neurons2 = neurons2DF.values
            # Don't need to shift them - already numbered nicely

            plt.plot(neurons1[:, 0], neurons1[:, 1], ".", markersize=0.6,
                     label=self.set1)
            plt.plot(neurons2[:, 0], neurons2[:, 1], ".", markersize=0.6,
                     label=self.set2)

            plt.title("Raster for " + self.set1 + " and " +
                      self.set2 + " at time " + str(time))
            output_filename = ("raster-" + self.set1 + "-" + self.set2 + "-"
                               + str(time) + ".png")

            print("Storing {}".format(output_filename))
            plt.legend(loc="upper right")
            plt.savefig(output_filename)
            plt.close()

        return True
