#!/usr/bin/env python3
"""
Postprocess the spike raster files to generate plots.

File: postprocess.py

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

# module imports
from nestpp.utils import (get_config, get_numpats)
from nestpp.plotting_utils import (plot_using_gnuplot_binary,
                                   plot_firing_rate_histograms,
                                   plot_location_grid, plot_rasters)
from nestpp.loggerpp import get_module_logger
from nestpp.spike_utils import (get_firing_rate_metrics,
                                get_individual_firing_rate_snapshots,
                                extract_spikes)
from nestpp.file_utils import (var_combine_files_column_wise,
                               get_info_from_file_series,
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
            neuron_set_o_fn = "05-se-{}-all.txt".format(neuron_set)
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

    def generate_conductance_graphs(self):
        """Post process conductances and generate all graphs.

        The conductance sets do not change, so this doesn't require so much
        configuration.

        :returns: True if all went well, else False

        """
        if "conductances" not in self.cfg['time_graphs']:
            return True

        self.lgr.info("Generating conductance graphs vs time")
        # EE
        conductances_EE = pandas.DataFrame()
        conductances_EE = var_combine_files_column_wise(
            "../", "01-synaptic-weights-EE-*.txt", '\t')
        if not conductances_EE.empty:
            conductances_mean_EE = pandas.concat(
                [conductances_EE.mean(axis=1),
                 conductances_EE.std(axis=1)],
                axis=1)
            conductances_mean_fn_EE = (
                "01-synaptic-weights-EE-mean-all.txt"
                )
            conductances_mean_EE.to_csv(
                conductances_mean_fn_EE, sep='\t',
                header=None, line_terminator='\n')

            conductances_totals_EE = conductances_EE.sum(axis=1)
            conductances_total_fn_EE = (
                "01-synaptic-weights-EE-total-all.txt"
            )
            conductances_totals_EE.to_csv(
                conductances_total_fn_EE, sep='\t',
                header=None)
            self.lgr.info("Processed EE conductances..")
        else:
            self.lgr.warning("No dataframe for EE conductances. Skipping.")
        # EI
        conductances_EI = pandas.DataFrame()
        conductances_EI = var_combine_files_column_wise(
            "../", "01-synaptic-weights-EI-*.txt", '\t')
        if not conductances_EI.empty:
            conductances_mean_EI = pandas.concat(
                [conductances_EI.mean(axis=1),
                 conductances_EI.std(axis=1)],
                axis=1)
            conductances_mean_fn_EI = (
                "01-synaptic-weights-EI-mean-all.txt"
                )
            conductances_mean_EI.to_csv(
                conductances_mean_fn_EI, sep='\t',
                header=None, line_terminator='\n')

            conductances_totals_EI = conductances_EI.sum(axis=1)
            conductances_total_fn_EI = (
                "01-synaptic-weights-EI-total-all.txt"
            )
            conductances_totals_EI.to_csv(
                conductances_total_fn_EI, sep='\t',
                header=None)
            self.lgr.info("Processed EI conductances..")
        else:
            self.lgr.warning("No dataframe for EI conductances. Skipping.")
        # II
        conductances_II = pandas.DataFrame()
        conductances_II = var_combine_files_column_wise(
            "../", "01-synaptic-weights-II-*.txt", '\t')
        if not conductances_II.empty:
            conductances_mean_II = pandas.concat(
                [conductances_II.mean(axis=1),
                 conductances_II.std(axis=1)],
                axis=1)
            conductances_mean_fn_II = (
                "01-synaptic-weights-II-mean-all.txt"
                )
            conductances_mean_II.to_csv(
                conductances_mean_fn_II, sep='\t',
                header=None, line_terminator='\n')

            conductances_totals_II = conductances_II.sum(axis=1)
            conductances_total_fn_II = (
                "01-synaptic-weights-II-total-all.txt"
            )
            conductances_totals_II.to_csv(
                conductances_total_fn_II, sep='\t',
                header=None)
            self.lgr.info("Processed II conductances..")
        else:
            self.lgr.warning("No dataframe for II conductances. Skipping.")
        # IE
        conductances_IE = pandas.DataFrame()
        conductances_IE = var_combine_files_column_wise(
            "../", "01-synaptic-weights-IE-*.txt", '\t')
        if not conductances_IE.empty:
            conductances_mean_IE = pandas.concat(
                [conductances_IE.mean(axis=1),
                 conductances_IE.std(axis=1)],
                axis=1)
            conductances_mean_fn_IE = (
                "01-synaptic-weights-IE-mean-all.txt"
                )
            conductances_mean_IE.to_csv(
                conductances_mean_fn_IE, sep='\t',
                header=None, line_terminator='\n')

            conductances_totals_IE = conductances_IE.sum(axis=1)
            conductances_total_fn_IE = (
                "01-synaptic-weights-IE-total-all.txt"
            )
            conductances_totals_IE.to_csv(
                conductances_total_fn_IE, sep='\t',
                header=None)
            self.lgr.info("Processed IE conductances..")
        else:
            self.lgr.warning("No dataframe for IE conductances. Skipping.")

        if (
                (not conductances_EE.empty) and
                (not conductances_EI.empty) and
                (not conductances_IE.empty) and
                (not conductances_II.empty)
        ):
            plot_using_gnuplot_binary(
                os.path.join(self.cfg['plots_dir'],
                             'plot-conductance-metrics.plt'))
            self.lgr.info("Conductance graphs plotted..")
        else:
            self.lgr.warning("Conductance graphs not generated.")

    def generate_firing_rate_graphs(self):
        """Generate firing rate graphs."""
        if "firing_rates" not in self.cfg['time_graphs']:
            return True

        self.lgr.info("Generating mean firing rate graphs vs time")

        for neuron_set in self.neurons.keys():
            get_firing_rate_metrics(
                neuron_set, "spikes-{}.gdf".format(neuron_set),
                len(self.neurons[neuron_set]))

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

            for time in self.cfg['snapshots']['firing_rate_histograms']:
                plot_firing_rate_histograms(histlist, time)

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
                    self.cfg['snapshots']['firing_rates'])

                for time in self.cfg['snapshots']['firing_rates']:
                    i_fn = "firing-rates-{}-{}.gdf".format(neuron_set, time)
                    o_fn = "firing-rates-grid-plot-{}-{}.png".format(
                        neuron_set, time)
                    args = ['-e', "o_fn='{}'".format(o_fn),
                            '-e', "neuron_set='{}'".format(neuron_set),
                            '-e', "plot_time='{}'".format(time),
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

    def generate_synapse_graphs(self, sample_percent=0.02):
        """Generate synapse geometry graphs.

        Generates the time graphs, the histograms, and the top level snapshots

        :sample_percent: percentage of neurons to take in sample per region for
                            the top level snapshots
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
        sample = {}
        sample['E'] = (
            random.sample(list(self.neurons['lpz_c_E'][:, 0]),
                          k=int(len(self.neurons['lpz_c_E'])*sample_percent)) +
            random.sample(list(self.neurons['lpz_b_E'][:, 0]),
                          k=int(len(self.neurons['lpz_b_E'])*sample_percent)) +
            random.sample(list(self.neurons['p_lpz_E'][:, 0]),
                          k=int(len(self.neurons['p_lpz_E'])*sample_percent)) +
            random.sample(list(self.neurons['o_E'][:, 0]),
                          k=int(len(self.neurons['o_E'])*sample_percent))
        )
        sample['I'] = (
            random.sample(list(self.neurons['lpz_c_I'][:, 0]),
                          k=int(len(self.neurons['lpz_c_I'])*sample_percent)) +
            random.sample(list(self.neurons['lpz_b_I'][:, 0]),
                          k=int(len(self.neurons['lpz_b_I'])*sample_percent)) +
            random.sample(list(self.neurons['p_lpz_I'][:, 0]),
                          k=int(len(self.neurons['p_lpz_I'])*sample_percent)) +
            random.sample(list(self.neurons['o_I'][:, 0]),
                          k=int(len(self.neurons['o_I'])*sample_percent))
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
            # get ids of subsets for the top view graphs
            # plotting all synapse connections makes the plot useless since it
            # ends up too dense to be able to see anything
            src_sample = sample[src_nrn_type]
            dest_sample = sample[dest_nrn_type]
            connection_sample = frozenset(itertools.product(src_sample,
                                                            dest_sample))
            self.lgr.debug("Sample: {} {} and {} {}".format(
                len(src_sample), src_nrn_type, len(dest_sample),
                dest_nrn_type))

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
                    newdict['num'] = 0
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
            hist_data_fhs = {}
            if len(self.cfg['snapshots']['synapses']):
                # I'm not iterating over the synapse_set dict here because
                # there the destinations would be repeated
                for aregion in regions:
                    # only deal with destination regions of this type of neuron
                    if dest_nrn_type in aregion:
                        fn = ("081-syn_conns-incoming-hist-{}-{}.txt".format(
                            aregion, synapse_set))
                        fh = open(fn, 'w')
                        hist_data_fhs[aregion] = fh
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
                    value['num'] = 0

                if "synapses_top" in self.cfg['time_graphs']:
                    # sample for top view at each time
                    synapse_set_o_fn = "08-syn_conns-top-{}-{}.txt".format(
                        synapse_set, float(atime)/1000.)
                    syn_set_o_fh = open(synapse_set_o_fn, 'w')

                for row in syn_conns.itertuples(index=True, name=None):
                    if "synapses_top" in self.cfg['time_graphs']:
                        # only print the ones that are in our sample for the
                        # top view plot
                        if (row[0], row[1]) in connection_sample:
                            src_info = self.neurons[src_nrn_type][int(
                                row[0] - self.neurons[src_nrn_type][0][0])]
                            dest_info = self.neurons[dest_nrn_type][int(
                                row[1] - self.neurons[dest_nrn_type][0][0])]

                            print("{}\t{}\t{}\t{}".format(
                                    src_info[3], src_info[4],
                                    dest_info[3], dest_info[4]),
                                  file=syn_set_o_fh)

                    # count synapses in different regions
                    for key, value in synapse_set_regions.items():
                        if (row[0], row[1]) in value['conns']:
                            value['num'] += 1

                if "synapses_top" in self.cfg['time_graphs']:
                    # close output plot file for this time
                    syn_set_o_fh.close()
                    # plot top view graph for this time
                    synapse_set_p_fn = "08-syn_conns-top-{}-{}.png".format(
                        synapse_set, float(atime)/1000.)
                    args = [
                        "-e",
                        "o_fn='{}'".format(synapse_set_p_fn),
                        "-e",
                        "i_fn='{}'".format(synapse_set_o_fn),
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
                        "plot_title='Synapses for {} at {}s'".format(
                            synapse_set, float(atime)/1000.),
                    ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg['plots_dir'],
                                     'plot-top-view-connections.plt'),
                        args)

                # print synapse counts for different regions
                for key, value in synapse_set_regions.items():
                    print("{}\t{}".format(float(atime)/1000.,
                                          value['num']),
                          file=value['o_fh'])

                if ((float(atime)/1000.) in
                        self.cfg['snapshots']['synapses']):
                    for dest, fh in hist_data_fhs.items():
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
                                totals.append(value['num'])

                        # print it to the file corresponding to the dest
                        print(*totals, sep='\t', file=fh)

            # close file handlers for each region file for this synapse type:
            for key, value in synapse_set_regions.items():
                f = value['o_fh']
                f.close()
                self.lgr.info("Closed {}".format(value['o_fn']))

            # close the hist data file handles
            # no need to check if there's anything in here, it just won't have
            # anything to iterate over if the dict is empty
            for dest, fh in hist_data_fhs.items():
                fh.close()

            self.lgr.info(
                "Processed syn conns for {} neurons..".format(
                    synapse_set))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'], 'plot-regional-synapses.plt'))

        plot_using_gnuplot_binary(
            os.path.join(self.cfg['plots_dir'],
                         'plot-regional-synapses-histograms.plt'))

    def plot_growth_curves(self):
        """
        Plot growth curves using values from parameter output file.

        """
        # Doesn't need calcium metric calculations
        plot_using_gnuplot_binary(os.path.join(self.cfg['plots_dir'],
                                               'plot-growthcurves.plt'))
        self.lgr.info("Plotted growth curves for both I and E neurons")

    def plot_initial_connectivity(self):
        """
        Plot the initial connectivity of one neuron from each region.
        """
        self.lgr.info("Processing initial connectivity graphs..")
        # get origin and radii to draw circles to show different regions
        # can probably convert this to a function so it can be reused
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

        # pick one E and one I neuron
        sample = {}
        sample['E'] = (3960.,)
        sample['I'] = (8980.,)
        self.lgr.debug("E sample for top plot is: {}".format(sample['E']))
        self.lgr.debug("I sample for top plot is: {}".format(sample['I']))

        # find and print, plot all synapses these two neurons are involved in
        for synapse_set in ["EE", "EI", "II", "IE"]:
            o_fn_i = "75-initial-connections-top-{}-incoming.txt".format(
                synapse_set)
            o_fh_i = open(o_fn_i, 'w')
            o_fn_o = "75-initial-connections-top-{}-outgoing.txt".format(
                synapse_set)
            o_fh_o = open(o_fn_o, 'w')
            src_nrn_type = synapse_set[0]
            dest_nrn_type = synapse_set[1]
            syn_conns = pandas.DataFrame()
            syn_conns = combine_files_row_wise(
                "..", "08-syn_conns-{}-*-0.0.txt".format(
                    synapse_set), '\t')

            for row in syn_conns.itertuples(index=True, name=None):
                # it's a source
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

            o_fh_i.close()
            o_fh_o.close()

            p_fn = "75-initial-connections-top-{}-incoming.png".format(
                synapse_set)
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
                "plot_title='Initial incoming synapses for {}'".format(
                    synapse_set)
            ]
            plot_using_gnuplot_binary(
                os.path.join(self.cfg['plots_dir'],
                             'plot-top-view-connections.plt'),
                args)

            p_fn = "75-initial-connections-top-{}-outgoing.png".format(
                synapse_set)
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
                "plot_title='Initial outgoing synapses for {}'".format(
                    synapse_set)
            ]
            plot_using_gnuplot_binary(
                os.path.join(self.cfg['plots_dir'],
                             'plot-top-view-connections.plt'),
                args)

        # Do histograms separately
        sample['E'] = (
            random.sample(list(self.neurons['lpz_c_E'][:, 0]),
                          k=5) +
            random.sample(list(self.neurons['lpz_b_E'][:, 0]),
                          k=5) +
            random.sample(list(self.neurons['p_lpz_E'][:, 0]),
                          k=5) +
            random.sample(list(self.neurons['o_E'][:, 0]),
                          k=5)
        )
        sample['I'] = (
            random.sample(list(self.neurons['lpz_c_I'][:, 0]),
                          k=5) +
            random.sample(list(self.neurons['lpz_b_I'][:, 0]),
                          k=5) +
            random.sample(list(self.neurons['p_lpz_I'][:, 0]),
                          k=5) +
            random.sample(list(self.neurons['o_I'][:, 0]),
                          k=5)
        )
        self.lgr.debug("E sample for histograms is: {}".format(sample['E']))
        self.lgr.debug("I sample for histograms is: {}".format(sample['I']))

        # find and print, plot all synapses these two neurons are involved in
        for synapse_set in ["EE", "EI", "II", "IE"]:
            o_fn_l_i = "75-initial-connections-lengths-{}-incoming.txt".format(
                synapse_set)
            o_fh_l_i = open(o_fn_l_i, 'w')
            o_fn_l_o = "75-initial-connections-lengths-{}-outgoing.txt".format(
                synapse_set)
            o_fh_l_o = open(o_fn_l_o, 'w')
            src_nrn_type = synapse_set[0]
            dest_nrn_type = synapse_set[1]
            syn_conns = pandas.DataFrame()
            syn_conns = combine_files_row_wise(
                "..", "08-syn_conns-{}-*-0.0.txt".format(
                    synapse_set), '\t')

            for row in syn_conns.itertuples(index=True, name=None):
                # it's a source
                if row[0] in sample[src_nrn_type]:
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
                if row[1] in sample[dest_nrn_type]:
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

            o_fh_l_i.close()
            o_fh_l_o.close()

            p_h_fn = "75-initial-connections-hist-{}-incoming.png".format(
                synapse_set)
            args = [
                "-e",
                "o_fn='{}'".format(p_h_fn),
                "-e",
                "i_fn='{}'".format(o_fn_l_i),
                "-e",
                "plot_title='Incoming connection lengths for {}'".format(
                    synapse_set)
            ]
            plot_using_gnuplot_binary(
                os.path.join(self.cfg['plots_dir'],
                             'plot-connection-length-hist.plt'),
                args)

            p_h_fn = "75-initial-connections-hist-{}-outgoing.png".format(
                synapse_set)
            args = [
                "-e",
                "o_fn='{}'".format(p_h_fn),
                "-e",
                "i_fn='{}'".format(o_fn_l_o),
                "-e",
                "plot_title='Outgoing connection lengths for {}'".format(
                    synapse_set)
            ]
            plot_using_gnuplot_binary(
                os.path.join(self.cfg['plots_dir'],
                             'plot-connection-length-hist.plt'),
                args)

        self.lgr.info("Processed initial connectivity samples..")

    def main(self):
        """Do everything."""

        self.plot_neuron_locations()
        self.plot_growth_curves()
        self.plot_initial_connectivity()

        self.lgr.info("Running a separate process each for different bits.")
        processes = []
        processes.append(Process(target=self.generate_firing_rate_graphs))
        processes.append(Process(target=self.generate_firing_rate_histograms))
        processes.append(Process(target=self.generate_raster_graphs))
        processes.append(
            Process(target=self.generate_firing_rate_grid_snapshots))
        processes.append(Process(target=self.generate_conductance_graphs))
        processes.append(Process(target=self.generate_calcium_graphs))
        processes.append(
            Process(target=self.generate_total_synapse_change_graphs))
        processes.append(
            Process(target=self.generate_synaptic_element_graphs))
        processes.append(Process(target=self.generate_synapse_graphs,
                                 args=(0.02,)))

        self.lgr.info("Starting all processes")
        for proc in processes:
            proc.start()

        #  self.plot_snrs()
        self.lgr.info("Waiting for all processes to finish")
        for proc in processes:
            proc.join()


if __name__ == "__main__":
    runner = Postprocess()
    runner.setup("config.ini")
    runner.main()
