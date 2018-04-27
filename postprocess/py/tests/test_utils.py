#!/usr/bin/env python3
"""
Enter one line description here.

File:

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
import pytest

# module imports
from nestpp.utils import (get_config)


@pytest.mark.usefixtures("module_setup")
class TestUtils:

    """Test utility functions."""

    def test_graphlist(self):
        config = get_config("tests/config_test.ini")
        assert (bool(config) is not False)

        correct_graph_list = ['firing_rates',
                              'conductances', 'syn_elms',
                              'syn_turnover',
                              'calciums', 'synapses']

        assert (sorted(set(config['time_graphs'])) ==
                sorted(set(correct_graph_list)))

        wrong_graph_list = ['something_random', 'hark_more_random',
                            'syn_elms', 'syn_turnover',
                            'calcium_concentration', 'firing_rate_histograms',
                            'synapses',
                            'snr']

        assert (sorted(set(config['time_graphs'])) !=
                sorted(set(wrong_graph_list)))
