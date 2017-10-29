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
import sys
from select import select
from nestpp.loggerpp import get_module_logger


lgr = get_module_logger(__name__)


def get_config(taskfile="config.ini"):
    """Get values from the config file."""
    if not os.path.exists(taskfile):
        return {}

    p = configparser.ConfigParser()
    p.read(taskfile)

    # Some configs
    graph_list = p['default']['time_graphs'].split()
    postprocess_home = p['default']['postprocess_home']
    plots_dir = p['default']['plots_dir']

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
    config['time_graphs'] = graph_list
    config['home'] = postprocess_home
    config['plots_dir'] = os.path.join(postprocess_home, plots_dir)
    config['datadir'] = data_dir
    config['sp_enabled_at'] = sp_enabled_at
    config['snapshots'] = snapshots
    config['prefixes'] = prefixes

    return config


def input_with_timeout(prompt, timeout=30.0):
    """Input but with timeout."""
    astring = 'Y'
    print(prompt, end='', flush=True)
    rlist, _, _ = select([sys.stdin], [], [], timeout)
    if rlist:
        astring = sys.stdin.readline()[0]
    else:
        print("Timed out.. Proceeding..")
    return astring


def get_numpats():
    """Get number of patterns from list of files in directory."""
    filelist = os.listdir()
    i = 0
    for entry in filelist:
        if entry.startswith('00-pattern-neurons-'):
            i = i+1

    lgr.info("Got {} patterns".format(i))
    return i
