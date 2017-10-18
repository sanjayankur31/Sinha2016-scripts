#!/usr/bin/env python3
"""
Test the config parser.

It's really hard to test input. The test parser will have to do the checks.
Writing tests doesn't quite cut it.

File: test_config.py

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

from nestpp.utils import get_config


class TestConfig:

    """Test the config parser."""

    def test_graphlist(self):
        config = get_config("tests/config_test.ini")
        assert (bool(config) is not False)

        correct_graph_list = ['firing_rates', 'firing_rate_snapshots', 'grids',
                              'conductances', 'syn_elms',
                              'syn_turnover',
                              'syn_elms_snapshots',
                              'syn_turnover_snapshots', 'calciums',
                              'calcium_snapshots', 'histograms', 'snrs',
                              'rasters']

        assert (sorted(set(config['graphs'])) ==
                sorted(set(correct_graph_list)))

        wrong_graph_list = ['something_random', 'hark_more_random',
                            'syn_elms', 'syn_turnover',
                            'calcium_concentration', 'histograms', 'snr']

        assert (sorted(set(config['graphs'])) !=
                sorted(set(wrong_graph_list)))
