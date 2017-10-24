#!/usr/bin/env python3
"""
Common fixtures for tests.

File: conftest.py

TODO: Could probably add more functions here, for example ones that generate
temporary spike files and so on.


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


import pytest
import os
import glob


@pytest.fixture(scope="module")
def module_setup(request):
    """Fixtures for the module."""
    def clean_up():
        """Clean up generated temporary files."""
        graphs = glob.glob("./*.png")
        spike_files = glob.glob("./*.gdf")

        for f in graphs + spike_files:
            os.remove(f)

    request.addfinalizer(clean_up)
    return True
