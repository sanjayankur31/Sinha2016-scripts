#!/usr/bin/env python3
"""
Make montages of conductance graphs

File: make-montage-conductances.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import argparse
from natsort import natsorted
import os
import glob
from montage_util import make_montage


def make_montage_total_conductances(sim):
    """Make montages of total conductances to regions.

    :sim: sim timestamp
    :returns: nothing

    """
    for nrn in ["E", "I"]:
        # input conductances vs time from different regions
        output_file = (
            "{}-75-conductances-{}-montage.png".format(sim, nrn)
        )
        args = []
        for gps in [
            "02-calcium",
            "08-total-conductances-E-to",
            "08-total-conductances-I-to",
            "08-mean-conductances-E-to",
            "08-mean-conductances-I-to"
        ]:
            for region in ["lpz_c", "lpz_b", "p_lpz", "o"]:
                fname = "{}-{}-{}_{}.png".format(sim, gps, region, nrn)
                args.append(fname)

        args += [
            "-tile", "4x5",
            "-geometry", "+2+2",
            output_file
        ]
        make_montage(args, output_file)

        # input conductances from different regions: histograms
        output_file = (
            "{}-75-conductances-histograms-{}-montage.png".format(sim, nrn)
        )
        args = []
        for gps in [
            "02-calcium",
            "081-conductance-clustered-histograms-E-to",
            "081-conductance-clustered-histograms-I-to",
            "081-conductance-rowstacked-histograms-E-to",
            "081-conductance-rowstacked-histograms-I-to",
        ]:
            for region in ["lpz_c", "lpz_b", "p_lpz", "o"]:
                fname = "{}-{}-{}_{}.png".format(sim, gps, region, nrn)
                args.append(fname)

        args += [
            "-tile", "4x5",
            "-geometry", "+2+2",
            output_file
        ]
        make_montage(args, output_file)

        # net conductances to different regions
        output_file = (
            "{}-75-net-conductances-{}-montage.png".format(sim, nrn)
        )
        args = []
        for gps in [
            "02-calcium",
            "08-net-regional-conductances-to",
            "08-net-conductances-to",
            "08-net-conductances-slope-to"
        ]:
            for region in ["lpz_c", "lpz_b", "p_lpz", "o"]:
                fname = "{}-{}-{}_{}.png".format(sim, gps, region, nrn)
                args.append(fname)

        args += [
            "-tile", "4x4",
            "-geometry", "+2+2",
            output_file
        ]
        make_montage(args, output_file)


def make_montage_conductance_hists(sim):
    """Make montage of conductance time lapse histogram plots.

    :sim: sim to make montage for
    :returns: nothing

    """
    print("Generating firing rate grid plot montage for {}".format(sim))
    output_file = (
        "{}-08-conductance-hist-time-lapse-montage.png".format(sim)
    )
    args = []
    for syn in ["EE", "IE", "EI", "II"]:
        f_glob = "{}-08-conductance-hist-{}-*.png".format(sim, syn)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

    cols = len(args)/4
    args += [
        "-tile", "{}x{}".format(int(cols), 4),
        "-geometry", "+2+2",
        output_file
    ]
    make_montage(args, output_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Make montages of firing rate related graphs"
    )
    parser.add_argument("sim", action="store", type=str,
                        help="sim to consider")
    args = parser.parse_args()
    make_montage_total_conductances(vars(args)['sim'])
    make_montage_conductance_hists(vars(args)['sim'])
