#!/usr/bin/env python3
"""
From a file of the format:

Metric 1
Mean
Metric 1
Metric 2
Mean
Metric 1
Metric 2
Metric 3
Mean
..

which represents the Metrics from simulations where we'd recalled increasing
numbers of patterns,

get the Mean and STD of the Metrics for plotting.
Since the mean is already here, we'll use it to also check for correctness.

File: get_mean_std.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""


import numpy


def get_metrics(input_filename, numpats, output_filename):
    """
    Read a file, get metrics.

    :input_filename: input file name
    :numpats: number of patterns
    :returns: nothing

    """
    lines = []
    with open(input_filename) as f:
        lines = [float(line.rstrip('\n')) for line in f]

    with open(output_filename, 'w') as f2:
        counter = 0
        for i in range(0, numpats):
            snrs = []
            for j in range(0, i+1):
                snrs.append(lines[counter])
                counter += 1
            # skip the mean Metric line
            counter += 1
            mean_snr = numpy.mean(snrs)
            std_snr = numpy.std(snrs)

            print("{}\t{}\t{}".format(i+1, mean_snr, std_snr), file=f2)


if __name__ == "__main__":
    for kval in [5, 6, 7, 8]:
        get_metrics("00-SNR-data-k-w-{}.txt".format(kval), 50,
                    "00-mean-std-SNR-k-w-{}.txt".format(kval))
