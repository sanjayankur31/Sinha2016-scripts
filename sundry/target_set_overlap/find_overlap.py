#!/usr/bin/env python3
"""
Find overlap in target sets being projected on by different source neuron sets.

File: find_overlap.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import pandas
import numpy
import os


def runner():
    """Main runner function."""

    conns = {}
    nrns = {}
    timelist = list(numpy.arange(2000.0, 8001.0, 400.0, dtype=float))
    #  timelist = [2000.0]
    #  src_regions = ['lpz_c_I', 'lpz_b_I', 'p_lpz_I', 'o_I']
    src_regions = ['lpz_b_I', 'o_I']
    target_region = 'p_lpz_E'
    projections = {}

    # read the neuron IDs for src_regions
    for r in src_regions:
        fn = "00-locations-{}.txt".format(r)
        if os.path.isfile(fn):
            df = pandas.read_csv(fn, sep="\t", index_col=False, engine="c",
                                 usecols=[0], names=["source"], skiprows=[0],
                                 dtype=int, header=None)
            df.set_index("source", inplace=True)
            nrns[r] = df

    target_neurons_fn = "00-locations-{}.txt".format(target_region)
    target_neurons_df = pandas.read_csv(
        target_neurons_fn, sep="\t", index_col=False, engine="c", usecols=[0],
        names=["target"], skiprows=[0], dtype=int, header=None)
    target_neurons_df.set_index("target", inplace=True)

    # read the connections
    for at in timelist:
        fn = "08-syn_conns-IE-{}.txt".format(at)
        if os.path.isfile(fn):
            df = pandas.read_csv(fn, sep="\t", index_col=False, engine="c",
                                 usecols=[0, 1], header=None,
                                 names=["source", "target"], dtype=int)
            df.set_index("source", inplace=True)
            conns[at] = df

            if at not in projections:
                projections[at] = {}

            # intersection of neurons in each region and the src/target tuples
            # gives us the projections from each source region
            # find only to p LPZ E
            for region, nids in nrns.items():
                projs = nids.join(df, on="source", how="inner")
                projs.set_index("target")

                to_p_lpz_E = projs.join(target_neurons_df, on="target",
                                        how="inner")
                projections[at][region] = to_p_lpz_E

    # get the overlapping targets now
    print("** IE to {} Peri LPZ E neurons **".format(len(target_neurons_df.index)))
    print("Time & Total from LPZ B & Unique from LPZ B & Total from O LPZ & Unique from O LPZ & Overlaping targets")
    for at in timelist:
        if at in projections:
            l1 = projections[at]['lpz_b_I']['target'].values
            l2 = projections[at]['o_I']['target'].values
            s1 = set(l1)
            s2 = set(l2)
            overlap = s1.intersection(s2)

            print("{} & {} & {} & {} & {} & {}".format(
                at, len(l1), len(s1), len(l2), len(s2), len(overlap)
            ))


if __name__ == "__main__":
    runner()
