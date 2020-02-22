#!/usr/bin/env python3
"""
Check coverage by patterns.

File: patterns.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import random
import math
import numpy
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt  # noqa: E402 F401


random.seed(42)

pattern_percent = 0.1
#  output_filename = ("pattern-coverage.png")
#  matplotlib.rcParams.update({'font.size': 20})
#  plt.figure(num=None, figsize=(16, 9), dpi=80)
#  plt.ylabel("Coverage (neurons in patterns/total available neurons)")
#  plt.xlabel("number of patterns")
#  plt.title("Coverage by patterns (800 neurons) of a network (8000 neurons)")
#  ax = plt.gca()
#  ax.ticklabel_format(useOffset=False)

neurons = [i for i in range(0, 8000)]

# Will be a two dimensional structure
# A list for each run
run_metrics = []

# Our number of patterns to iterate over
numpats = [i for i in range(1, 100, 1)]

# Run 25 times to average it out
for run in range(0, 20):
    coverage = []
    for numpat in numpats:
        allpats = []
        for i in range(0, numpat):
            pattern = random.sample(neurons,
                                    int(math.ceil(float(len(neurons)) *
                                                  pattern_percent)))
            allpats += pattern
            allpats = list(set(allpats))
        coverage.append(float(len(allpats))/float(len(neurons)))

    run_metrics.append(coverage)
    #  plt.plot(numpats, coverage, ".", markersize=5)

run_metrics = numpy.array(run_metrics)
mean_vals = run_metrics.mean(axis=0)

with open('pattern_overlap_data.txt', 'w') as f:
    for i in range(len(mean_vals)):
        print("{}\t{}".format(numpats[i], mean_vals[i]), file=f)

#  plt.legend(loc="upper right")
#  plt.grid()
#  plt.savefig(output_filename)
#  plt.close()
