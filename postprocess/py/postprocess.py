#!/usr/bin/env python3
"""
Postprocess output files from the simulation.

File: postprocess.py

Copyright 2018 Ankur Sinha
Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
"""

# system imports
import os
import pandas
import numpy
import itertools
import random
from multiprocessing import Process
import sys
import math
import logging
from collections import OrderedDict
import time

# module imports
from nestpp.utils import (get_config, get_numpats)
from nestpp.plotting_utils import (plot_using_gnuplot_binary,
                                   plot_firing_rate_histograms,
                                   plot_location_grid, plot_rasters)
from nestpp.loggerpp import get_module_logger
from nestpp.spike_utils import (get_firing_rate_metrics,
                                get_individual_firing_rate_snapshots,
                                extract_spikes)
from nestpp.file_utils import (get_info_from_file_series,
                               combine_files_row_wise)


class Postprocess:

    """Main post process worker class."""

    def __init__(self):
        """Initialise."""
        self.lgr = get_module_logger("Postprocessor",
                                     logging_level=logging.INFO)
        self.neurons = {}
        self.ready = True

    def setup(self, configfile):
        """Read info required for postprocessing

        :configfile: path to config file
        """
        self.cfg = get_config(configfile)
        self.__populate_neuron_lists()

        if not self.ready:
            self.lgr.critical("Error reading initial files. Exiting.")
            sys.exit(-1)

    def __load_neurons(self, file, cols=[0, 1, 2]):
        """Read neuron list from a file

        :file: name of file containing neuron IDs and locations
        :cols: columns to read from file
        :returns: numpy array with nid, x, y coordinates etc. and False if
                    files are not found.

        """
        neurons = []
        if os.path.exists(file):
            neurons = (numpy.loadtxt(file, delimiter='\t', usecols=cols,
                                     skiprows=1))
            self.lgr.info("Read {} neurons from {}".format(
                len(neurons), file))
        else:
            self.lgr.error(
                "Unable to find {}. Neurons not loaded.".format(file))
            self.ready = False

        return neurons

    def __populate_neuron_lists(self):
        """Populate neuron lists.

        Load all the information once so that other functions do not need to
        read files again and again.
        """
        # Excitatory neurons
        self.neurons['E'] = self.__load_neurons("00-locations-E.txt",
                                                cols=[0, 1, 2, 3, 4])
        # nid   posx    posy
        self.neurons['lpz_c_E'] = self.__load_neurons(
            "00-locations-lpz_c_E.txt")
        self.neurons['lpz_b_E'] = self.__load_neurons(
            "00-locations-lpz_b_E.txt")
        self.neurons['lpz_E'] = numpy.concatenate(
            (self.neurons['lpz_b_E'], self.neurons['lpz_c_E']), axis=0)
        self.neurons['p_lpz_E'] = self.__load_neurons(
            "00-locations-p_lpz_E.txt")
        self.neurons['o_E'] = self.__load_neurons(
            "00-locations-o_E.txt")

        # Inhibitory neurons
        self.neurons['I'] = self.__load_neurons("00-locations-I.txt",
                                                cols=[0, 1, 2, 3, 4])
        # nid   posx    posy
        self.neurons['lpz_c_I'] = self.__load_neurons(
            "00-locations-lpz_c_I.txt")
        self.neurons['lpz_b_I'] = self.__load_neurons(
            "00-locations-lpz_b_I.txt")
        self.neurons['lpz_I'] = numpy.concatenate(
            (self.neurons['lpz_b_I'], self.neurons['lpz_c_I']), axis=0)
        self.neurons['p_lpz_I'] = self.__load_neurons(
            "00-locations-p_lpz_I.txt")
        self.neurons['o_I'] = self.__load_neurons(
            "00-locations-o_I.txt")

        # Populate pattern lists and calculate the overlap percentage between
        # each pattern and the LPZ
        self.numpats = get_numpats()
        with open("00-pattern-overlap.txt", 'w') as f:
            for i in range(1, self.numpats + 1):
                neurons_P = self.__load_neurons(
                    "00-pattern-neurons-" + str(i) + ".txt")
                neurons_B = self.__load_neurons(
                    "00-background-neurons-" + str(i) + ".txt")

                self.neurons['pattern-{}'.format(i)] = neurons_P
                self.neurons['background-{}'.format(i)] = neurons_B

                overlapping_neurons = set(self.neurons_lpz_E).intersection(
                    set(neurons_P))
                overlapping_percent = len(overlapping_neurons)/len(neurons_P)
                print("{}\t{}".format(i, overlapping_percent), file=f)

    def generate_synaptic_element_graphs(self):
        """Post process synaptic elements from individual neuronal files."""
        if "syn_elms" not in self.cfg['time_graphs']:
            return True

        self.lgr.info("Processing synaptic elements..")
        time_list = get_info_from_file_series("..", "05-se-lpz_b_E-0-",
                                              ".txt")
        for neuron_set in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "o_E", "lpz_c_I",
                           "lpz_b_I", "p_lpz_I", "o_I"]:
            neuron_set_o_fn = "05-se-all-{}.txt".format(neuron_set)
            with open(neuron_set_o_fn, 'w') as f:
                for atime in time_list:
                    self.lgr.debug(
                        "Processing syn elms for {} at {}".format(
                            neuron_set, atime))
                    ses = pandas.DataFrame()
                    ses = combine_files_row_wise(
                        "..", "05-se-{}-*-{}.txt".format(
                            neuron_set, atime), '\t')

                    # mean of more than one column, so this needs to be
                    # done.
                    means = [str(x) for x in ses.mean(axis=0).values]
                    stds = [str(x) for x in ses.std(axis=0).values]
                    print("{}\t{}\t{}".format(
                        atime, '\t'.join(means), '\t'.join(stds)),
                          file=f)

            self.lgr.info(
                "Processed syn elms metrics for {} neurons..".format(
                    neuron_set))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-synaptic-elements-metrics.plt'))

    def generate_calcium_graphs(self):
        """Postprocess calcium files.

        Collates various files from ranks and the different times and generates
        the plot that shows the mean and standard deviation of the calcium
        concentration of neuron sets as they vary with time.

        While it generates these graphs and prints the mean and STD values to a
        file for each neuron set, it does not print the collated values at each
        time to a file at the moment. This will be added later if a per neuron
        analysis is required.
        """
        if "calciums" not in self.cfg['time_graphs']:
            return True

        self.lgr.info("Generating calcium graphs..")
        # get times where the info was logged since these need to be combined
        # first - from any file series for one rank
        time_list = get_info_from_file_series("..", "02-calcium-lpz_b_E-0-",
                                              ".txt")

        for neuron_set in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "o_E", "lpz_c_I",
                           "lpz_b_I", "p_lpz_I", "o_I"]:
            neuron_set_o_fn = "02-calcium-{}-all.txt".format(neuron_set)
            with open(neuron_set_o_fn, 'w') as f:
                for atime in time_list:
                    cals = pandas.DataFrame()
                    cals = combine_files_row_wise(
                        "..", "02-calcium-{}-*-{}.txt".format(
                            neuron_set, atime), '\t')

                    means = [str(x) for x in cals.mean(axis=0).values]
                    stds = [str(x) for x in cals.std(axis=0).values]
                    print("{}\t{}\t{}".format(
                        atime, '\t'.join(means),
                        '\t'.join(stds)), file=f)

            self.lgr.info(
                "Processed cal metrics for {} neurons..".format(neuron_set))

        plot_using_gnuplot_binary(os.path.join(self.cfg['plots_dir'],
                                               'plot-cal-metrics.plt'))

    def generate_firing_rate_graphs(self):
        """Generate firing rate graphs."""
        if "firing_rates" not in self.cfg['time_graphs']:
            return True

        self.lgr.info("Generating mean firing rate graphs vs time")

        for neuron_set in self.neurons.keys():
            get_firing_rate_metrics(
                neuron_set, "spikes-{}.gdf".format(neuron_set),
                len(self.neurons[neuron_set]), dt=100, window=2500)

        self.lgr.info("Generating firing rate graphs")
        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'], 'plot-firing-rates-IE.plt')
        )

        if self.numpats > 0:
            self.lgr.info("Generating pattern graphs")
            plot_using_gnuplot_binary(
                os.path.join(self.cfg['plots_dir'],
                             'plot-firing-rates-patterns.plt'),
                ['-e', 'numpats={}'.format(self.numpats)]
            )

        self.lgr.info("Generating ISI cv graphs")
        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'], 'plot-cvs.plt'))

        self.lgr.info("Generating STD of firing rates graphs")
        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'], 'plot-std.plt'))

    def generate_firing_rate_histograms(self):
        """Generate histograms."""
        # firing rate histograms for E and I neurons
        if len(self.cfg['snapshots']['firing_rate_histograms']) > 0:
            histlist = ['E', 'I']
            self.lgr.info("Generating histograms for {}".format(histlist))
            for neuron_set in histlist:
                get_individual_firing_rate_snapshots(
                    neuron_set, "spikes-{}.gdf".format(neuron_set),
                    self.neurons[neuron_set],
                    self.cfg['snapshots']['firing_rate_histograms'])

            for atime in self.cfg['snapshots']['firing_rate_histograms']:
                plot_firing_rate_histograms(histlist, atime)

    def generate_firing_rate_grid_snapshots(self):
        """Generate top view firing rate snapshots."""
        if len(self.cfg['snapshots']['firing_rates']) > 0:
            fr_grid_list = ['E', 'I']
            for neuron_set in fr_grid_list:
                if neuron_set == 'E':
                    xmax = 80
                    ymax = 100
                else:
                    xmax = 40
                    ymax = 50

                self.lgr.debug(
                    "Generating firing rate snapshots for {}".format(
                        neuron_set))
                get_individual_firing_rate_snapshots(
                    neuron_set, "spikes-{}.gdf".format(neuron_set),
                    self.neurons[neuron_set],
                    self.cfg['snapshots']['firing_rates'],
                    window=2500.
                )

                for atime in self.cfg['snapshots']['firing_rates']:
                    i_fn = "firing-rates-{}-{}.gdf".format(neuron_set, atime)
                    o_fn = "firing-rates-grid-plot-{}-{}.png".format(
                        neuron_set, atime)
                    args = ['-e', "o_fn='{}'".format(o_fn),
                            '-e', "neuron_set='{}'".format(neuron_set),
                            '-e', "plot_time='{}'".format(atime),
                            '-e', "i_fn='{}'".format(i_fn),
                            '-e', "xmax='{}'".format(xmax),
                            '-e', "ymax='{}'".format(ymax),
                            ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg['plots_dir'],
                                     'plot-firing-rates-snapshot.plt'),
                        args)

    def generate_raster_graphs(self):
        """Plot raster graphs for E and I neurons."""
        # rasters for E I only for the moment
        if len(self.cfg['snapshots']['rasters']) > 0:
            for neuron_set in ['E', 'I']:
                extract_spikes(neuron_set, "spikes-{}.gdf".format(neuron_set),
                               self.cfg['snapshots']['rasters'])

            for t in self.cfg['snapshots']['raster']:
                neuron_dict = {
                    'E': [self.neurons['E'][0][0], self.neurons['E'][-1][0]],
                    'I': [self.neurons['I'][0][0], self.neurons['I'][-1][0]],
                }
                plot_rasters(neuron_dict, t, proportion=0.1)

    def plot_neuron_locations(self):
        """Plot graphs showing locations of neurons."""
        self.lgr.info("Generating locations of various neuron sets.")
        graph_dict = {}
        for key, value in self.neurons.items():
            if "E" in key:
                # skip, we're already doing the centre and border. This
                # overwrites it.
                if key == "lpz_E" or key == "E":
                    continue
                graph_dict[key] = value
        plot_location_grid(graph_dict)

        graph_dict = {}
        for key, value in self.neurons.items():
            if "I" in key:
                # skip, we're already doing the centre and border. This
                # overwrites it.
                if key == "lpz_I" or key == "I":
                    continue
                graph_dict[key] = value
        plot_location_grid(graph_dict)

        # add patterns to that image
        # Patterns are also [nid, xcor, ycor]
        for key, value in self.neurons.items():
            if "pattern-" in key:
                graph_dict[key] = value
        plot_location_grid(graph_dict)

    def plot_snrs(self):
        """Postprocess combined spike files.

        TODO: INCOMPLETE
        """
        return True

        if self.cfg.snr:
            import nestpp.getFiringRates as rg
            import nestpp.calculateSNR as snr
            snrCalculator = snr.calculateSNR()
            patFilesB = []
            patFilesP = []

            for i in range(1, self.cfg.numpats + 1):
                # use firing rate getter and do stuff
                rateGetterB = rg.getFiringRates()
                if rateGetterB.setup(
                    self.cfg.filenamePrefixB + str(i) + ".gdf",
                    'B-{}'.format(i),
                    self.cfg.neurons_B[i-1],
                    self.cfg.rows_per_read
                ):
                    patFilesB = rateGetterB.run(self.cfg.snr_timelist)

                rateGetterP = rg.getFiringRates()
                if rateGetterP.setup(
                    self.cfg.filenamePrefixP + str(i) + ".gdf",
                    'P-{}'.format(i),
                    self.cfg.neurons_P[i-1],
                    self.cfg.rows_per_read
                ):
                    patFilesP = rateGetterP.run(self.cfg.snr_timelist)
                    print("patfilesP is: {} ".format(patFilesP))

                with open("00-SNR-pattern-{}.txt".format(str(i)), 'w') as f:
                    for j in range(0, len(self.cfg.snr_timelist)):
                        snr = snrCalculator.run(patFilesP[j], patFilesB[j])
                        print("{}\t{}".format(
                            self.cfg.snr_timelist[j], snr), file=f)

    def generate_total_synapse_change_graphs(self, plotting_interval=1000.):
        """Process total synapse change graphs.

        :plotting_interval: specify the time intervals between data points
        """
        if "syn_turnover" not in self.cfg['time_graphs']:
            return True

        for neuron_set in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "lpz_c_I",
                           "lpz_b_I", "p_lpz_I"]:
            self.lgr.info(
                "Processing synaptic change graphs for {}".format(neuron_set))
            formed_fn = os.path.join(
                "..", "04-synapses-formed-{}-0.txt".format(neuron_set))
            deleted_fn = os.path.join(
                "..", "04-synapses-deleted-{}-0.txt".format(neuron_set))

            formed_DF = pandas.read_csv(formed_fn, delimiter='\t',
                                        engine='c', skipinitialspace=True,
                                        lineterminator='\n', dtype=float)
            deleted_DF = pandas.read_csv(deleted_fn, delimiter='\t',
                                         engine='c', skipinitialspace=True,
                                         lineterminator='\n', dtype=float)

            with open("04-synapses-formed-{}-totals.txt".format(neuron_set),
                      'w') as f:
                current_plot_time = formed_DF.iloc[0][0]
                current_count = 0
                # index is row[0], so time is row[1]
                # different when using iloc
                for row in formed_DF.itertuples():
                    if (
                            row[1] - current_plot_time <= plotting_interval
                    ):
                        current_count += row[3]

                    else:
                        print("{}\t{}".format(
                            int(current_plot_time/plotting_interval),
                            current_count), file=f)

                        # Ready for the next iteration
                        current_count = row[3]
                        current_plot_time = row[1]

            with open("04-synapses-deleted-{}-totals.txt".format(neuron_set),
                      'w') as f:
                current_plot_time = deleted_DF.iloc[0][0]
                current_count = 0
                for row in deleted_DF.itertuples():
                    if (
                            row[1] - current_plot_time <= plotting_interval
                    ):
                        current_count += row[4]

                    else:
                        print("{}\t{}".format(
                            int(current_plot_time/plotting_interval),
                            current_count), file=f)

                        # Ready for the next iteration
                        current_count = row[4]
                        current_plot_time = row[1]

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-total-synapse-changes.plt'))

    def generate_synapse_graphs(self, sample_size=400):
        """Generate synapse geometry graphs.

        Generates the time graphs, the histograms, and the top level snapshots

        THIS METHOD HAS GOTTEN OUT OF HAND AND NEEDS REFACTORING!

        :sample_size: number of neurons to pick from each region: LPZ C, LPZ
                    B, peri LPZ
        """
        if "synapses" not in self.cfg['time_graphs']:
            return True

        self.lgr.info("Processing synapse graphs..")
        time_list = get_info_from_file_series("..", "08-syn_conns-EE-0-",
                                              ".txt")
        # Get our regions of interest
        regions = []
        for key, value in self.neurons.items():
            if key != 'E' and key != 'I' and key != 'lpz_E' and key != 'lpz_I':
                regions.append(key)
        self.lgr.debug("{} regions identified: {}".format(
            len(regions), regions))

        # make source destination pairs
        src_dest_pairs = list(
            itertools.product(regions, repeat=2)
        )
        self.lgr.debug("Total src dest pairs are {}".format(
            len(src_dest_pairs)))

        # set up proper samples for neuron sets to improve visualisation
        # set a seed so that whenever we post process we get the same samples
        random.seed(21)
        # sample for the top level graphs. I take an E and I neuron in the
        # center of the grid and plot synapses coming in and out of it, instead
        # of taking random sets of neurons.
        sample = {}
        sample['E'] = (3960.,)
        sample['I'] = (8980.,)
        # Samples for histograms of connection lengths
        conn_len_hist_sample = {}
        conn_len_hist_sample['E'] = (
            random.sample(list(self.neurons['lpz_c_E'][:, 0]),
                          k=int(sample_size)) +
            random.sample(list(self.neurons['lpz_b_E'][:, 0]),
                          k=int(sample_size)) +
            random.sample(list(self.neurons['p_lpz_E'][:, 0]),
                          k=int(sample_size))
        )
        conn_len_hist_sample['I'] = (
            random.sample(list(self.neurons['lpz_c_I'][:, 0]),
                          k=int(sample_size/4)) +
            random.sample(list(self.neurons['lpz_b_I'][:, 0]),
                          k=int(sample_size/4)) +
            random.sample(list(self.neurons['p_lpz_I'][:, 0]),
                          k=int(sample_size/4))
        )
        # get origin and radii to draw circles to show different regions
        o_x = (max(self.neurons['o_E'][:, 1]) -
               min(self.neurons['o_E'][:, 1]))/2
        o_y = (max(self.neurons['o_E'][:, 2]) -
               min(self.neurons['o_E'][:, 2]))/2
        self.lgr.debug("Centre is: {}, {}".format(o_x, o_y))
        lpz_c_max_y = (max(self.neurons['lpz_c_E'][:, 2]))
        rad_lpz_c = lpz_c_max_y - o_y
        self.lgr.debug("Rad of lpz c is: {}".format(rad_lpz_c))

        lpz_b_max_y = (max(self.neurons['lpz_b_E'][:, 2]))
        rad_lpz_b = lpz_b_max_y - o_y
        self.lgr.debug("Rad of lpz b is: {}".format(rad_lpz_b))

        p_lpz_max_y = (max(self.neurons['p_lpz_E'][:, 2]))
        rad_p_lpz = p_lpz_max_y - o_y
        self.lgr.debug("Rad of p lpz is: {}".format(rad_p_lpz))

        for synapse_set in ["EE", "EI", "II", "IE"]:
            self.lgr.debug("Processing {} connections".format(synapse_set))
            src_nrn_type = synapse_set[0]
            dest_nrn_type = synapse_set[1]

            self.lgr.debug("Top view sample: {} {} and {} {}".format(
                len(sample[src_nrn_type]), src_nrn_type,
                len(sample[dest_nrn_type]), dest_nrn_type))

            # set up a dictionary that contains information on various regions
            # for this synapse set
            # We want the order to be maintained so that we always get the same
            # order of sources when printing the data for histograms later
            synapse_set_regions = OrderedDict()
            for src, dest in src_dest_pairs:
                # only relevant regions are selected. For example, for an
                # EE synapse, all I regions are useless. There won't be any
                # EE synapses between neurons in those regions.
                if src_nrn_type in src and dest_nrn_type in dest:
                    synapses_name = "{}-to-{}".format(src, dest)
                    newdict = {}
                    newdict['src'] = src
                    newdict['dest'] = dest
                    newdict['weights'] = []
                    newdict['o_fn'] = ("08-syn_conns-{}-{}.txt".format(
                            synapses_name, synapse_set))
                    newdict['o_fh'] = open(newdict['o_fn'], 'w')
                    # all possible connections between the src and dest
                    # hopefully precomputing these will speed up the
                    # postprocessing somewhat
                    # frozenset is immutable and faster than set
                    newdict['conns'] = frozenset(
                        itertools.product(self.neurons[src][:, 0],
                                          self.neurons[dest][:, 0])
                    )
                    synapse_set_regions[synapses_name] = newdict
                    self.lgr.debug("Synapse set up: {}".format(
                        synapses_name))

            # open files for each region that is being projected on
            # and set a header
            # note that I'm using an ordereddict, so the order of the data
            # printed later will be the same when I iterate over the dict
            # again
            syn_con_total_data_fhs = {}
            conductance_total_data_fhs = {}
            # iterate over the various dest regions
            for aregion in regions:
                # only deal with destination regions of this type of neuron
                if dest_nrn_type in aregion:
                    fn = ("081-syn_conns-incoming-totals-{}-{}.txt".format(
                        aregion, synapse_set))
                    fh = open(fn, 'w')
                    syn_con_total_data_fhs[aregion] = fh

                    fn1 = (
                        "081-conductance-incoming-totals-{}-{}.txt".format(
                            aregion, synapse_set)
                    )
                    fh1 = open(fn1, 'w')
                    conductance_total_data_fhs[aregion] = fh1
                    # here onwards, we can iterate over the keys of this
                    # dict to get the destination regions

                    # print the header, remember to ignore this in GNUplot,
                    # or maybe I can use this to generate the xtic labels?
                    # first column is the time
                    sources = ['time']
                    # get all possible source regions for this destination
                    # set, which make up the other columns
                    for key, value in synapse_set_regions.items():
                        if value['dest'] == aregion:
                            sources.append(value['src'])
                    print(*sources, sep='\t', file=fh)
                    print(*sources, sep='\t', file=fh1)

            # start
            for atime in time_list:
                self.lgr.debug(
                    "Processing syn conns for {} at {}".format(
                        synapse_set, float(atime)/1000.))
                syn_conns = pandas.DataFrame()
                syn_conns = combine_files_row_wise(
                    "..", "08-syn_conns-{}-*-{}.txt".format(
                        synapse_set, atime), '\t')

                # reset counts
                for key, value in synapse_set_regions.items():
                    value['weights'] = []

                # for top views and other snapshots, we check if this is on our
                # list of times
                if ((float(atime)/1000.) in
                        self.cfg['snapshots']['synapses']):
                    o_fn_i = "75-connections-top-{}-{}-incoming.txt".format(
                        synapse_set, float(atime)/1000.)
                    o_fh_i = open(o_fn_i, 'w')
                    o_fn_o = "75-connections-top-{}-{}-outgoing.txt".format(
                        synapse_set, float(atime)/1000.)
                    o_fh_o = open(o_fn_o, 'w')

                    o_fn_l_i = "75-syn-lengths-{}-{}-incoming.txt".format(
                        synapse_set, float(atime)/1000.)
                    o_fh_l_i = open(o_fn_l_i, 'w')
                    o_fn_l_o = "75-syn-lengths-{}-{}-outgoing.txt".format(
                        synapse_set, float(atime)/1000.)
                    o_fh_l_o = open(o_fn_l_o, 'w')

                # iterate over synapses between different regions
                for row in syn_conns.itertuples(index=True, name=None):
                    # see what regions the connection is between
                    for key, value in synapse_set_regions.items():
                        if (row[0], row[1]) in value['conns']:
                            value['weights'].append(abs(row[2]))

                    # for the top view snapshots, check if the neuron we've
                    # picked to plot is a source or a destination
                    # it's a source
                    if ((float(atime)/1000.) in
                            self.cfg['snapshots']['synapses']):
                        if row[0] in sample[src_nrn_type]:
                            src_info = self.neurons[src_nrn_type][int(
                                row[0] - self.neurons[src_nrn_type][0][0])]
                            dest_info = self.neurons[dest_nrn_type][int(
                                row[1] - self.neurons[dest_nrn_type][0][0])]

                            print("{}\t{}\t{}\t{}".format(
                                    src_info[3], src_info[4],
                                    dest_info[3], dest_info[4]),
                                  file=o_fh_o)

                        # it's a destination
                        if row[1] in sample[dest_nrn_type]:
                            src_info = self.neurons[src_nrn_type][int(
                                row[0] - self.neurons[src_nrn_type][0][0])]
                            dest_info = self.neurons[dest_nrn_type][int(
                                row[1] - self.neurons[dest_nrn_type][0][0])]

                            print("{}\t{}\t{}\t{}".format(
                                    src_info[3], src_info[4],
                                    dest_info[3], dest_info[4]),
                                  file=o_fh_i)

                        # for length histograms we have a different, larger
                        # sample, since only looking at one neuron would not be
                        # sufficient it's a source
                        if row[0] in conn_len_hist_sample[src_nrn_type]:
                            src_info = self.neurons[src_nrn_type][int(
                                row[0] - self.neurons[src_nrn_type][0][0])]
                            dest_info = self.neurons[dest_nrn_type][int(
                                row[1] - self.neurons[dest_nrn_type][0][0])]

                            delta_x = abs(src_info[3] - dest_info[3])
                            # o_x is width/2
                            if delta_x > o_x:
                                delta_x = delta_x - o_x

                            delta_y = abs(src_info[4] - dest_info[4])
                            # o_x is height/2
                            if delta_y > o_y:
                                delta_y = delta_y - o_y

                            print("{}".format(math.hypot(delta_x, delta_y)),
                                  file=o_fh_l_o)

                        # it's a destination
                        if row[1] in conn_len_hist_sample[dest_nrn_type]:
                            src_info = self.neurons[src_nrn_type][int(
                                row[0] - self.neurons[src_nrn_type][0][0])]
                            dest_info = self.neurons[dest_nrn_type][int(
                                row[1] - self.neurons[dest_nrn_type][0][0])]

                            delta_x = abs(src_info[3] - dest_info[3])
                            # o_x is width/2
                            if delta_x > o_x:
                                delta_x = delta_x - o_x

                            delta_y = abs(src_info[4] - dest_info[4])
                            # o_x is height/2
                            if delta_y > o_y:
                                delta_y = delta_y - o_y

                            print("{}".format(math.hypot(delta_x, delta_y)),
                                  file=o_fh_l_i)

                # Now that we've collected all our metrics in a single pass
                # over the data, we can close files and plot the graphs for the
                # specified time
                if ((float(atime)/1000.) in
                        self.cfg['snapshots']['synapses']):
                    o_fh_i.close()
                    o_fh_o.close()
                    o_fh_l_i.close()
                    o_fh_l_o.close()

                    # now on to plotting
                    p_fn = "75-connections-top-{}-{}-incoming.png".format(
                        synapse_set, float(atime)/1000.)
                    args = [
                        "-e",
                        "o_fn='{}'".format(p_fn),
                        "-e",
                        "i_fn='{}'".format(o_fn_i),
                        "-e",
                        "o_x='{}'".format(o_x),
                        "-e",
                        "o_y='{}'".format(o_y),
                        "-e",
                        "r_p_lpz='{}'".format(rad_p_lpz),
                        "-e",
                        "r_lpz_b='{}'".format(rad_lpz_b),
                        "-e",
                        "r_lpz_c='{}'".format(rad_lpz_c),
                        "-e",
                        "plot_title='incoming synapses for {} at {}'".format(
                            synapse_set, float(atime)/1000.)
                    ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg['plots_dir'],
                                     'plot-top-view-connections.plt'),
                        args)

                    p_fn = "75-connections-top-{}-{}-outgoing.png".format(
                        synapse_set, float(atime)/1000.)
                    args = [
                        "-e",
                        "o_fn='{}'".format(p_fn),
                        "-e",
                        "i_fn='{}'".format(o_fn_o),
                        "-e",
                        "o_x='{}'".format(o_x),
                        "-e",
                        "o_y='{}'".format(o_y),
                        "-e",
                        "r_p_lpz='{}'".format(rad_p_lpz),
                        "-e",
                        "r_lpz_b='{}'".format(rad_lpz_b),
                        "-e",
                        "r_lpz_c='{}'".format(rad_lpz_c),
                        "-e",
                        "plot_title='outgoing synapses for {} at {}'".format(
                            synapse_set, float(atime)/1000.)
                    ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg['plots_dir'],
                                     'plot-top-view-connections.plt'),
                        args)

                    p_h_fn = (
                        "75-connections-hist-{}-{}-incoming.png".format(
                            synapse_set, float(atime)/1000.
                        ))
                    args = [
                        "-e",
                        "o_fn='{}'".format(p_h_fn),
                        "-e",
                        "i_fn='{}'".format(o_fn_l_i),
                        "-e",
                        "plot_title='Incoming syn lens for {} at {}'".format(
                            synapse_set, float(atime)/1000.)
                    ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg['plots_dir'],
                                     'plot-connection-length-hist.plt'),
                        args)

                    p_h_fn = (
                        "75-connections-hist-{}-{}-outgoing.png".format(
                            synapse_set, float(atime)/1000.
                        ))
                    args = [
                        "-e",
                        "o_fn='{}'".format(p_h_fn),
                        "-e",
                        "i_fn='{}'".format(o_fn_l_o),
                        "-e",
                        "plot_title='Outgoing syn lens for {} at {}'".format(
                            synapse_set, float(atime)/1000.)
                    ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg['plots_dir'],
                                     'plot-connection-length-hist.plt'),
                        args)

                for dest, fh in syn_con_total_data_fhs.items():
                    # get the four destinations for this synapse type
                    # now for each destination, prepare a row to be
                    # printed first column in the time
                    totals = [(float(atime)/1000.), ]
                    # go over all the possible sources and append the
                    # number of incoming connections like we did before,
                    # and because we've used an ordereddict, the order of
                    # the data will correspond to the header we printed
                    # before
                    for key, value in synapse_set_regions.items():
                        if value['dest'] == dest:
                            totals.append(len(value['weights']))

                    # print it to the file corresponding to the dest
                    print(*totals, sep='\t', file=fh)

                # same for conductance histogram files
                for dest, fh in conductance_total_data_fhs.items():
                    totals = [(float(atime)/1000.), ]
                    for key, value in synapse_set_regions.items():
                        if value['dest'] == dest:
                            totals.append(numpy.sum(value['weights']))

                    # print it to the file corresponding to the dest
                    print(*totals, sep='\t', file=fh)

                # print synapse counts for different regions
                for key, value in synapse_set_regions.items():
                    # handle the case where there are no connections at all
                    if len(value['weights']):
                        print(
                            "{}\t{}\t{}\t{}\t{}".format
                            (
                                float(atime)/1000., len(value['weights']),
                                numpy.sum(value['weights']),
                                numpy.mean(value['weights']),
                                numpy.std(value['weights'])),
                            file=value['o_fh'])
                    else:
                        print(
                            "{}\t{}\t{}\t{}\t{}".format
                            (float(atime)/1000., 0, 0, "NaN", "NaN"),
                            file=value['o_fh'])

            # close file handlers for each region file for this synapse type:
            for key, value in synapse_set_regions.items():
                f = value['o_fh']
                f.close()
                self.lgr.info("Closed {}".format(value['o_fn']))

            # close the hist data file handles
            # no need to check if there's anything in here, it just won't have
            # anything to iterate over if the dict is empty
            for dest, fh in syn_con_total_data_fhs.items():
                fh.close()

            for dest, fh in conductance_total_data_fhs.items():
                fh.close()

            self.lgr.info(
                "Processed syn conns for {} neurons..".format(
                    synapse_set))

        # Now that all the regions have been processed, we can do the overall
        # net processing.
        # Each region only has two files, one incoming I, one incoming E,
        # so the helper function can be used.
        # Now, I have 4 columns---net (E-I) from each region, and I can
        # plot whatever I wish---per region, or totals
        for region in regions:
            # these files have a header
            # E - I
            if 'E' in region:
                df_E = pandas.read_csv(
                    '081-conductance-incoming-totals-{}-EE.txt'.format(
                        region), sep='\t', header=None, skiprows=1,
                    index_col=0, dtype=float
                )
                df_I = pandas.read_csv(
                    '081-conductance-incoming-totals-{}-IE.txt'.format(
                        region), sep='\t', header=None, skiprows=1,
                    index_col=0, dtype=float
                )
            else:
                df_E = pandas.read_csv(
                    '081-conductance-incoming-totals-{}-EI.txt'.format(
                        region), sep='\t', header=None, skiprows=1,
                    index_col=0, dtype=float
                )
                df_I = pandas.read_csv(
                    '081-conductance-incoming-totals-{}-II.txt'.format(
                        region), sep='\t', header=None, skiprows=1,
                    index_col=0, dtype=float
                )

            net_cond_df = df_E.subtract(df_I)
            slope_df = net_cond_df.sum(axis=1).diff()

            final_df = pandas.concat([net_cond_df, slope_df], axis=1)

            final_df.to_csv(
                '081-conductance-net-{}.txt'.format(region), sep='\t',
                header=None, na_rep='NaN')

        # Files must be closed before calling the plotters, because closing the
        # files flushes the streams. Otherwise, the files may be empty and
        # gnuplot will fail.
        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'], 'plot-synapse-metrics.plt'))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-regional-synapses-histograms.plt'))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-conductance-metrics.plt'))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-regional-conductance-histograms.plt'))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-net-conductance-metrics.plt'))

        self.lgr.info("Processed all synaptic connections..")

    def plot_growth_curves(self):
        """
        Plot growth curves using values from parameter output file.

        """
        # Doesn't need calcium metric calculations
        plot_using_gnuplot_binary(os.path.join(self.cfg['plots_dir'],
                                               'plot-growthcurves.plt'))
        self.lgr.info("Plotted growth curves for both I and E neurons")

    def main(self):
        """Do everything."""
        start_time = time.clock()

        self.plot_neuron_locations()
        self.plot_growth_curves()

        self.lgr.info("Running a separate process each for different bits.")
        processes = []
        processes.append(Process(target=self.generate_firing_rate_graphs))
        processes.append(Process(target=self.generate_firing_rate_histograms))
        processes.append(Process(target=self.generate_raster_graphs))
        processes.append(
            Process(target=self.generate_firing_rate_grid_snapshots))
        processes.append(Process(target=self.generate_calcium_graphs))
        processes.append(
            Process(target=self.generate_total_synapse_change_graphs))
        processes.append(
            Process(target=self.generate_synaptic_element_graphs))
        processes.append(Process(target=self.generate_synapse_graphs,
                                 args=(200.,)))

        self.lgr.info("Starting all processes")
        for proc in processes:
            proc.start()

        #  self.plot_snrs()
        self.lgr.info("Waiting for all processes to finish")
        for proc in processes:
            proc.join()

        end_time = time.clock()
        self.lgr.info("Post processing took {} minutes".format(
            (end_time - start_time)/60
        ))


if __name__ == "__main__":
    runner = Postprocess()
    runner.setup("config.ini")
    runner.main()
