#!/usr/bin/env python3
"""
Utilities.

File: utils.py

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
import os
import csv


def get_config(taskfile="config.ini"):
    """Get values from the config file."""
    if not os.path.exists(taskfile):
        return {}

    p = configparser.ConfigParser()
    p.read(taskfile)

    # Some configs
    graph_list = p['default']['graphs'].split()
    postprocess_home = p['default']['postprocess_home']
    gnuplot_files_dir = p['default']['gnuplot_files_dir']

    # where the unconsolidated files are
    # because its easier to consolidate raster files using sort
    data_dir = p['default']['data_dir']

    sp_enabled_at = float(p['default']['sp_enabled_at'])

    snapshots = {}
    snapshots['histograms'] = [
        float(s) for s in p['snapshots']['histograms'].split()]
    snapshots['firing_rates'] = [
        float(s) for s in p['snapshots']['firing_rates'].split()]
    snapshots['rasters'] = [
        float(s) for s in p['snapshots']['rasters'].split()]
    snapshots['snrs'] = [
        float(s) for s in p['snapshots']['snrs'].split()]
    snapshots['syn_elms'] = [
        float(s) for s in p['snapshots']['syn_elms'].split()]
    snapshots['calciums'] = [
        float(s) for s in p['snapshots']['calciums'].split()]

    # prefixes
    prefixes = {}
    prefixes['spikes'] = p['prefixes']['spikes']
    prefixes['conductances'] = p['prefixes']['conductances']
    prefixes['calcium'] = p['prefixes']['calcium']
    prefixes['syndel'] = p['prefixes']['syndel']
    prefixes['synnew'] = p['prefixes']['synnew']
    prefixes['synelm'] = p['prefixes']['synelm']

    config = {}
    config['graphs'] = graph_list
    config['home'] = postprocess_home
    config['plots_dir'] = gnuplot_files_dir
    config['datadir'] = data_dir
    config['sp_enabled_at'] = sp_enabled_at
    config['snapshots'] = snapshots
    config['prefixes'] = prefixes

    return config


def check_csv_file(path):
    """Check a csv file for errors."""
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
    """Get maximum number of columns."""
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
