#!/usr/bin/env python3
"""
Find max cols in a CSV file with varying columns per line.

File: getMaxCols.py

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

import sys
from io import StringIO
import csv


def run(filename):
    """Run."""
    maxcols = 0
    content = ""
    with open(filename, 'r') as f:
        content = csv.reader(f)
        linenumber = 1
        for line in content:
            linenumber += 1
            if len(line) > maxcols:
                maxcols = len(line)
        print("{}: {}".format(filename, maxcols))


if __name__ == "__main__":
    if len(sys.argv) == 2:
        run(sys.argv[1])
