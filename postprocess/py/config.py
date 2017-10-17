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

        # snapshots at particular times
        self.snapshots = {
            'histograms': [],
            'firing_rates': [],
            'snrs': [],
            'rasters': [],
            'syn_elms': [],
            'calciums': [],
            }

        # misc
        self.taskfile = taskfile
        self.postprocess_home = ""
        self.gnuplot_files_dir = ""

        # prefixes
        self.prefixes = {}

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

        self.snapshots['histograms'] = [
            float(s) for s in p['snapshots']['histograms'].split()]
        self.snapshots['firing_rates'] = [
            float(s) for s in p['snapshots']['firing_rates'].split()]
        self.snapshots['rasters'] = [
            float(s) for s in p['snapshots']['rasters'].split()]
        self.snapshots['snrs'] = [
            float(s) for s in p['snapshots']['snrs'].split()]
        self.snapshots['syn_elms'] = [
            float(s) for s in p['snapshots']['syn_elms'].split()]
        self.snapshots['calciums'] = [
            float(s) for s in p['snapshots']['calciums'].split()]

        # prefixes
        self.prefixes['spikes'] = p['prefixes']['spikes']
        self.prefixes['conductances'] = p['prefixes']['conductances']
        self.prefixes['calcium'] = p['prefixes']['calcium']
        self.prefixes['syndel'] = p['prefixes']['syndel']
        self.prefixes['synnew'] = p['prefixes']['synnew']
        self.prefixes['synelm'] = p['prefixes']['synelm']

        logging.info("Loaded config from {}".format(self.taskfile))


if __name__ == "__main__":
    config = Config()
    config.populate()
