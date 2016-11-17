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


class CombineFiles:

    """Combine files."""

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

        return filelist

    def combineCSVLists(self, directory, prefix):
        """
        Combine files.

        Format:
        time, comma separated values

        Returns:
        time, comma separated values concatenated from all files.
        """
        filelist = self.getFileList(directory, prefix)
        dataframes = []

        for entry in filelist:
            dataframe = pandas.read_csv(entry, skiprows=1, sep=',',
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        lineterminator='\n', header=None,
                                        index_col=0)

            dataframes.append(dataframe)

        combineddataframe = pandas.concat(dataframes, axis=1)
        return combineddataframe

    def combineTSVData(self, directory, prefix):
        """
        Combine files.

        The difference here is that the columns depict different things, unlike
        the csv lists in the other method.

        Format:
        time    info1   info2   info3   info4..

        Returns:
            time    sumoffiles(info1)   sumoffiles(info2)...
        """
        filelist = self.getFileList(directory, prefix)
        dataframes = []

        for entry in filelist:
            dataframe = pandas.read_csv(entry, skiprows=1, sep='\t',
                                        skipinitialspace=True,
                                        skip_blank_lines=True, dtype=float,
                                        lineterminator='\n', header=None,
                                        index_col=0)

            dataframes.append(dataframe)

        summeddf = dataframes.pop(0)
        for dataframe in dataframes:
            summeddf = summeddf.add(dataframe)

        return summeddf
