#!/usr/bin/env python3
"""
Make connectivity related montages

File: make-montage-connectivity.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import argparse
from natsort import natsorted
import os
import glob
from montage_util import make_montage


def make_montage_connectivity_len_hists(sim):
    """Make montage of connectivity hist plots.

    :sim: sim to make montage for
    :returns: nothing

    """
    print("Generating connectivity len histograms montage for {}".format(sim))
    for ty in ["in", "out"]:
        args = []
        output_file = (
            "{}-75-connections-{}-hist-time-lapse-montage.png".format(sim, ty)
        )
        for syn in ["EE", "IE", "EI", "II"]:
            f_glob = (
                "{}-75-connections-hist-{}-*-{}.png".format(sim, syn, ty)
            )
            file_list = natsorted(glob.glob(f_glob))

            if not file_list:
                print("Component files not found. Skipping")
                return

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


def make_montage_connectivity_top_views(sim):
    """Montages of top view connection graphs.

    :sim: sim to make montages of
    :returns: TODO

    """
    for region in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "o_E"]:
        output_file = (
            "{}-75-connections-{}-time-top-montage.png".format(sim, region)
        )
        args = []
        f_glob = "{}-75-conns-top-EE-{}-*-in.png".format(sim, region)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

        f_glob = "{}-75-conns-top-EE-{}-*-out.png".format(sim, region)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

        f_glob = "{}-75-conns-top-IE-{}-*-in.png".format(sim, region)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

        f_glob = "{}-75-conns-top-EI-{}-*-out.png".format(sim, region)
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

    for region in ["lpz_c_I", "lpz_b_I", "p_lpz_I", "o_I"]:
        output_file = (
            "{}-75-connections-{}-time-top-montage.png".format(sim, region)
        )
        args = []
        f_glob = "{}-75-conns-top-II-{}-*-in.png".format(sim, region)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

        f_glob = "{}-75-conns-top-II-{}-*-out.png".format(sim, region)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

        f_glob = "{}-75-conns-top-EI-{}-*-in.png".format(sim, region)
        file_list = natsorted(glob.glob(f_glob))

        for afile in file_list:
            if os.path.isfile(afile):
                args.append(afile)

        f_glob = "{}-75-conns-top-IE-{}-*-out.png".format(sim, region)
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


def make_montage_total_conductances(sim):
    """Make montages of total incoming conductances to regions.

    :sim: simulation to make montages for
    :returns: nothing

    """
    for nrn in ["E", "I"]:
        output_file = (
            "{}-75-connections-{}-montage.png".format(sim, nrn)
        )
        args = []
        for gps in [
            "02-calcium",
            "75-syn_conns-E-to",
            "75-connection-clustered-histograms-E-to",
            "75-connection-rowstacked-histograms-E-to",
            "75-syn_conns-I-to",
            "75-connection-clustered-histograms-I-to",
            "75-connection-rowstacked-histograms-I-to",
        ]:
            for region in ["lpz_c", "lpz_b", "p_lpz", "o"]:
                fname = "{}-{}-{}_{}.png".format(sim, gps, region, nrn)
                args.append(fname)
        args += [
            "-tile", "4x7",
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
    make_montage_connectivity_len_hists(vars(args)['sim'])
    make_montage_connectivity_top_views(vars(args)['sim'])
