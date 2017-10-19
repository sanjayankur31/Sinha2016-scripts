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
from nestpp.spikes import get_firing_rate_metrics


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

        os.remove("spikes-test.gdf")
        os.remove("mean-firing-rates-test.txt")
        os.remove("std-firing-rates-test.txt")
        os.remove("ISI-cv-test.txt")
