#!/usr/bin/env python3
"""
Utilities.

File: utils.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
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
    deaff_at = float(p['default']['deaff_at'])

    # where the unconsolidated files are
    # because its easier to consolidate raster files using sort
    data_dir = p['default']['data_dir']

    snapshots = {}
    snapshots['firing_rate_histograms'] = [
        float(s) for s in p['snapshots']['firing_rate_histograms'].split()]
    snapshots['synapses'] = [
        float(s) for s in p['snapshots']['synapses'].split()]
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

    config = {}
    config['time_graphs'] = graph_list
    config['home'] = postprocess_home
    config['plots_dir'] = os.path.join(postprocess_home, plots_dir)
    config['deaff_at'] = deaff_at
    config['datadir'] = data_dir
    config['snapshots'] = snapshots

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
