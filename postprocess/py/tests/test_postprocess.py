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

from postprocess import Postprocess


class TestPostprocessor:

    """Test the main work horse class"""

    def test_gnuplotter(self):
        """Test the gnuplotter method.  """
        master = Postprocess()
        master.cfg.gnuplot_files_dir = "./tests/"
        master.cfg.postprocess_home = "./"

        assert master.plot_using_gnuplot_binary(
            plt_file="this_file_does_not_exist.plt") != 0
        assert master.plot_using_gnuplot_binary(
            plt_file="test_gnuplot_good.plt") == 0
        assert master.plot_using_gnuplot_binary(
            plt_file="test_gnuplot_bad.plt") != 0
