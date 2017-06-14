#!/usr/bin/env python3
"""
Plot grid firing rate snapshots.

File: gridRatePlotter.py

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


import glob
import numpy
import subprocess
import os


class gridRatePlotter:

    """
    Plot rate snapshots on location grids.

    It takes the firing rate files at particular times, attaches location
    information to them so that we can have a 3D matrix (x, y, rate) that
    gnuplot can then splot.
    """

    def __init__(self):
        """Initialise."""
        self.filelist = []
        self.locationFile = ""
        self.neuronLabel

    def setup(self, neuronLabel, locationFile):
        """Set up for plotting."""
        self.filelist = glob.glob("firing-rate-" + neuronLabel + "-*.gdf")
        self.locationFile = locationFile
        self.neuronLabel = neuronLabel
        self.filelist.sort()

    def run(self):
        """Plot em."""
        # locations use gids of neurons, and so do the firing rate files
        neuronLocations = numpy.loadtxt(self.locationFile, delimiter='\t')
        for i in range(0, len(self.filelist)):
            output = []
            data1 = numpy.loadtxt(self.filelist[i],
                                  delimiter='\t', dtype='float')
            datatime = (self.filelist[i]).replace(
                "firing-rate-" + self.neuronLabel, '')
            datatime = int(datatime.replace(".gdf", ''))
            ratelist = {}
            for nrn in data1:
                ratelist[data1[0]] = data1[1]

            for nrn in neuronLocations:
                rate = ratelist[nrn[0]]
                output.append([rate, int(nrn[1]), int(nrn[2])])

            outputfilename = ("snapshot-firing-rate-" + self.neuronLabel + "-" +
                              datatime + ".gdf")
            with open(outputfilename) as f:
                for n in output:
                    print("{}\t{}\t{}".format(n[0], n[1], n[2]), file=f)

            args = ['gnuplot', '-e', "plotname='{}'".format(
                        "snapshot-firing-rate-" + self.neuronLabel + "-" +
                        str(datatime) + ".png"),
                    '-e', 'plottitle={}'.format(
                        "'Firing rate snapshot of {} neurons at {}'".format(
                            self.neuronLabel, str(datatime))),
                    '-e', "inputfile='{}'".format(outputfilename),
                    os.path.join(
                        self.config.postprocessHome,
                        self.config.gnuplotFilesDir,
                        'plot-firing-rate-snapshots.plt')]
            subprocess.call(args)


if __name__ == "__main__":
    grp = gridRatePlotter()
    grp.setup('E', '00-neuron-locations-E.txt')
    grp.run()
