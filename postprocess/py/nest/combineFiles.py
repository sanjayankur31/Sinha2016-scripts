#!/usr/bin/env python3
"""
Combine various files.

File: combineFiles.py

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


import pandas
from os import listdir
import re
from os.path import isfile, join
import subprocess


class CombineFiles:

    """Combine files."""

    def getTimedFileList(self, directory, prefix):
        """Get list of files for each snapshot time."""
        completefilelist = self.getFileList(directory, prefix)
        timelist = []

        for afile in completefilelist:
            filename = afile[len(directory):]
            time = (filename.split('-')[5])[0:-4]
            timelist.append(time)

        timelist = set(timelist)
        filedict = {}

        for afile in completefilelist:
            for time in timelist:
                if ("-" + time + ".txt") in afile:
                    if time in filedict:
                        filedict[time].append(afile)
                    else:
                        filedict[time] = [afile]

        if len(filedict) > 0:
            return filedict
        return None

    def getFileList(self, directory, prefix):
        """Get list of files with prefix."""
        directorylist = listdir(directory)
        prefixregex = re.compile(re.escape(prefix))
        filelist = []

        for entry in directorylist:
            fullentry = join(directory + '/' + entry)
            if isfile(fullentry):
                if(prefixregex.match(entry)):
                    filelist.append(fullentry)

        if len(filelist) > 0:
            return filelist
        return None

    def combineTimedTSVColDataFiles(self, directory, prefix):
        """Combine TSV files columnwise for different times."""
        filedict = self.getTimedFileList(directory, prefix)
        if not filedict:
            return None

        combineddataframelist = {}

        for time, filelist in filedict.items():
            dataframes = []
            for entry in filelist:
                print("Reading {}".format(entry))
                dataframe = pandas.read_csv(entry, skiprows=1, sep='\t',
                                            skipinitialspace=True,
                                            skip_blank_lines=True, dtype=float,
                                            warn_bad_lines=True,
                                            lineterminator='\n', header=None,
                                            index_col=0, error_bad_lines=False)

                dataframes.append(dataframe)

            print("Combined dataframe..")
            combineddataframe = pandas.concat(dataframes, axis=0)
            combineddataframelist[time] = combineddataframe.sort_index()

        return combineddataframelist

    def combineCSVRowLists(self, directory, prefix):
        """
        Combine comma separated files row wise.

        Each line may have a different number of fields.

        Format:
        time, comma separated values

        Returns:
        time, comma separated values concatenated from all files.
        """
        filelist = self.getFileList(directory, prefix)
        if not filelist:
            return None

        dataframes = []

        for entry in filelist:
            print("Reading {}".format(entry))
            # Last line contains the maximum number of fields in any line, so
            # use this to size our df. Pandas can manage lines shorter than
            # previous lines by using NA, but it cannot handle lines longer and
            # crashes
            # Ignore ',\n'
            max_columns = int(float(
                subprocess.check_output(['tail', '-1', entry])[0:-2])) + 1
            print("Max cols is: {}".format(max_columns))

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

        print("Combining dataframes..")
        combineddataframe = pandas.concat(dataframes, axis=1)

        return combineddataframe

    def combineTSVRowData(self, directory, prefix):
        """
        Combine tab separated files row wise.

        The difference here is that the columns depict different things, unlike
        the csv lists in the other method.

        Format:
        time    info1   info2   info3   info4..

        Returns:
            time    sumoffiles(info1)   sumoffiles(info2)...
        """
        filelist = self.getFileList(directory, prefix)
        if not filelist:
            return None

        dataframes = []

        for entry in filelist:
            dataframe = pandas.read_csv(entry, skiprows=1, sep='\t',
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        warn_bad_lines=True,
                                        lineterminator='\n', header=None,
                                        index_col=0, error_bad_lines=False)

            dataframes.append(dataframe)

        summeddf = dataframes.pop(0)
        for dataframe in dataframes:
            summeddf = summeddf.add(dataframe)

        return summeddf
