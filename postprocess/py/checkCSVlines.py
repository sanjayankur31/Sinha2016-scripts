#!/usr/bin/env python3
"""
Check CSV files and list out bad lines.

Taken from http://stackoverflow.com/a/33999136/375067.

File: checkCSVlines.py

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


import csv
with open("../01-calcium-E-0.txt", 'r') as f:
    reader = csv.reader(f)
    linenumber = 1
    try:
        for row in reader:
            linenumber += 1
            print("Read {}".format(linenumber))
    except Exception as e:
        print (("Error line %d: %s %s" % (linenumber,
                                          str(type(e)), e.message)))
