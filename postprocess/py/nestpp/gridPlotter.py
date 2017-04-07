#!/usr/bin/env python3
"""
Generate grid plots for a given set of neurons.

File: gridPlotter.py

Copyright 2016 Ankur Sinha
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


import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


class gridPlotter():

    """Plot firing rates in spatial grids."""

    def __init__(self):
        """Initialise."""
        self.rows = 100
        self.columns = 100

    def setup(self, optiondicts, rows, columns):
        """Set up plotter."""
        self.rows = rows
        self.columns = columns

    def run(self, timelist):
        """Plot graphs."""
