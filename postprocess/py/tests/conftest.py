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
from distutils import dir_util


@pytest.fixture(scope="module")
def module_setup(request):
    """Fixtures for the module.
    """
    def clean_up():
        """Clean up generated temporary files."""
        graphs = glob.glob("./*.png")
        spike_files = glob.glob("./*.gdf")

        for f in graphs + spike_files:
            os.remove(f)

    request.addfinalizer(clean_up)
    return True


@pytest.fixture(scope="function")
def datadir(tmpdir, request):
    """Fixtures for the module.

    This loads the data files from a folder that has the same name as the test
    file into a temporary directory to enable the tests to use them there.

    Taken from:
    https://stackoverflow.com/questions/29627341/pytest-where-to-store-expected-data
    """
    filename = request.module.__file__
    test_dir, _ = os.path.splitext(filename)

    if os.path.isdir(test_dir):
        dir_util.copy_tree(test_dir, bytes(tmpdir))

    return tmpdir
