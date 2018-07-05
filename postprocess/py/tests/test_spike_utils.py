#!/usr/bin/env python3
"""
Test methods dealing with spike data

File: test_spikes.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import random
import os
from nestpp.spike_utils import (get_firing_rate_metrics, extract_spikes)


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
