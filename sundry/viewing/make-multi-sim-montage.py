#!/usr/bin/env python3
"""
Make a montage from different simulations.

File: make-multi-sim-montage.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import argparse
import subprocess
from subprocess import CalledProcessError
import datetime
import os
import sys


def montagise(simlist):
    """Main worker method.

    Uses the montage command. This function just sets up the command line
    argument and then calls it.

    :simlist: list of simulations to montagise
    :returns: nothing
    """
    # Check that all simulation directories exist
    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M")
    cleaned_list = []
    for sim in simlist:
        if not os.path.isdir(sim):
            print(
                "{}: directory not found. Exiting.".format(sim),
                file=sys.stderr)
            sys.exit(-1)
        # Remove trailing slash
        if sim[-1] == "/":
            cleaned_list.append(sim[:-1])
        else:
            cleaned_list.append(sim)

    if len(simlist):
        print("Combining {} simulations: {}".format(len(cleaned_list),
                                                    cleaned_list))
        connections(cleaned_list, timestamp)
        neuron_metrics(cleaned_list, timestamp)
        conductances(cleaned_list, timestamp)


def neuron_metrics(simlist, timestamp):
    """Make the neuron metrics montage

    :simlist: list of simulations
    :timestamp: time at which montages are generated
    :returns: nothing

    """
    print("Generating neuron metrics montage")
    # Each simulation gets a column
    num_cols = len(simlist)
    graphs = [
        "02-calcium",
        "05-se-all"
    ]

    regions = ["lpz_c_E", "lpz_b_E", "p_lpz_E", "o_E"]
    regions += ["lpz_c_I", "lpz_b_I", "p_lpz_I", "o_I"]

    for region in regions:
        output_file = (
            "{}-multi-sim-neuron-metrics-{}-montage.png".format(
                timestamp, region
            )
        )
        print("Generating {}...".format(output_file))
        args = []
        # Add growth curves on top
        gcs = ['growth-curves-E', 'growth-curves-I']
        for gc in gcs:
            for sim in simlist:
                fname = (
                    os.path.join(sim, "{}-{}.png".format(
                        sim, gc
                    ))
                )
                if os.path.isfile(fname):
                    args.append(fname)
                else:
                    print(
                        "{}: file not found. Exiting.".format(
                            fname
                        ),
                        file=sys.stderr
                    )
                    sys.exit(-2)

        for graph in graphs:
            for sim in simlist:
                fname = (
                    os.path.join(sim, "{}-{}-{}.png".format(
                        sim, graph, region
                    ))
                )
                if os.path.isfile(fname):
                    args.append(fname)
                else:
                    print(
                        "{}: file not found. Exiting.".format(
                            fname
                        ),
                        file=sys.stderr
                    )
                    sys.exit(-2)

        # Final bits
        args += [
            "-title", "'{}'".format(
                ", ".join(str(sim) for sim in simlist)
            ),
            "-tile", "{}x{}".format(num_cols, len(graphs) + len(gcs)),
            "-pointsize", "28",
            "-font", "OpenSans",
            "-geometry", "+2+2",
            output_file
        ]

        try:
            print("Running montage with args: {}".format(args))
            status = subprocess.run(args=['montage'] + args,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
            status.check_returncode()
        except CalledProcessError as cpe:
            print(
                "{} errored with return code {}".format(
                    cpe.cmd, cpe.returncode))
            print("\n" + cpe.stderr.decode())
        else:
            print("{} Montage created".format(output_file))


def connections(simlist, timestamp):
    """Make the connections montage

    :simlist: list of simulations
    :timestamp: time at which montages are generated
    :returns: nothing

    """
    print("Generating connection montage")
    # Each simulation gets a column
    num_cols = len(simlist)
    graphs = [
        "02-calcium",
        "08-syn_conns-E-to",
        "081-connection-clustered-histograms-E-to",
        "081-connection-rowstacked-histograms-E-to",
        "08-syn_conns-I-to",
        "081-connection-clustered-histograms-I-to",
        "081-connection-rowstacked-histograms-I-to"
    ]

    regions = ["lpz_c_E", "lpz_b_E", "p_lpz_E", "o_E"]
    regions += ["lpz_c_I", "lpz_b_I", "p_lpz_I", "o_I"]

    for region in regions:
        output_file = (
            "{}-multi-sim-connections-{}-montage.png".format(
                timestamp, region
            )
        )
        print("Generating {}...".format(output_file))
        args = []
        # Add growth curves on top
        gcs = ['growth-curves-E', 'growth-curves-I']
        for gc in gcs:
            for sim in simlist:
                fname = (
                    os.path.join(sim, "{}-{}.png".format(
                        sim, gc
                    ))
                )
                if os.path.isfile(fname):
                    args.append(fname)
                else:
                    print(
                        "{}: file not found. Exiting.".format(
                            fname
                        ),
                        file=sys.stderr
                    )
                    sys.exit(-2)

        for graph in graphs:
            for sim in simlist:
                fname = (
                    os.path.join(sim, "{}-{}-{}.png".format(
                        sim, graph, region
                    ))
                )
                if os.path.isfile(fname):
                    args.append(fname)
                else:
                    print(
                        "{}: file not found. Exiting.".format(
                            fname
                        ),
                        file=sys.stderr
                    )
                    sys.exit(-2)

        # Final bits
        args += [
            "-title", "'{}'".format(
                ", ".join(str(sim) for sim in simlist)
            ),
            "-tile", "{}x{}".format(num_cols, len(graphs) + len(gcs)),
            "-pointsize", "28",
            "-font", "OpenSans",
            "-geometry", "+2+2",
            output_file
        ]

        try:
            print("Running montage with args: {}".format(args))
            status = subprocess.run(args=['montage'] + args,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
            status.check_returncode()
        except CalledProcessError as cpe:
            print(
                "{} errored with return code {}".format(
                    cpe.cmd, cpe.returncode))
            print("\n" + cpe.stderr.decode())
        else:
            print("{} Montage created".format(output_file))


def conductances(simlist, timestamp):
    """Make the conductances montage

    :simlist: list of simulations
    :timestamp: time at which montages are generated
    :returns: nothing

    """
    print("Generating conductances montage")
    # Each simulation gets a column
    num_cols = len(simlist)
    graphs = [
        "02-calcium",
        "08-total-conductances-E-to",
        "08-total-conductances-I-to",
        "08-mean-conductances-E-to",
        "08-mean-conductances-I-to",
    ]

    regions = ["lpz_c_E", "lpz_b_E", "p_lpz_E", "o_E"]
    regions += ["lpz_c_I", "lpz_b_I", "p_lpz_I", "o_I"]

    for region in regions:
        output_file = (
            "{}-multi-sim-conductances-{}-montage.png".format(
                timestamp, region
            )
        )
        print("Generating {}...".format(output_file))
        args = []
        # Add growth curves on top
        gcs = ['growth-curves-E', 'growth-curves-I']
        for gc in gcs:
            for sim in simlist:
                fname = (
                    os.path.join(sim, "{}-{}.png".format(
                        sim, gc
                    ))
                )
                if os.path.isfile(fname):
                    args.append(fname)
                else:
                    print(
                        "{}: file not found. Exiting.".format(
                            fname
                        ),
                        file=sys.stderr
                    )
                    sys.exit(-2)

        for graph in graphs:
            for sim in simlist:
                fname = (
                    os.path.join(sim, "{}-{}-{}.png".format(
                        sim, graph, region
                    ))
                )
                if os.path.isfile(fname):
                    args.append(fname)
                else:
                    print(
                        "{}: file not found. Exiting.".format(
                            fname
                        ),
                        file=sys.stderr
                    )
                    sys.exit(-2)

        # Final bits
        args += [
            "-title", "'{}'".format(
                ", ".join(str(sim) for sim in simlist)
            ),
            "-tile", "{}x{}".format(num_cols, len(graphs) + len(gcs)),
            "-pointsize", "28",
            "-font", "OpenSans",
            "-geometry", "+2+2",
            output_file
        ]

        try:
            print("Running montage with args: {}".format(args))
            status = subprocess.run(args=['montage'] + args,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
            status.check_returncode()
        except CalledProcessError as cpe:
            print(
                "{} errored with return code {}".format(
                    cpe.cmd, cpe.returncode))
            print("\n" + cpe.stderr.decode())
        else:
            print("{} Montage created".format(output_file))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Make montages of many simulations"
    )
    parser.add_argument("simulations", action="store", type=str,
                        nargs="+", help="simulations to combine")
    args = parser.parse_args()
    montagise(vars(args)['simulations'])
