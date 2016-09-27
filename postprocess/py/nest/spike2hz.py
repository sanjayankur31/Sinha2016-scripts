#!/usr/bin/env python3
"""
Take a nest gdf file with spike times and calculate mean firing rates.

File: spike2hz.py

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
import sys
import math
import pandas
import os.path
import gc
import collections


class spike2hz:

    """Main class for utlity.

    Nest gdf file format:

        <neuron gid>    <spike_time>

    Takes an entire spike file and generates the mean firing rate file to be
    used for time graphs.
    """

    def __init__(self):
        """Main init method."""
        self.input_filename = ""
        self.mean_rates_filename = ""
        self.std_rates_filename = ""
        self.mean_isicvs_filename = ""
        self.mean_isifanos_filename = ""
        self.usage = ("nest-spike2hz.py: generate mean firing rate file " +
                      "from spike file\n\n" +
                      "Usage: \npython3 nest-spike2hz.py " +
                      "input_filename mean_rates_filename std_rates_filename " +
                      "mean_isicvs_filename " +
                      "mean_isifanos_filename number_neurons" +
                      " rows")

        # Initial indices
        self.left = 0.
        self.right = 0.
        self.dt = 1.  # ms
        self.num_neurons = 8000.
        self.rows = 0.

    def setup(self, input_filename, mean_rates_filename, std_rates_filename,
              mean_isicvs_filename, mean_isifanos_filename, num_neurons=8000.,
              rows=0.):
        """Setup various things."""
        self.input_filename = input_filename
        self.std_rates_filename = std_rates_filename
        self.mean_rates_filename = mean_rates_filename
        self.mean_isicvs_filename = mean_isicvs_filename
        self.mean_isifanos_filename = mean_isifanos_filename
        self.rows = rows
        self.mean_rates_file = open(self.mean_rates_filename, 'w')
        self.std_rates_file = open(self.std_rates_filename, 'w')
        self.mean_isicvs_file = open(self.mean_isicvs_filename, 'w')
        self.mean_isifanos_file = open(self.mean_isifanos_filename, 'w')
        self.num_neurons = int(num_neurons)

        if not (
            os.path.exists(self.input_filename) and
            os.stat(self.input_filename).st_size > 0
        ):
            print("File not found. Skipping.", file=sys.stderr)
            return False

        return True

    def __validate_input(self, dataframe):
        """Check to see the input file is a two column file."""
        if dataframe.shape[1] != 2:
            print("Data seems incorrect - should have 2 columns. " +
                  "Please check and re-run", file=sys.stderr)
            return False
        else:
            print("Read " + str(dataframe.shape[0]) +
                  " rows.")
            return True

    def run(self):
        """Do the work."""
        start_row = 0
        current_time = 1000.
        old_neuronIDs = numpy.array([])
        old_times = numpy.array([])
        for chunk in pandas.read_csv(self.input_filename, sep='\s+',
                                     names=["neuronID",
                                            "spike_time"],
                                     dtype={'neuronID': numpy.uint16,
                                            'spike_time': float},
                                     lineterminator="\n",
                                     skipinitialspace=True,
                                     header=None, index_col=None,
                                     chunksize=self.rows):

            if not self.__validate_input(chunk):
                print("Error in file. Skipping.", file=sys.stderr)
                return False

            neuronIDs = numpy.array(chunk.values[:, 0])
            times = numpy.array(chunk.values[:, 1])

            # 200 neuronIDs per second = 2 neuronIDs per 0.01 second (dt) per
            # neuron this implies 2 * 10000 neuronIDs for 10000 neurons need
            # to be kept to make sure I have a proper sliding window of
            # chunks
            if len(old_neuronIDs) > 0:
                neuronIDs = numpy.append(old_neuronIDs, neuronIDs)
                times = numpy.append(old_times, times)

            print(
                "Times from {} to {} being analysed containing {} rows".format(
                    times[0], times[-1], len(times)))
            print("Current time is {}".format(current_time))

            # Reset chunks
            self.left = 0
            self.right = 0

            while (current_time < math.floor(times[-1])):
                self.left += numpy.searchsorted(times[self.left:],
                                                (current_time - 1000.),
                                                side='left')
                self.right = self.left + numpy.searchsorted(
                    times[self.left:], current_time,
                    side='right')

                thiswindow_neuronIDs = neuronIDs[self.left:self.right]
                thiswindow_times = times[self.left:self.right]

                # mean firing rate
                # total neuronIDs by number of neurons
                statement = ("{}\t{}\n".format(
                    current_time/1000.,
                    (
                        len(thiswindow_neuronIDs)/self.num_neurons)))

                self.mean_rates_file.write(statement)
                self.mean_rates_file.flush()

                # STD of firing rates and ISI cv once every 200 seconds - it
                # just takes way too much time - my post processing wont
                # finish.
                if (current_time % 200000 == 0):
                    # STD of firing rates
                    firing_rates = collections.Counter(thiswindow_neuronIDs).values()
                    missing_neurons = self.num_neurons - len(firing_rates)
                    for entries in range(0, missing_neurons):
                        firing_rates.append(0)

                    statement = ("{}\t{}\n".format(
                        current_time/1000.,
                        numpy.std(firing_rates)))

                    self.std_rates_file.write(statement)
                    self.std_rates_file.flush()

                    # ISI stats
                    neurons = set(thiswindow_neuronIDs)
                    print("{} neurons being analysed.".format(len(neurons)))
                    # for all neurons in this window
                    isi_cvs = []
                    isi_fanos = []
                    for neuron in list(neurons):
                        indices = [i for i, x in enumerate(thiswindow_neuronIDs) if x == neuron]
                        neuron_times = [thiswindow_times[i] for i in indices]

                        isis = []
                        if len(neuron_times) > 1:
                            # otherwise ISI is undefined in this window for
                            # this neuron
                            prev = neuron_times[0]
                            # get a list of ISIs
                            for neuron_time in neuron_times:
                                isis.append(neuron_time - prev)
                                prev = neuron_time

                            # for this neuron, get stats
                            isi_mean = numpy.mean(isis)
                            isi_std = numpy.std(isis)
                            isi_cv = isi_std/isi_mean
                            isi_fano = isi_std**2/isi_mean

                            isi_cvs.append(isi_cv)
                            isi_fanos.append(isi_fano)

                    statement = ("{}\t{}\n".format(
                        current_time/1000.,
                        numpy.mean(isi_cvs)))
                    self.mean_isicvs_file.write(statement)
                    self.mean_isicvs_file.flush()

                    statement = ("{}\t{}\n".format(
                        current_time/1000.,
                        numpy.mean(isi_fanos)))
                    self.mean_isifanos_file.write(statement)
                    self.mean_isifanos_file.flush()

                current_time += self.dt

            print("Printed till {}".format(current_time))
            old_times = numpy.array(times[(self.left - len(times)):])
            old_neuronIDs = numpy.array(neuronIDs[(self.left - len(neuronIDs)):])

            del neuronIDs
            del times
            gc.collect()

        self.mean_rates_file.close()
        self.std_rates_file.close()
        self.mean_isicvs_file.close()
        self.mean_isifanos_file.close()

    def print_usage(self):
        """Print usage."""
        print(self.usage, file=sys.stderr)

if __name__ == "__main__":
    converter = spike2hz()
    if len(sys.argv) == 5:
        converter.setup(str(sys.argv[1]), str(sys.argv[2]),
                        str(sys.argv[3]), str(sys.argv[4]),
                        int(sys.argv[3]), int(sys.argv[4]))
        print("Processing ...")
        converter.run()
        print("Finished ...")
    else:
        print("Incorrect arguments.", file=sys.stderr)
        print(file=sys.stderr)
        converter.print_usage()
