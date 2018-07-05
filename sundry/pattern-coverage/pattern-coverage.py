#!/usr/bin/env python3
"""
Check coverage by patterns.

File: patterns.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import random
import math
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt


random.seed(42)

pattern_percent = 0.1
output_filename = ("pattern-coverage.png")
matplotlib.rcParams.update({'font.size': 20})
plt.figure(num=None, figsize=(16, 9), dpi=80)
plt.ylabel("Coverage (neurons in patterns/total available neurons)")
plt.xlabel("number of patterns")
plt.title("Coverage by patterns (800 neurons) of a network (8000 neurons)")
ax = plt.gca()
ax.ticklabel_format(useOffset=False)

neurons = [i for i in range(0, 8000)]

for run in range(0, 25):
    numpats = [i for i in range(5, 110, 2)]
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

    plt.plot(numpats, coverage, ".", markersize=5)

plt.legend(loc="upper right")
plt.grid()
plt.savefig(output_filename)
plt.close()
