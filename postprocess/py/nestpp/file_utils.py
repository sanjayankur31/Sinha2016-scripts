"""
Utilities dealing with files.

File: file_utils.py

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


import csv
import os
import pandas
import glob
import subprocess
from nestpp.loggerpp import get_module_logger
from nestpp.utils import input_with_timeout


lgr = get_module_logger(__name__)


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
                print("Read {}".format(linenumber))
        except Exception as e:
            print("Error line {}: {} {}".format(
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
        print("{}: {}".format(path, maxcols))
    return maxcols


def combine_tsv_files_column_wise(directory, shell_glob):
    """Combines tab separated files with constant number of fields

    :directory: directory to work in
    :shell_glob: shell_glob of files
    :returns: combined dataframe or empty dataframe if files not found

    """
    file_list = glob.glob('{}/{}'.format(directory, shell_glob))
    if not file_list:
        return {}

    combineddataframe = pandas.DataFrame()
    dataframes = []
    for entry in file_list:
        lgr.info("Reading {}".format(entry))
        dataframe = pandas.read_csv(entry, skiprows=1, sep='\t',
                                    skipinitialspace=True,
                                    skip_blank_lines=True, dtype=float,
                                    warn_bad_lines=True,
                                    lineterminator='\n', header=None,
                                    index_col=0, error_bad_lines=False)

        dataframes.append(dataframe)

        lgr.info("Combined dataframe..")
        combineddataframe = pandas.concat(dataframes, axis=0)

    return combineddataframe


def combine_var_csv_files_column_wise(directory, shell_glob):
    """Combines comma separated files with variable numbers of fields in each row.

    If the m input files are of all of the form:
    time, n comma separated values

    then, this returns:
    time, (m x n) comma separated values

    Note that each line may have a different number of columns, and lines with
    same index in different files may also have different numbers of columns.

    :directory: directory where files are
    :shell_glob: shell_glob of files
    :returns: combined dataframe or empty dataframe if files not found.

    """
    file_list = glob.glob('{}/{}'.format(directory, shell_glob))
    if not file_list:
        return pandas.DataFrame()

    dataframes = []

    for entry in file_list:
        lgr.info("Reading {}".format(entry))
        if os.stat(entry).st_size != 0:
            # Last line contains the maximum number of fields in any line,
            # so use this to size our df. Pandas can manage lines shorter
            # than previous lines by using NA, but it cannot handle lines
            # longer and crashes
            # Ignore ',\n'
            max_columns = int(float(
                subprocess.check_output(['tail', '-1', entry])[0:-2])) + 1
            lgr.debug("Max cols is: {}".format(max_columns))

            dataframe = pandas.read_csv(entry, skiprows=1, sep=',',
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        warn_bad_lines=True,
                                        lineterminator='\n', header=None,
                                        names=range(0, max_columns),
                                        mangle_dupe_cols=True,
                                        index_col=0, error_bad_lines=False)
            # Drop last row which isn't data, it's metadata
            dataframe = dataframe.drop(dataframe.index[len(dataframe) - 1])
            dataframe = dataframe.dropna(axis=1, how='all')

            dataframes.append(dataframe)
        else:
            lgr.warning("Skipping empty file, {}".format(entry))

    lgr.info("Combining dataframes..")
    combineddataframe = pandas.concat(dataframes, axis=1)

    return combineddataframe


def sum_columns_in_multiple_files(directory, shell_glob):
    """Sums up the columns in different rank files.

    If the input files are each of the form:
    time    info1   info2   info3   info4..

    This will return a dataframe:
        time    sumoffiles(info1)   sumoffiles(info2)...


    :directory: the directory to act in
    :shell_glob: the shell_glob of the various files
    :returns: summed up dataframe

    """
    file_list = glob.glob('{}/{}'.format(directory, shell_glob))
    if not file_list:
        return pandas.DataFrame()

    dataframes = []

    for entry in file_list:
        if os.stat(entry).st_size != 0:
            dataframe = pandas.read_csv(entry, skiprows=1, sep='\t',
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        warn_bad_lines=True,
                                        lineterminator='\n', header=None,
                                        index_col=0, error_bad_lines=False)

            dataframes.append(dataframe)
        else:
            lgr.warning("Skipping empty file, {}".format(entry))

    summeddf = dataframes.pop(0)
    for dataframe in dataframes:
        summeddf = summeddf.add(dataframe)

    return summeddf


def reprocess_raw_files(shell_globs):
    """Ask if files should be reprocessed when generated files have been found.

    Contains a 15 second time out after which it returns True

    :shell_globs: shell globs matching file names to look for
    :returns: True if yes, False if no

    """
    files_found = []
    for shell_glob in shell_globs:
        files_found.append(glob.glob("./{}".format(shell_glob)))

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
