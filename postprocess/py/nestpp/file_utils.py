"""
Utilities dealing with files.

File: file_utils.py


Note that we always use the 0th column as the index column, and we never
specify a header row while reading dataframes. This is a convention that must
be followed while using these functions.

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


import ast
import csv
import os
import pandas
import glob
import subprocess
from natsort import natsorted
from nestpp.loggerpp import get_module_logger
from nestpp.utils import input_with_timeout
import logging


lgr = get_module_logger(__name__, logging.INFO)


def check_csv_file(path):
    """Check a csv file for errors

    :path: path to file
    :returns: True if file is OK, False if not

    """
    with open(path, 'r') as f:
        reader = csv.reader(f)
        linenumber = 1
        try:
            for row in reader:
                linenumber += 1
        except Exception as e:
            lgr.error("Error line {}: {} {}".format(
                linenumber, str(type(e)), e.message))
            return False
    return True


def get_max_csv_cols(path):
    """Get maximum number of columns in a csv files with rows of varying column
    lengths.

    :path: path to file
    :returns: value of maximum number of columns in the file

    """
    maxcols = 0
    content = ""
    with open(path, 'r') as f:
        content = csv.reader(f)
        linenumber = 1
        for line in content:
            linenumber += 1
            if len(line) > maxcols:
                maxcols = len(line)
        lgr.info("{}: {}".format(path, maxcols))
    return maxcols


def combine_files_column_wise(directory, shell_glob, separator):
    """Combines columnar files with constant number of fields

    :directory: directory to work in
    :shell_glob: shell_glob of files
    :separator: field separator - usually ',' or '\t'
    :returns: combined dataframe or empty dataframe if files not found

    """
    combined_dataframe = pandas.DataFrame()
    file_list = glob.glob(os.path.join(directory, shell_glob))
    if not file_list:
        lgr.error("Files not found!")
        return combined_dataframe

    dataframes = []
    for fn in file_list:
        lgr.info("Reading {}".format(fn))
        try:
            dataframe = pandas.read_csv(fn, skiprows=1, sep=separator,
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        warn_bad_lines=True,
                                        lineterminator='\n', header=None,
                                        index_col=0, error_bad_lines=False)
        except pandas.errors.EmptyDataError as e:
            lgr.error("File empty: {}. Moving on".format(fn))
        else:
            dataframes.append(dataframe)

        lgr.info("Combined dataframe..")
        if dataframes:
            combined_dataframe = pandas.concat(dataframes, axis=1)

    return combined_dataframe


def var_combine_files_column_wise(directory, shell_glob, separator):
    """Combines columnar files with variable numbers of fields in each row.

    If the m input files are of all of the form:
    time, n field separated values

    then, this returns:
    time, (m x n) field separated values

    Note that each line may have a different number of columns, and lines with
    same index in different files may also have different numbers of columns.

    The last line of the file must say what the maximum number of columns in
    the file is. This is required by pandas to allocated the dataframe. So, the
    last line should be of the form:

    some unique marker, maxcols

    While processing, the line with this unique marker is dropped from the
    dataframe. I use -1, because in my files the index column is time, and
    cannot be negative.

    :directory: directory where files are
    :shell_glob: shell_glob of files
    :separator: field separator - usually ',' or '\t'
    :returns: combined dataframe or empty dataframe if files not found.

    """
    file_list = glob.glob(os.path.join(directory, shell_glob))
    if not file_list:
        return pandas.DataFrame()

    dataframes = []
    combined_dataframe = pandas.DataFrame()

    for fn in file_list:
        lgr.info("Reading {}".format(fn))
        # Last line contains the maximum number of fields in any line,
        # so use this to size our df. Pandas can manage lines shorter
        # than previous lines by using NA, but it cannot handle lines
        # longer and crashes

        # first, get the info from the file
        output = (subprocess.check_output(['tail', '-1', fn]))
        # decode byte string to utf8, then if it's tsv, replace it with a
        # comma to make it a set, then let ast.literal_eval convert it into
        # a set, the last value of which is the maxcols
        max_columns = ast.literal_eval(
            (output.decode("utf-8")).replace('\t', ', ')[:-1])[-1]
        lgr.debug("Max cols is: {}".format(max_columns))

        try:
            dataframe = pandas.read_csv(fn, skiprows=1, sep=separator,
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        warn_bad_lines=True,
                                        lineterminator='\n', header=None,
                                        names=range(0, max_columns),
                                        mangle_dupe_cols=True,
                                        index_col=0, error_bad_lines=False)
        except pandas.errors.EmptyDataError as e:
            lgr.error("File empty: {}. Moving on".format(fn))
        else:
            # Drop last row which isn't data, it's metadata
            lgr.debug("Read dataframe of shape: {}".format(
                dataframe.shape))
            lgr.debug("Dropping index : {}".format(
                dataframe.index[len(dataframe) - 1]))
            dataframe = dataframe.drop(dataframe.index[len(dataframe) - 1])
            lgr.debug("Dropped last row to get shape: {}".format(
                dataframe.shape))
            dataframe = dataframe.dropna(axis=1, how='all')
            lgr.debug("Dropped na values to get shape: {}".format(
                dataframe.shape))

            dataframes.append(dataframe)

    lgr.info("Combining dataframes..")
    if dataframes:
        combined_dataframe = pandas.concat(dataframes, axis=1)

    return combined_dataframe


def sum_columns_in_multiple_files(directory, shell_glob, separator):
    """Sums up the columns in different rank files.

    If the input files are each of the form:
    time    info1   info2   info3   info4..

    This will return a dataframe:
    time    sumoffiles(info1)   sumoffiles(info2)...


    :directory: the directory to act in
    :shell_glob: the shell_glob of the various files
    :separator: field separator - usually ',' or '\t'
    :returns: summed up dataframe or empty dataframe if files weren't found

    """
    summed_df = pandas.DataFrame()
    file_list = natsorted(glob.glob(os.path.join(directory, shell_glob)))
    if not file_list:
        return summed_df

    dataframes = []

    for fn in file_list:
        try:
            dataframe = pandas.read_csv(fn, skiprows=1, sep=separator,
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        warn_bad_lines=True,
                                        lineterminator='\n', header=None,
                                        index_col=0, error_bad_lines=False)
        except pandas.errors.EmptyDataError as e:
            lgr.error("File empty: {}. Moving on".format(fn))
        else:
            dataframes.append(dataframe)

    summed_df = dataframes.pop(0)
    for dataframe in dataframes:
        summed_df = summed_df.add(dataframe)

    return summed_df


def reprocess_raw_files(directory, shell_globs):
    """Ask if files should be reprocessed when generated files have been found.

    Contains a 15 second time out after which it returns True

    :directory: directory in which files reside
    :shell_globs: list of shell globs matching file names to look for
    :returns: True if yes, False if no

    """
    files_found = []
    for shell_glob in shell_globs:
        files_found += natsorted(glob.glob(os.path.join(directory, shell_glob)))

    if len(files_found) == 0:
        return True

    files_found.sort()
    if len(files_found) > 0:
        lgr.info("Generated files found: {}".format(len(files_found)))
        for entry in files_found:
            lgr.info("- {}".format(entry))

        while True:
            regen = input_with_timeout(
                "Regenerate(Y/N/y/n defaults to Y in 15 seconds)? ", 15.0)
            if regen == "N" or regen == "n":
                return False
            elif regen == "Y" or regen == "y":
                return True


def get_info_from_file_series(directory, prefix, suffix):
    """From a list of file names with the same prefixes and suffixes, extract
    the information sandwiched between the common prefix and common suffix.

    For example, a file may be named: calcium-1000.0.txt, so the series becomes
    calcium-<time>.txt, where the prefix_glob is "calcium-" and the suffix_glob
    is ".txt". The information returned will be a list of <time>s.

    :directory: directory in which files reside
    :prefix: prefix of files
    :suffix: suffix of files (eg, extension)
    :returns: list of info as strings, or empty list if files not found

    """
    info_list = []
    complete_prefix = os.path.join(directory, prefix)
    complete_glob = complete_prefix + "*" + suffix
    file_list = natsorted(glob.glob(complete_glob))

    for af in file_list:
        info_list.append(
            (af.replace(complete_prefix, '')).replace(suffix, '')
        )

    return natsorted(info_list)


def combine_files_row_wise(directory, shell_glob, separator):
    """Combine files with fixed fields row wise.

    :directory: directory in which files reside
    :shell_glob: shell_glob for files
    :separator: field separator - usually '\t', or ','
    :returns: concatenated data frame

    """
    dataframes = []
    resultant_df = pandas.DataFrame()
    file_list = natsorted(glob.glob(os.path.join(directory, shell_glob)))
    for fn in file_list:
        lgr.debug("Processing {}".format(fn))
        try:
            df = pandas.read_csv(
                fn, sep=separator, skipinitialspace=True,
                skiprows=1, skip_blank_lines=True, dtype=float,
                warn_bad_lines=True, lineterminator='\n',
                header=None, index_col=0,
                error_bad_lines=False
            )
        except pandas.errors.EmptyDataError as e:
            lgr.error("File empty: {}. Moving on".format(fn))
        else:
            dataframes.append(df)

    if dataframes:
        resultant_df = pandas.concat(dataframes, axis=0)
    return resultant_df
