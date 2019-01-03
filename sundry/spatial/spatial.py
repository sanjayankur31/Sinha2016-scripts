#!/usr/bin/env python3
"""
Generate graph of spatial distributions of neurons.

File: spatial.py

Copyright 2019 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import random
import math
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy
from scipy.spatial import cKDTree
from timeit import default_timer as timer
import resource

neuronsE = range(1, 8001)
neuronsI = range(8001, 10001)


def butz():
    """The butz method of distributing neurons."""
    colsE = 80
    colsI = 40

    neuronal_distE = 150
    neuronal_distI = 300  # rowsE/rowsI * distE (or cols, it's uniform)
    sd = 15

    locs = []

    start = timer()
    for neuron in neuronsE:
        yE = random.gauss(
            int((neuron - neuronsE[0])/colsE) * neuronal_distE, sd)
        xE = random.gauss(
            ((neuron - neuronsE[0]) % colsE) * neuronal_distE, sd)
        locs.append([xE, yE])

    for neuron in neuronsI:
        yI = neuronal_distI/4 + random.gauss(
            int((neuron - neuronsI[0])/colsI) * neuronal_distI, sd)
        xI = neuronal_distI/4 + random.gauss(
            ((neuron - neuronsI[0]) % colsI) * neuronal_distI, sd)
        locs.append([xI, yI])
    end = timer()
    print("Locations with native random generator: {}".format(end - start))

    plotit(locs, "spatial-grid-butz.png")
    timetree(locs, "BUTZ")


def uniform():
    """All neurons uniformly distributed."""
    locs = numpy.random.uniform(low=0.0, high=15000.0, size=[len(neuronsE) +
                                                             len(neuronsI),
                                                             2])

    plotit(locs, "spatial-grid-uniform.png")
    timetree(locs, "UNIFORM")


def timetree(matrix, methodname):
    """Create tree and time it."""
    start = timer()
    tree = cKDTree(matrix)
    end = timer()

    print("{}: Tree construction took: {}".format(methodname, end-start))
    print("{}: Number of points: {}".format(methodname, len(tree.data)))


def plotit(matrix, filename):
    """Plot the locations."""
    locx, locy = zip(*matrix)

    output_filename = (filename)
    matplotlib.rcParams.update({'font.size': 20})
    plt.figure(num=None, figsize=(32, 18), dpi=80)
    plt.ylabel("Y (micro metres)")
    plt.xlabel("X (micro metres)")
    plt.title("Neurons distributed in a spatial grid using gid")
    ax = plt.gca()
    ax.set_ylim(min(locy) - 500, max(locy) + 500)
    ax.set_xlim(min(locx) - 500, max(locx) + 500)
    ax.ticklabel_format(useOffset=False)

    plt.plot(locx[0:len(neuronsE)], locy[0:len(neuronsE)], ".", markersize=5,
             label="E")
    plt.plot(locx[len(neuronsE):], locy[len(neuronsE):], ".", markersize=5,
             label="I")

    plt.legend(loc="upper right")
    plt.grid()
    plt.savefig(output_filename)
    plt.close()

if __name__ == "__main__":
    butz()
    uniform()
