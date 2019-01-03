#!/usr/bin/env python3
"""
Make calcium graph montages.

File: make-montage-calcium-graphs.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import argparse
from natsort import natsorted
import os
import glob
from montage_util import make_montage


def make_montages_top_views(sim):
    """Make montage of snapshots: top views.

    :sim: simulation to make montage of
    :returns: TODO

    """
    args = []
    output_file = (
        "{}-02-calcium-top-view-montage.png".format(sim)
    )
    for nrn in ["E", "I"]:
        f_glob = (
            "{}-02-calcium-{}-*.*.png".format(sim, nrn)
        )
        file_list = natsorted(glob.glob(f_glob))

        if not file_list:
            print("Component files not found. Skipping")
            return

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

    cols = len(args)/2
    args += [
        "-tile", "{}x{}".format(int(cols), 2),
        "-geometry", "+2+2",
        output_file
    ]
    make_montage(args, output_file)


def make_montages_hists(sim):
    """Make montage of snapshots: histograms

    :sim: simulation to make montage of
    :returns: TODO

    """
    args = []
    output_file = (
        "{}-02-calcium-hist-montage.png".format(sim)
    )
    for nrn in ["E", "I"]:
        f_glob = (
            "{}-02-calcium-hist-{}-*.png".format(sim, nrn)
        )
        file_list = natsorted(glob.glob(f_glob))

        if not file_list:
            print("Component files not found. Skipping")
            return

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

    cols = len(args)/2
    args += [
        "-tile", "{}x{}".format(int(cols), 2),
        "-geometry", "+2+2",
        output_file
    ]
    make_montage(args, output_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Make montages of calcium related graphs"
    )
    parser.add_argument("sim", action="store", type=str,
                        help="sim to consider")
    args = parser.parse_args()
    make_montages_top_views(vars(args)['sim'])
    make_montages_hists(vars(args)['sim'])
