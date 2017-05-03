#!/usr/bin/env python3
"""
Generate graph of spatial distributions of neurons.

File: spatial.py

Copyright 2016 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
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

    for neuron in neuronsE:
        yE = numpy.random.normal(
            int((neuron - neuronsE[0])/colsE) * neuronal_distE, sd, 1)[0]
        xE = numpy.random.normal(
            ((neuron - neuronsE[0]) % colsE) * neuronal_distE, sd, 1)[0]
        locs.append([xE, yE])

    for neuron in neuronsI:
        yI = neuronal_distI/4 + numpy.random.normal(
            int((neuron - neuronsI[0])/colsI) * neuronal_distI, sd, 1)[0]
        xI = neuronal_distI/4 + numpy.random.normal(
            ((neuron - neuronsI[0]) % colsI) * neuronal_distI, sd, 1)[0]
        locs.append([xI, yI])

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
