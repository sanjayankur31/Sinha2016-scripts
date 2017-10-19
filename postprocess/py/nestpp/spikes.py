#!/usr/bin/env python3
"""
Functions that process spike files.

File: nestpp/spikes.py

Copyright 2017 Ankur Sinha
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

# system imports
import numpy
import math
import pandas
import gc
import os
import collections

# local imports
from nestpp.loggerpp import get_module_logger


lgr = get_module_logger(__name__)


def get_firing_rate_metrics(neuronset, spikes_fn, num_neurons=8000.,
                            rows=50000000.):
    """Get various metrics from raster spike files.

    :neuronset: name of neuron set being looked at
    :spikes_fn: file name of spikes file
    :num_neurons: number of neurons in neuron set
    :rows: rows to be read in each pandas chunk
    :returns: True if everything went OK, else False

    """
    # Initial indices
    left = 0.
    right = 0.
    dt = 1.  # ms

    num_neurons = int(num_neurons)
    # start at 50 ms
    current_time = 50.
    old_neuronIDs = numpy.array([])
    old_times = numpy.array([])
    lgr.info("Processing {}.".format(spikes_fn))
    if not os.path.exists(spikes_fn):
        lgr.error("File not found {}".format(spikes_fn))
        return False

    with open("mean-firing-rates-{}.txt".format(neuronset), 'w') as fh1, \
            open("std-firing-rates-{}.txt".format(neuronset), 'w') as fh2, \
            open("ISI-cv-{}.txt".format(neuronset), 'w') as fh3:

        for chunk in pandas.read_csv(spikes_fn, sep='\s+',
                                     names=["neuronID",
                                            "spike_time"],
                                     dtype={'neuronID': numpy.uint16,
                                            'spike_time': float},
                                     lineterminator="\n",
                                     skipinitialspace=True,
                                     header=None, index_col=None,
                                     skip_blank_lines=True,
                                     chunksize=rows):

            # Drop rows with nan
            chunk = chunk.dropna(how='any')
            if not validate_raster_df(chunk):
                lgr.error("Error in {}. Skipping.".format(spikes_fn))
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

            lgr.debug(
                "Times from {} to {} being analysed containing {} rows".format(
                    times[0], times[-1], len(times)))

            lgr.debug("Current time is {}".format(current_time))

            # Reset chunks
            left = 0
            right = 0

            while (current_time < math.floor(times[-1])):
                left += numpy.searchsorted(times[left:],
                                           (current_time - 1000.),
                                           side='left')
                right = left + numpy.searchsorted(
                    times[left:], current_time,
                    side='right')

                # point is lesser than the first value in the chunk
                if right == 0 and left == 0:
                    lgr.warning("Point too small for chunk")
                    current_time = times[0]
                    lgr.warning("Time to reset to: {}".format(times[0]))
                    continue

                # interval not found, no spikes - not necessarily at max
                # the max check is in the while condition, and that
                # ascertains if a new chunk should be read
                if right == left:
                    current_time = times[left]
                    continue

                # could even just do right - left if all I'm using is len
                thiswindow_neuronIDs = neuronIDs[left:right]
                thiswindow_times = times[left:right]

                # mean firing rate
                spikesnum = float(len(thiswindow_neuronIDs))
                # total neuronIDs by number of neurons
                print(
                    "{}\t{}".format(current_time/1000.,
                                    (spikesnum/num_neurons)),
                    file=fh1, flush=True)

                # STD of firing rates and ISI cv - it
                # just takes way too much time - my post processing wont
                # finish.
                if (current_time % 200000 == 0):
                    # STD of firing rates
                    # take 5 milli second bins of this 1 second bin
                    # find firing rates for each bin
                    # get std of these 200 values
                    bin5rates = []
                    bin5left = 0
                    bin5right = 0
                    bin5time = thiswindow_times[0]
                    while bin5time < math.floor(thiswindow_times[-1] - 5.):
                        bin5left += numpy.searchsorted(
                            thiswindow_times[bin5left:], bin5time, side="left")
                        bin5right = bin5left + numpy.searchsorted(
                            thiswindow_times[bin5left:], bin5time + 5.,
                            side="right")
                        bin5neurons = thiswindow_neuronIDs[bin5left:bin5right]

                        # multiplied by 200 to get firing rate per second as
                        # Hertz since bins are 5ms each
                        firing_rate = (float(len(bin5neurons)) *
                                       200./num_neurons)
                        bin5rates.append(firing_rate)
                        bin5time = bin5time + dt

                    lgr.debug("std being calculated from {} values".format(
                        len(bin5rates)))
                    print(
                        "{}\t{}".format(current_time/1000.,
                                        numpy.std(bin5rates)),
                        file=fh2, flush=True)

                    # ISI stats
                    neurons = set(thiswindow_neuronIDs)
                    if len(neurons) == 0:
                        lgr.warning("No neurons found in window. Skipping")
                    else:
                        lgr.debug("{} neurons being analysed.".format(
                            len(neurons)))
                        # for all neurons in this window
                        ISI_cvs = []
                        for neuron in list(neurons):
                            indices = [i for i, x
                                       in enumerate(thiswindow_neuronIDs)
                                       if x == neuron]
                            neuron_times = [thiswindow_times[i] for i in
                                            indices]

                            ISIs = []
                            if len(neuron_times) > 1:
                                # otherwise ISI is undefined in this window for
                                # this neuron
                                prev = neuron_times[0]
                                # get a list of ISIs
                                for neuron_time in neuron_times:
                                    ISIs.append(neuron_time - prev)
                                    prev = neuron_time

                                # for this neuron, get stats
                                ISI_mean = numpy.mean(ISIs)
                                ISI_std = numpy.std(ISIs)
                                ISI_cv = ISI_std/ISI_mean

                                if not numpy.isnan(ISI_cv):
                                    ISI_cvs.append(ISI_cv)

                        print(
                            "{}\t{}".format(current_time/1000.,
                                            numpy.mean(ISI_cvs)),
                            file=fh3, flush=True)

                current_time += dt

            lgr.debug("Printed till {}".format(current_time))
            old_times = numpy.array(times[(left - len(times)):])
            old_neuronIDs = numpy.array(neuronIDs[(left - len(neuronIDs)):])

            del neuronIDs
            del times
            gc.collect()

    lgr.info("Finished processing {}".format(spikes_fn))
    return True


def get_individual_firing_rate_snapshots(neuronset, spikes_fn, num_neurons,
                                         timelist, rows=50000000):
    """Get firing rates for individual neurons at a particular point in time.

    This information is used to generate histograms, for example.

    :neuronset: name of neuron set
    :spikes_fn: name of spikes file
    :timelist: list of times for which snapshots will be generated
    :returns: True if everything went OK, else False

    """
    sorted_timelist = numpy.sort(timelist)

    current = 0
    old_spikes = numpy.array([])
    old_times = numpy.array([])
    start = 0.
    end = 0.

    lgr.info("Reading spikes file {}".format(spikes_fn))
    for chunk in pandas.read_csv(spikes_fn, sep='\s+',
                                 names=["neuronID",
                                        "spike_time"],
                                 dtype={'neuronID': numpy.uint16,
                                        'spike_time': float},
                                 lineterminator="\n",
                                 skipinitialspace=True,
                                 header=None, index_col=None,
                                 chunksize=rows):

        if not validate_raster_df(chunk):
            lgr.error("Error in file. Skipping.")
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

        lgr.debug(
            "Times from {} to {} being analysed containing {} rows".format(
                times[0], times[-1], len(times)))

        while True:
            time = sorted_timelist[current]
            lgr.debug("Looking for {}.".format(time))
            time *= 1000.

            # Find our values
            start = numpy.searchsorted(times,
                                       time - 1000.,
                                       side='left')
            end = numpy.searchsorted(times,
                                     time,
                                     side='right')
            # Not found at all, don't process anything
            if start == len(times):
                lgr.debug("Neurons not found, reading next chunk.")
                break
            elif start < len(times) and end == len(times):
                lgr.debug("Found a boundary - reading another chunk.")
                break
            else:
                neurons = spikes[start:end]
                rates = collections.Counter(neurons)
                lgr.debug("Neurons found: {}".format(len(rates)))

                # Fill up missing neurons
                for i in range(1, num_neurons + 1):
                    if i not in rates:
                        rates[i] = 0
                lgr.debug("Neurons after appending zeros: {}".format(
                    len(rates)))

                o_fn = "firing-rate-{}-{}.gdf".format(
                    neuronset, time)
                lgr.info("Printing neuronal firing rate values to {}".format(
                    o_fn))

                with open(o_fn, 'w') as fh:
                    for nrn in rates:
                        print("{}\t{}".format(nrn, rates[nrn]), file=fh)

                current += 1
                if current >= len(sorted_timelist):
                    break

        if current >= len(sorted_timelist):
            break
        if start < len(times):
            old_times = numpy.array(times[(start - len(times)):])
            old_spikes = numpy.array(spikes[(start - len(spikes)):])

        del spikes
        del times
        gc.collect()

    return True


def validate_raster_df(dataframe):
    """Check to see the input file is a two column file.

    :dataframe: dataframe to validate
    :returns: True if valid, False otherwise

    """
    if dataframe.shape[1] != 2:
        lgr.error("Data seems incorrect - should have 2 columns. " +
                  "Please check and re-run")
        return False
    else:
        lgr.info("Read " + str(dataframe.shape[0]) +
                 " rows.")
        return True
