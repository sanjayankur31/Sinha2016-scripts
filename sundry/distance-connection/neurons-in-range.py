#!/usr/bin/env python3
"""
Find how many neurons are in a certain distance.

File: neurons-in-range.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

import numpy


inter_neuron_d = 150
dmax = 10000
sigma = 5 * inter_neuron_d
output_fn = "neurons-in-range.txt".format(sigma)


# grid
# cols
numcols = 80
cols = numpy.array([(i*inter_neuron_d) for i in range(0, numcols)])
# rows
numrows = 100
rows = numpy.array([(i*inter_neuron_d) for i in range(0, numrows)])
# the mesh
xs, ys = numpy.meshgrid(cols, rows, indexing='ij')

centre = [numcols/2 * inter_neuron_d, numrows/2 * inter_neuron_d]

conns_total = 0
with open(output_fn, 'w') as fh:
    for d in range(inter_neuron_d, dmax, 50):
        radius = d**2
        conns = 0
        for i in range(numcols):
            for j in range(numrows):
                point_x = xs[i, j]
                point_y = ys[i, j]
                dist = (point_x - centre[0])**2 + (point_y - centre[1])**2
                if dist < radius:
                    conns += 1
        print("{}\t{}".format(d, conns), file=fh)
