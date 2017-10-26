#!/usr/bin/env python3
"""
Test file related utility functions.

File: test_file_utils.py

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
from nestpp.file_utils import (get_info_from_file_series)


@pytest.mark.usefixtures("module_setup")
class TestFileUtils:

    """Test utility functions."""

    def test_get_info_from_file_series(self):
        """Test get_info_from_file_series function."""
        test_list = get_info_from_file_series("tests", "test_", ".py")
        assert('file_utils' in test_list)
        assert('test_file_utils.py' not in test_list)
