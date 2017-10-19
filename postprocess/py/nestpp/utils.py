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
import subprocess
from subprocess import CalledProcessError
from nestpp.loggerpp import get_module_logger
import numpy
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt  # NOQA


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


def plot_using_gnuplot_binary(plt_file, arglist=[]):
    """Run a gnuplot script to plot a graph.

    This will complete the path of the file by appending the required bits.

    :plt_file: plt script file
    :arglist: other arguments to be passed to gnuplot
    :returns: return code from gnuplot or -99 if missing script

    """
    args = []
    retcode = 0

    if os.path.exists(plt_file):
        for arg in arglist:
            args.append(['-e', arg])

        args.append(plt_file)
        lgr.info("Plotting {}".format(
            plt_file))
        try:
            status = subprocess.run(args=['gnuplot'] + args,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
            status.check_returncode()
        except CalledProcessError as cpe:
            lgr.error(
                "{} errored with return code {}".format(
                    cpe.cmd, cpe.returncode))
            lgr.error("\n" + cpe.stderr.decode())
            retcode = cpe.returncode
        else:
            lgr.info("{} plotted".format(plt_file))
            retcode = status.returncode
    else:
        lgr.error(
            "File {} not found. Not plotting graph.".format(
                plt_file))
        return -99

    return retcode


def plot_histograms(neurons_sets, snapshot_time):
    """Plot histograms of neuron sets

    This only plots the histograms. The firing rate snapshot files must be
    generated before this function is called.

    :neuron_sets: list of neuron sets to plot in this histogram
    :snapshot_time: time point for which this snapshot is being generated
    :returns: True if everything went OK, False otherwise.

    """
    data = {}
    for neuron_set in neurons_sets:
        with open(
                "firing-rate-{}-{}.gdf".format(neuron_set, snapshot_time)
        ) as f1:
            data1 = numpy.loadtxt(f1, delimiter='\t', dtype='float')
            data[neuron_set] = data1

    plt.figure(num=None, figsize=(16, 9), dpi=80)
    plt. xlabel("Firing rates")
    plt.ylabel("Number of neurons")
    snapshot_time = float(snapshot_time)

    plt.xticks(numpy.arange(0, 220, 20))
    plt.axis((0, 205, 0, 8000))
    plot_title = "Histogram ("
    o_fn = "histogram-"
    for neuron_set, values in data:
        plt.hist(values, bins=100, alpha=0.5, label=neuron_set)
        plot_title += (neuron_set + ", ")
        o_fn += (neuron_set + "-")

    plot_title = plot_title[:-1] + " at time {}".format(snapshot_time)
    o_fn += "{}png".format(snapshot_time)  # snapshot_time has a period already
    lgr.info("Storing {}".format(o_fn))
    plt.legend(loc="upper right")
    plt.savefig(o_fn)
    plt.close()


def plot_location_grid(neuron_sets_dict):
    """Plot a grid plot with specified neuron sets.

    :neuron_sets_dict: dict with keys as neuron sets and values as the set of
                        lists of [nid, xpos, ypos]

    """
    plt.figure(num=None, figsize=(16, 20), dpi=80)
    plt.xlabel("extent (micro metres)")
    plt.ylabel("extent (micro metres)")
    plot_fn = "Grid-plot-"
    for neuron_set, position_lists in neuron_sets_dict.items():
        x = []
        y = []
        for nrn in position_lists:
            x.append(nrn[1])
            y.append(nrn[2])
        plt.plot(x, y, "x", markersize=6, label=neuron_set)
        plot_fn += "{}-".format(neuron_set)

    plot_fn = plot_fn[:-1] + ".png"
    plt.legend(loc="upper right")
    plt.savefig(plot_fn)

    return True
