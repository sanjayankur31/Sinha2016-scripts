#!/usr/bin/env python3
"""
Test methods dealing with spike data

File: test_spikes.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import random
import numpy
import pandas
import filecmp
import os
from nestpp.spike_utils import (get_firing_rate_metrics, extract_spikes,
                                extract_subsets_from_spike_file)


class TestSpikeUtils:

    """Test methods processing spiking data."""

    def test_rate_getter(self):
        """Tests get_firing_rate_metrics function.

        Does not check correctness of maths at the moment.
        """
        num_neurons = 10
        start_time = 0.
        stop_time = 400001.

        with open("spikes-test.gdf", 'w') as f:
            spike_time = start_time
            while spike_time < stop_time:
                i = random.randrange(1, num_neurons)
                spike_time += random.randrange(0., 20.)

                print("{}\t{}".format(i, spike_time), file=f)

        get_firing_rate_metrics("test", "spikes-test.gdf", num_neurons, 500.)

        assert(os.path.exists("mean-firing-rates-test.gdf") is True)
        assert(os.path.exists("std-firing-rates-test.gdf") is True)
        assert(os.path.exists("ISI-cv-test.gdf") is True)

        os.remove("spikes-test.gdf")
        os.remove("mean-firing-rates-test.gdf")
        os.remove("std-firing-rates-test.gdf")
        os.remove("ISI-cv-test.gdf")

    def test_spike_extractor(self):
        """Test the spike extracter."""
        with open('spikes-Y.gdf', 'w') as f:
            t = 5001  # ms
            for i in range(0, 50000):
                for j in range(0, 10):
                    print("{}\t{}".format(
                        random.randrange(801, 1000), t),
                          file=f)
                t += 0.1

        assert(extract_spikes("Y", 'spikes-Y.gdf', [6.5, 7.5]) is True)
        assert(os.path.exists("spikes-Y-7.5.gdf") is True)
        assert(os.path.exists("spikes-Y-6.5.gdf") is True)

        os.remove("spikes-Y-7.5.gdf")
        os.remove("spikes-Y-6.5.gdf")
        os.remove("spikes-Y.gdf")

    def test_subset_extractor(self):
        """Test the subset extractor."""
        # 1000 gids in our set
        set_neurons_1 = [i for i in range(1, 1000)]
        set_neurons_2 = [i for i in range(1000, 2000)]

        spikes_to_be_extracted_1 = []
        spikes_to_be_extracted_2 = []
        spikes = []
        # Set up our dummy data
        for i in range(1, 5000):
            neuron = random.randint(1, 5000)
            if neuron < 1000:
                spikes_to_be_extracted_1.append([neuron, float(neuron)])
            elif neuron >= 1000 and neuron < 2000:
                spikes_to_be_extracted_2.append([neuron, float(neuron)])
            # second column should be spike time, but it doesn't matter for
            # this test, but make sure it's a float to ensure correct file
            # comparison later
            spikes.append([neuron, float(neuron)])

        spikes = numpy.array(spikes)
        numpy.savetxt("extractor-test-spike-file.gdf", spikes, delimiter='\t')

        extract_subsets_from_spike_file(
            [set_neurons_1, set_neurons_2],
            ['extractor-subset-test-1.gdf', 'extractor-subset-test-2.gdf'],
            'extractor-test-spike-file.gdf'
        )

        # Write it using pandas since that's how the function does it
        expected_df_1 = pandas.DataFrame(spikes_to_be_extracted_1)
        expected_df_1.to_csv("extractor-test-spike-file-expected-1.gdf",
                             sep="\t", header=None, index=None,)

        expected_df_2 = pandas.DataFrame(spikes_to_be_extracted_2)
        expected_df_2.to_csv("extractor-test-spike-file-expected-2.gdf",
                             sep="\t", header=None, index=None,)

        # check if this matches our count
        assert filecmp.cmp("extractor-test-spike-file-expected-1.gdf",
                           "extractor-subset-test-1.gdf",
                           shallow=False) is True
        assert filecmp.cmp("extractor-test-spike-file-expected-2.gdf",
                           "extractor-subset-test-2.gdf",
                           shallow=False) is True

        # Remove files
        os.remove("extractor-test-spike-file.gdf")
        os.remove("extractor-test-spike-file-expected-1.gdf")
        os.remove("extractor-test-spike-file-expected-2.gdf")
        os.remove("extractor-subset-test-1.gdf")
        os.remove("extractor-subset-test-2.gdf")
