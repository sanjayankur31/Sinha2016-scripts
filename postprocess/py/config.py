#!/usr/bin/env python3
"""
Config postprocess variables.

File: config.py

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

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import configparser
import logging


class Config:

    """Config post process globals."""

    def __init__(self, taskfile='config.ini'):
        """Initialise."""
        self.graphlist = []

        # timelists
        self.histogram_times = [0.]
        self.snapshot_times = [0.]
        self.snr_times = [0.]
        self.raster_times = [0.]
        self.taskfile = taskfile

        # misc
        self.postprocessHome = ""
        self.gnuplotFilesDir = ""

        # prefixes
        self.spikes = ""
        self.conductances = ""
        self.calcium = ""
        self.syndel = ""
        self.synnew = ""
        self.synelm = ""

        # where the unconsolidated files are
        self.dataDir = ""

        logging.basicConfig(level=logging.INFO)

    def populate(self):
        """Get values from the config file."""
        p = configparser.ConfigParser()
        p.read(self.taskfile)

        # Some configs
        self.graph_list = p['default']['graphs'].split()
        self.postprocess_home = p['default']['postprocess_home']
        self.gnuplot_files_dir = p['default']['gnuplot_files_dir']

        # where the unconsolidated files are
        # because its easier to consolidate raster files using sort
        self.data_dir = p['default']['data_dir']

        self.sp_enabled_at = float(p['default']['sp_enabled_at'])

        self.histogram_times = [float(s) for s in
                                p['default']['histogram_times'].split()]
        self.snapshot_times = [float(s) for s in
                               p['default']['snapshot_times'].split()]
        self.raster_times = [float(s) for s in
                             p['default']['raster_times'].split()]
        self.snr_times = [float(s) for s in
                          p['default']['snr_times'].split()]

        # prefixes
        self.spikes = p['prefixes']['spikes']
        self.conductances = p['prefixes']['conductances']
        self.calcium = p['prefixes']['calcium']
        self.syndel = p['prefixes']['syndel']
        self.synnew = p['prefixes']['synnew']
        self.synelm = p['prefixes']['synelm']

        logging.info("Loaded config from {}".format(self.taskfile))


if __name__ == "__main__":
    config = Config()
    config.populate()
