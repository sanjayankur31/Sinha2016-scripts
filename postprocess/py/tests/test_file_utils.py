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
from nestpp.file_utils import (
    check_csv_file,
    get_max_csv_cols,
    combine_files_column_wise,
    var_combine_files_column_wise,
    sum_columns_in_multiple_files,
    combine_files_row_wise,
    get_info_from_file_series
)


@pytest.mark.usefixtures("module_setup")
class TestFileUtils:

    """Test file related utility functions."""
    def test_check_csv_file(self, datadir):
        """Test check_csv_file."""
        assert check_csv_file(datadir.join("good-csv.txt")) is True
        # I can't remember what a bad CSV file was..

    def test_get_max_csv_cols(self, datadir):
        """Test get_max_csv_cols."""
        # I know this, I generated the file
        written_max_cols = 19

        assert (get_max_csv_cols(datadir.join("max-csv-cols.txt")) is
                written_max_cols)

    def test_combine_files_column_wise(self, datadir):
        """Test combine_files_column_wise."""
        combined_dataframe = combine_files_column_wise(
            datadir, "col_combiner_test_*.txt", '\t')
        # first row is a header
        assert combined_dataframe.shape[0] == 999
        # 0th columns are the common index
        assert combined_dataframe.shape[1] == 2

    def test_var_combine_files_column_wise(self, datadir):
        """Test combine_files_column_wise."""
        combined_dataframe = var_combine_files_column_wise(
            datadir, "var_col_combiner_test_*.txt", '\t')
        # first row is a header
        assert combined_dataframe.shape[0] == 999
        # 0th columns are the common index
        assert combined_dataframe.shape[1] == 2

    def test_sum_columns_in_multiple_files(self, datadir):
        """Test sum_columns_in_multiple_files."""
        combined_dataframe = sum_columns_in_multiple_files(
            datadir, "col_summer_test*.txt", '\t')
        # first row is a header
        assert combined_dataframe.shape[0] == 999
        # 0th columns are the common index
        assert combined_dataframe.shape[1] == 1

        for index, value in combined_dataframe.iterrows():
            assert (int(value) == 2 * index)

    def test_get_info_from_file_series(self):
        """Test get_info_from_file_series function."""
        test_list = get_info_from_file_series("tests", "test_", ".py")
        assert('file_utils' in test_list)
        assert('test_file_utils.py' not in test_list)

    def test_combine_files_row_wise(self, datadir):
        """Test combining files row wise."""
        combined_dataframe = combine_files_row_wise(datadir,
                                                    "row_combiner_test_*.txt",
                                                    '\t')
        # first rows are headers
        assert combined_dataframe.shape[0] == 1998
        # 0th column  is the index column
        assert combined_dataframe.shape[1] == 1
