#!/usr/bin/env python3
"""
Plot raster plots for multiple neuron sets.

File: rasterPlotter.py

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


import pandas
import random
import math
import numpy
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import sys


class rasterPlotter:

    """Converts spike time data and generates raster plots."""

    def __init__(self):
        """Init."""
        self.neuronOptions = [{}]  # list of dicts specify info about neurons
        self.scale = 0.1  # how many out of the total neuron set to plot
        self.rows = 100000  # how many rows to read at once
        self.window = 5  # for each time in timelist, take 5 second windows
        self.spikes = []

    def setup(self, optionDicts, scale=0.1, window=5):
        """Set up the converter."""
        self.scale = scale
        self.window = window
        if len(optionDicts) <= 0:
            print("No option dictionaries received..", file=sys.stderr)
            return False
        self.neuronOptions = optionDicts
        return self.__validate_dicts()

    def __validate_dicts(self):
        """Validate the option dicts."""
        expected_keys = ({'neuronSet', 'spikesFileName', 'neuronsFileName',
                         'neuronNum'})
        for adict in self.neuronOptions:
            if expected_keys != set(adict):
                return False
        return True

    def __get_neurons(self, adict):
        """Get a subset of neurons for each neuron set."""
        with open(adict['neuronsFileName']) as f:
            neurons = f.readlines()
            neurons = [neuron.strip() for neuron in neurons]
            neurons = random.sample(neurons,
                                    int(math.ceil(adict['neuronNum'] *
                                                  self.scale)))
            # add it to the main dict list, adict is a ref, this will work
            neurons = pandas.DataFrame(neurons, dtype=numpy.uint16,
                                       columns=['neuronID'])

        print('Got {} neurons from {}'.format(
            neurons.shape[0], adict['neuronsFileName']))
        return neurons

    def __get_spikes(self, adict, timelist):
        """Get spikes at required times for a neuron set."""
        spikesdict = {}
        current = 0
        old_spikes = numpy.array([])
        old_times = numpy.array([])

        for chunk in pandas.read_csv(adict['spikesFileName'], sep='\s+',
                                     names=["neuronID",
                                            "spike_time"],
                                     dtype={'neuronID': numpy.uint16,
                                            'spike_time': float},
                                     lineterminator="\n",
                                     skipinitialspace=True,
                                     header=None, index_col=None,
                                     chunksize=self.rows):

            if current == len(timelist):
                print("Processed all time values. Done.")
                break

            if not self.__validate_input(chunk):
                print("Error in file. Skipping.", file=sys.stderr)
                return False

            # Only if you find the item do you print, else you read the next
            # chunk. Now, if all chunks are read and the item wasn't found, the
            # next items cannot be in the file either, since we're sorting the
            # file
            spikes = numpy.array(chunk.values[:, 0])
            times = numpy.array(chunk.values[:, 1])

            # 200 spikes per second = 2 spikes per 0.01 second (dt) per neuron
            # this implies 2 * 10000 spikes for 10000 neurons need to be kept
            # to make sure I have a proper sliding window of chunks
            if len(old_spikes) > 0:
                spikes = numpy.append(old_spikes, spikes)
                times = numpy.append(old_times, times)

            while True:
                time = timelist[current]
                time *= 1000.

                # Find our values
                self.start = numpy.searchsorted(times,
                                                time - 1000.,
                                                side='left')
                self.end = numpy.searchsorted(times,
                                              time,
                                              side='right')
                # Not found at all, don't process anything
                if self.start == len(times):
                    break
                elif self.start < len(times) and self.end == len(times):
                    break
                else:
                    neurons = spikes[self.start:self.end]
                    spiketimes = [x/1000. for x in times[self.start:self.end]]
                    # print("Neurons and times found: {} {}".format(
                    #     len(neurons), len(spiketimes)))

                    # they'll have the same indexes.
                    neuronIDdf = pandas.DataFrame(
                        neurons, columns=['neuronID'], dtype=numpy.int16)
                    spiketimesdf = pandas.DataFrame(
                        spiketimes, columns=['spiketimes'], dtype=float)
                    resultdf = pandas.concat([neuronIDdf, spiketimesdf],
                                             axis='1', join='inner')
                    resultdf = resultdf.merge(
                        adict['neurons'], left_on='neuronID',
                        right_on='neuronID', how='inner')
                    spikesdict[timelist[current]] = resultdf

                    del neurons
                    del spiketimes

                    current += 1
                    if current == len(timelist):
                        break

            if self.start < len(times):
                old_times = numpy.array(times[(self.start - len(times)):])
                old_spikes = numpy.array(spikes[(self.start - len(spikes)):])

        return spikesdict

    def __validate_input(self, dataframe):
        """Check to see the input file is a two column file."""
        if dataframe.shape[1] != 2:
            print("Data seems incorrect - should have 2 columns. " +
                  "Please check and re-run", file=sys.stderr)
            return False
        else:
            return True

    def __plot_rasters(self, atime):
        """Plot rasters."""
        matplotlib.rcParams.update({'font.size': 20})
        plt.figure(num=None, figsize=(16, 9), dpi=80)
        plt.ylabel("Neurons")
        plt.xlabel("Time (s)")
        plt.title("Snapshot of spikes at " + str(atime) + " seconds")
        output_filename = ("raster-" + str(atime) + ".png")
        ax = plt.gca()
        ax.ticklabel_format(useOffset=False)

        numneurons = 1
        for adict in self.neuronOptions:
            dftoplot = (adict['spikes'])[atime]
            newvals = list(range(numneurons,
                                 numneurons + (adict['neurons']).shape[0],
                                 1))
            to_replace = list(((adict['neurons'])['neuronID']).values)
            dftoplot.replace(inplace=True,
                             to_replace=to_replace, value=newvals)
            plt.plot(dftoplot['spiketimes'].values,
                     dftoplot['neuronID'].values, ".", markersize=5,
                     label=adict['neuronSet'])
            plt.xticks(numpy.arange(atime - 1., atime + 0.001, 0.2))
            numneurons = numneurons + adict['neurons'].shape[0]

        plt.legend(loc="upper right")
        plt.savefig(output_filename)
        plt.close()

    def run(self, timelist):
        """Run."""
        expandedlist = []
        for time in timelist:
            expandedlist.extend(list(numpy.arange(time-2., time+2., 0.2)))
        timelist = numpy.sort(expandedlist)
        if len(timelist) <= 0:
            return False

        for adict in self.neuronOptions:
            adict['neurons'] = self.__get_neurons(adict)
            adict['spikes'] = self.__get_spikes(adict, timelist)

        for atime in timelist:
            self.__plot_rasters(atime)


if __name__ == "__main__":
    dictlist = [
        {
            'neuronSet': 'E',
            'spikesFileName': 'spikes-E.gdf',
            'neuronsFileName': 'excitatoryneurons.txt',
            'neuronNum': 8000
        },
        {
            'neuronSet': 'I',
            'spikesFileName': 'spikes-I.gdf',
            'neuronsFileName': 'inhibitoryneurons.txt',
            'neuronNum': 2000
        },
    ]

    plotter = rasterPlotter()
    plotter.setup(dictlist)
    timelist = [1990, 2005, 3990, 4005, 5990]
    plotter.run(timelist)
