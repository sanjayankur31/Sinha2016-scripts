#!/usr/bin/env python3
"""
Make structural graph montages.

File: make-montage-structural-graphs.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import argparse
from natsort import natsorted
import os
import glob
from montage_util import make_montage


def make_montage_totals(sim):
    """Make main total montages

    :sim: simulation id
    :returns: nothing

    """
    print("Generating main structural plasticity graphs")
    for nrn in ["E", "I"]:
        # input conductances vs time from different regions
        output_file = (
            "{}-structural-plasticity-{}-montage.png".format(sim, nrn)
        )
        args = []
        for i in range(0, 4):
            fname = "{}-growth-curves-{}.png".format(sim, nrn)
            args.append(fname)

        for gps in [
            "02-calcium",
            "05-se-all-totals",
            "05-se-all-means",
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


def make_montages_top_views(sim):
    """Make montage of snapshots: top views.

    :sim: simulation to make montage of
    :returns: TODO

    """
    for nrn in ["E", "I"]:
        for ty in ["total", "con"]:
            args = []
            output_file = (
                "{}-05-se-{}-montage-{}.png".format(sim, ty, nrn)
            )
            f_glob = (
                "{}-05-se-ax-{}-{}*.png".format(sim, ty, nrn)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

            for afile in file_list:
                if os.path.isfile(afile):
                    args.append(afile)

            f_glob = (
                "{}-05-se-denE-{}-{}*.png".format(sim, ty, nrn)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

            for afile in file_list:
                if os.path.isfile(afile):
                    args.append(afile)

            f_glob = (
                "{}-05-se-denI-{}-{}*.png".format(sim, ty, nrn)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

            for afile in file_list:
                if os.path.isfile(afile):
                    args.append(afile)

            cols = len(args)/3
            args += [
                "-tile", "{}x{}".format(int(cols), 3),
                "-geometry", "+2+2",
                output_file
            ]
            make_montage(args, output_file)


def make_montages_hists(sim):
    """Make montage of snapshots: histograms

    :sim: simulation to make montage of
    :returns: TODO

    """
    for nrn in ["E", "I"]:
        for ty in ["all", "con"]:
            args = []
            output_file = (
                "{}-05-se-hist-{}-montage-{}.png".format(sim, ty, nrn)
            )
            f_glob = (
                "{}-05-se-ax-hist-{}-{}*.png".format(sim, ty, nrn)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

            for afile in file_list:
                if os.path.isfile(afile):
                    args.append(afile)

            f_glob = (
                "{}-05-se-denE-hist-{}-{}*.png".format(sim, ty, nrn)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

            for afile in file_list:
                if os.path.isfile(afile):
                    args.append(afile)

            f_glob = (
                "{}-05-se-denI-hist-{}-{}*.png".format(sim, ty, nrn)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

            for afile in file_list:
                if os.path.isfile(afile):
                    args.append(afile)

            cols = len(args)/3
            args += [
                "-tile", "{}x{}".format(int(cols), 3),
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
    make_montage_totals(vars(args)['sim'])
    make_montages_top_views(vars(args)['sim'])
    make_montages_hists(vars(args)['sim'])
