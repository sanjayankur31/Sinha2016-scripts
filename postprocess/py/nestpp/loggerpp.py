#!/usr/bin/env python3
"""
Create a logger for the whole module.

File: loggerpp.py

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

import logging


def get_module_logger(module_name, logging_level=logging.DEBUG):
    """Get a logger for the module.

    :module_name: name of the module
    :logging_level: logging level
    :returns: created logger

    """
    logging.basicConfig(level=logging_level)
    lgr = logging.getLogger(module_name)
    lgr.setLevel(logging_level)
    handler = logging.StreamHandler()
    handler.setLevel(logging_level)
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    lgr.addHandler(handler)

    return lgr
