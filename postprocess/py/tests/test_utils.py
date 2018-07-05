#!/usr/bin/env python3
"""
Enter one line description here.

File:

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
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
