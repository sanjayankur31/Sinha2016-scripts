#!/usr/bin/env python3
"""
Make montage of firing rate related graphs.

File: make-montage-firing-rates.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import argparse
from natsort import natsorted
import os
import glob
from montage_util import make_montage


def make_montage_firng_rate_plots(simulation):
    """Make montage of firing rate vs time plots.

    :simulation: simulation to make montage for
    :returns: nothing

    """
    print("Generating firing rate plots montage for {}".format(simulation))
    output_file = (
        "{}-firing-rate-E-I-montage.png".format(simulation)
    )
    args = []
    args += [
        "{}-mean-firing-rates-all-E-zoomed.png".format(simulation),
        "{}-mean-firing-rates-all-I-zoomed.png".format(simulation),
        "-tile", "1x2",
        "-geometry", "+2+2",
        output_file
    ]
    if os.path.isfile(args[0]):
        make_montage(args, output_file)
    else:
        print("Files not found. Skipping firing rate I-E montage.")

    # regions
    output_file = (
        "{}-firing-rate-regions-montage.png".format(simulation)
    )
    args = []
    args += [
        "{}-mean-firing-rates-lpz_c_I-E-zoomed.png".format(simulation),
        "{}-mean-firing-rates-lpz_b_I-E-zoomed.png".format(simulation),
        "{}-mean-firing-rates-p_lpz_I-E-zoomed.png".format(simulation),
        "{}-mean-firing-rates-o_I-E-zoomed.png".format(simulation),
        "-tile", "1x4",
        "-geometry", "+2+2",
        output_file
    ]
    if os.path.isfile(args[0]):
        make_montage(args, output_file)
    else:
        print("Files not found. Skipping region montage.")


def make_montage_grid_plots(simulation):
    """Make montage of firing rate grid plots.

    :simulation: simulation to make montage for
    :returns: nothing

    """
    print("Generating firing rate grid plot montage for {}".format(simulation))
    output_file = (
        "{}-firing-rate-grid-plots-montage.png".format(simulation)
    )
    f_glob_E = "{}-firing-rates-grid-plot-E*.png".format(simulation)
    f_glob_I = "{}-firing-rates-grid-plot-I*.png".format(simulation)
    file_list_E = natsorted(glob.glob(f_glob_E))
    file_list_I = natsorted(glob.glob(f_glob_I))

    args = []
    for afile in file_list_E + file_list_I:
        if os.path.isfile(afile):
            args.append(afile)

    args += [
        "-tile", "{}x{}".format(len(file_list_E), 2),
        "-geometry", "+2+2",
        output_file
    ]
    make_montage(args, output_file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Make montages of firing rate related graphs"
    )
    parser.add_argument("simulation", action="store", type=str,
                        help="simulation to consider")
    args = parser.parse_args()
    make_montage_grid_plots(vars(args)['simulation'])
    make_montage_firng_rate_plots(vars(args)['simulation'])
