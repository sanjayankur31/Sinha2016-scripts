#!/usr/bin/env python3
"""
Test methods dealing with spike data

File: test_spikes.py

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


import random
import os
from nestpp.spikes import (get_firing_rate_metrics, extract_spikes)


class TestSpikes:

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

        assert(os.path.exists("mean-firing-rates-test.txt") is True)
        assert(os.path.exists("std-firing-rates-test.txt") is True)
        assert(os.path.exists("ISI-cv-test.txt") is True)

        os.remove("spikes-test.gdf")
        os.remove("mean-firing-rates-test.txt")
        os.remove("std-firing-rates-test.txt")
        os.remove("ISI-cv-test.txt")

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
