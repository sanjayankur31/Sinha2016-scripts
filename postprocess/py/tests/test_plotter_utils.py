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
import random
import pytest

# module imports
from nestpp.plotting_utils import (plot_using_gnuplot_binary,
                                   plot_location_grid, plot_rasters)


@pytest.mark.usefixtures("module_setup")
class TestPlottingUtils:

    """Test utility plotting functions."""

    def test_binary_gnuplotter(self):
        """Test the gnuplotter method.  """
        plots_dir = "tests/"
        assert plot_using_gnuplot_binary(
            plt_file=plots_dir+"this_file_does_not_exist.plt") != 0
        assert plot_using_gnuplot_binary(
            plt_file=plots_dir+"test_gnuplot_good.plt") == 0
        assert plot_using_gnuplot_binary(
            plt_file=plots_dir+"test_gnuplot_bad.plt") != 0

    def test_location_plotter(self):
        """Test neuron location plotter."""
        graphdict = {}
        location_list = []
        for i in range(0, 100):
            location_list.append([i, random.randrange(1, 100),
                                  random.randrange(1, 100)])
        graphdict['E'] = location_list

        for i in range(0, 50):
            location_list.append([i, random.randrange(1, 50),
                                  random.randrange(1, 50)])
        graphdict['I'] = location_list

        assert plot_location_grid(graphdict) is True

    def test_raster_plotter(self):
        """Test raster plotter."""
        neuron_dict = {
            'E': [0, 800],
            'I': [801, 1000]
        }
        snapshot_time = 3.

        with open('spikes-E-3.0.gdf', 'w') as f:
            t = 2.001
            for i in range(0, 1000):
                for j in range(0, 50):
                    print("{}\t{}".format(
                        random.randrange(0, 800), t),
                          file=f)
                t += 0.001
        with open('spikes-I-3.0.gdf', 'w') as f:
            t = 2.001
            for i in range(0, 1000):
                for j in range(0, 50):
                    print("{}\t{}".format(
                        random.randrange(801, 1000), t),
                          file=f)
                t += 0.001

        assert(plot_rasters(neuron_dict, snapshot_time) is True)

        neuron_dict = {
            'A': [801, 1000],
            'B': [0, 800],
        }
        snapshot_time = 5.5
        with open('spikes-A-5.5.gdf', 'w') as f:
            t = 5.001
            for i in range(0, 1000):
                for j in range(0, 50):
                    print("{}\t{}".format(
                        random.randrange(801, 1000), t),
                          file=f)
                t += 0.001
        with open('spikes-B-5.5.gdf', 'w') as f:
            t = 4.501
            for i in range(0, 1000):
                for j in range(0, 50):
                    print("{}\t{}".format(
                        random.randrange(0, 800), t),
                          file=f)
                t += 0.001

        assert(plot_rasters(neuron_dict, snapshot_time, proportion=0.5) is
               True)
