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
import random

# module imports
from nestpp.file_utils import (check_csv_file,
                               get_info_from_file_series,
                               combine_files_row_wise,
                               get_max_csv_cols)


@pytest.mark.usefixtures("module_setup")
class TestFileUtils:

    """Test utility functions."""
    def test_check_csv_file(self):
        """Test check_csv_file."""
        with open("good-csv.gdf", 'w') as f:
            for i in range(0, 100):
                print("{},{},{}".format(random.randrange(0, 10),
                                        random.randrange(0, 10),
                                        random.randrange(0, 10)),
                      file=f)
        assert check_csv_file("good-csv.gdf") is True
        # I can't remember what a bad CSV file was..

    def test_get_max_csv_cols(self):
        """Test get_max_csv_cols."""
        written_max_cols = 0
        with open("good-csv-cols.gdf", 'w') as f:
            for i in range(0, 100):
                spam = ["asdw"] * random.randrange(0, 20)
                if len(spam) > written_max_cols:
                    written_max_cols = len(spam)
                spam_string = ",".join(spam)
                print("{}".format(spam_string), file=f)

        assert get_max_csv_cols("good-csv-cols.gdf") is written_max_cols

    def test_get_info_from_file_series(self):
        """Test get_info_from_file_series function."""
        test_list = get_info_from_file_series("tests", "test_", ".py")
        assert('file_utils' in test_list)
        assert('test_file_utils.py' not in test_list)

    def test_combine_files_row_wise(self):
        """Test combining files row wise."""
        with open("row_combiner_test-1.gdf", 'w') as f:
            for i in range(0, 1000):
                print("{}\t{}".format(random.randrange(0, 800),
                                      random.randrange(0, 800)),
                      file=f)

        with open("row_combiner_test-2.gdf", 'w') as f:
            for i in range(0, 1000):
                print("{}\t{}".format(random.randrange(0, 800),
                                      random.randrange(0, 800)),
                      file=f)
        combined_dataframe = combine_files_row_wise(".",
                                                    "row_combiner_test-*.gdf",
                                                    '\t')
        assert combined_dataframe.shape[0] == 2000
        # 0th column  is the index column
        assert combined_dataframe.shape[1] == 1
