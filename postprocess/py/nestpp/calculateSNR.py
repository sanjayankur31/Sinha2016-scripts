#!/usr/bin/env python3
"""
Calculate SNR from two sets of unlabelled firing rate files.

File: calculateSNR.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import sys
import numpy
import math


class calculateSNR:

    """Calculate SNR from two sets of unlabelled firing rate files."""

    def run(self, signal_file, noise_file):
        """Main runner method."""
        rates1 = numpy.loadtxt(signal_file, usecols=1,
                               delimiter='\t')
        rates2 = numpy.loadtxt(noise_file, usecols=1,
                               delimiter='\t')

        mean1 = numpy.mean(rates1, dtype=float)
        print("Mean1 is: {}".format(mean1))
        mean2 = numpy.mean(rates2, dtype=float)
        print("Mean2 is: {}".format(mean2))

        std1 = numpy.std(rates1, dtype=float)
        print("STD1is: {}".format(std1))
        std2 = numpy.std(rates2, dtype=float)
        print("STD2 is: {}".format(std2))

        snr = 2. * (math.pow((mean1 - mean2),
                             2.)/(math.pow(std1, 2.) +
                                  math.pow(std2, 2.)))

        print("SNR is: {}".format(snr))
        return snr

    def usage(self):
        """Print usage."""
        usage = ("Usage: \npython3 calculateSNR.py " + "signal_file noise_file")
        print(usage, file=sys.stderr)

if __name__ == "__main__":
    runner = calculateSNR()
    if len(sys.argv) != 3:
        print("Wrong arguments.", file=sys.stderr)
        runner.usage()
    else:
        runner.run(sys.argv[1], sys.argv[2])
