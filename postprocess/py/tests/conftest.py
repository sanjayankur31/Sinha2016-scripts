#!/usr/bin/env python3
"""
Common fixtures for tests.

File: conftest.py

TODO: Could probably add more functions here, for example ones that generate
temporary spike files and so on.

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
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
        dir_util.copy_tree(test_dir, str(tmpdir))

    return tmpdir
