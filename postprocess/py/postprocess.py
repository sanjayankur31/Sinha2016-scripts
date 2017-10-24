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
import sys
import os
import pandas
import numpy
import subprocess
from select import select

# module imports
from nestpp.utils import (get_config, plot_using_gnuplot_binary,
                          plot_histograms, plot_location_grid, plot_rasters)
from nestpp.loggerpp import get_module_logger
from nestpp.spikes import (get_firing_rate_metrics,
                           get_individual_firing_rate_snapshots,
                           extract_spikes)


class Postprocess:

    """Main post process worker class."""

    def __init__(self, configfile):
        """Initialise."""
        self.cfg = get_config(configfile)
        self.lgr = get_module_logger(__name__)
        self.neurons = {}

    def __postprocess_synaptic_elements_individual(self):
        """Post process synaptic elements from individual neuronal files."""
        if self.cfg.SEIndividualMetrics:
            print("Processing synaptic elements for individual neurons..")
            import nestpp.combineFiles
            combiner = nestpp.combineFiles.CombineFiles()

            # E neurons
            timeddfDict = combiner.combineTimedTSVColDataFiles(
                self.cfg.unconsolidatedFilesDir,
                self.cfg.filenamePrefixSEIndividualE)

            if timeddfDict:
                for time, df in timeddfDict.items():
                    syn_elms_ind_DF_filename = (
                        self.cfg.filenamePrefixSEIndividualE +
                        str(time) + ".txt")
                    df.to_csv(
                        syn_elms_ind_DF_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for E neurons" +
                          " at time {}..".format(time))

                    args = ['gnuplot',
                            '-e',
                            "plotname='{}'".format(
                                self.cfg.filenamePrefixSEIndividualE +
                                str(time) + ".png"),
                            '-e',
                            'plottitle={}'.format(
                                "'Synaptic elements at time {}'".format(
                                    str(time))),
                            '-e',
                            "inputfile='{}'".format(
                                syn_elms_ind_DF_filename),
                            os.path.join(
                                self.cfg.postprocess_home,
                                self.cfg.gnuplot_files_dir,
                                'plot-ind-synaptic-elements-metrics.plt')]
                    subprocess.call(args)
                    print("E neuron synaptic elements graph" +
                          " at time {} generated.".format(time))
            else:
                print("No dataframes for E synaptic elements. Skipping.")

            # I neurons
            timeddfDict = combiner.combineTimedTSVColDataFiles(
                self.cfg.unconsolidatedFilesDir,
                self.cfg.filenamePrefixSEIndividualI)

            if timeddfDict:
                for time, df in timeddfDict.items():
                    syn_elms_ind_DF_filename = (
                        self.cfg.filenamePrefixSEIndividualI +
                        str(time) + ".txt")
                    df.to_csv(
                        syn_elms_ind_DF_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for I neurons" +
                          " at time {}..".format(time))

                    args = ['gnuplot',
                            '-e',
                            "plotname='{}'".format(
                                self.cfg.filenamePrefixSEIndividualI +
                                str(time) + ".png"),
                            '-e',
                            'plottitle={}'.format(
                                "'Synaptic elements at time {}'".format(
                                    str(time))),
                            '-e',
                            "inputfile='{}'".format(
                                syn_elms_ind_DF_filename),
                            os.path.join(
                                self.cfg.postprocess_home,
                                self.cfg.gnuplot_files_dir,
                                'plot-ind-synaptic-elements-metrics.plt')]
                    subprocess.call(args)
                    print("I neuron synaptic elements graph" +
                          " at time {} generated.".format(time))
            else:
                print("No dataframes for I synaptic elements. Skipping.")

    def __postprocess_synaptic_elements_all(self):
        """Post total synaptic element files."""
        if self.cfg.SETotalsMetrics:
            print("Processing synaptic element information..")
            import nestpp.combineFiles
            combiner = nestpp.combineFiles.CombineFiles()

            syn_elms_DF_E = pandas.DataFrame()
            syn_elms_DF_I = pandas.DataFrame()
            syn_elms_DF_lpz__E = pandas.DataFrame()
            syn_elms_DF_lpz__I = pandas.DataFrame()
            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixSETotalsE]):
                syn_elms_DF_E = combiner.combineTSVRowData(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixSETotalsE)

                if not syn_elms_DF_E.empty:
                    syn_elms_E_filename = (
                        self.cfg.filenamePrefixSETotalsE + 'all.txt'
                    )
                    syn_elms_DF_E.to_csv(
                        syn_elms_E_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for E neurons..")
                else:
                    print("No dataframe for all E syn elements. Skipping.")
            else:
                syn_elms_DF_E = syn_elms_DF_E.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixSETotalsLPZE]):
                syn_elms_DF_lpz__E = combiner.combineTSVRowData(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixSETotalsLPZE)

                if not syn_elms_DF_lpz__E.empty:
                    syn_elms_E_filename = (
                        self.cfg.filenamePrefixSETotalsLPZE + 'all.txt'
                    )
                    syn_elms_DF_lpz__E.to_csv(
                        syn_elms_E_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for LPZ E neurons..")
                else:
                    print("No dataframe for all E syn elements. Skipping.")
            else:
                syn_elms_DF_lpz__E = syn_elms_DF_lpz__E.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixSETotalsI]):
                syn_elms_DF_I = combiner.combineTSVRowData(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixSETotalsI)

                if not syn_elms_DF_I.empty:
                    syn_elms_I_filename = (
                        self.cfg.filenamePrefixSETotalsI + 'all.txt'
                    )
                    syn_elms_DF_I.to_csv(
                        syn_elms_I_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for I neurons..")
            else:
                syn_elms_DF_I = syn_elms_DF_I.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixSETotalsLPZI]):
                syn_elms_DF_lpz__I = combiner.combineTSVRowData(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixSETotalsLPZI)

                if not syn_elms_DF_lpz__I.empty:
                    syn_elms_I_filename = (
                        self.cfg.filenamePrefixSETotalsLPZI + 'all.txt'
                    )
                    syn_elms_DF_lpz__I.to_csv(
                        syn_elms_I_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for LPZ I neurons..")
            else:
                syn_elms_DF_lpz__I = syn_elms_DF_lpz__I.append([0])

            args = (os.path.join(
                self.cfg.postprocess_home,
                self.cfg.gnuplot_files_dir,
                    'plot-synaptic-elements-metrics.plt'))
            subprocess.call(['gnuplot',
                            args])

            args = (os.path.join(
                self.cfg.postprocess_home,
                self.cfg.gnuplot_files_dir,
                    'plot-lpz-synaptic-elements-metrics.plt'))
            subprocess.call(['gnuplot',
                            args])
            print("Synaptic elements graphs generated..")

    def __postprocess_calcium(self):
        """Postprocess calcium files."""
        if self.cfg.calciumMetrics:
            import nestpp.combineFiles
            calDF_E = pandas.DataFrame()
            calDF_I = pandas.DataFrame()
            calDF_lpz_E = pandas.DataFrame()
            calDF_lpz_I = pandas.DataFrame()
            print("Processing calcium concentration information..")
            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixCalciumE]):
                combiner = nestpp.combineFiles.CombineFiles()

                calDF_E = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixCalciumE)

                if not calDF_E.empty:
                    calMetricsE = pandas.concat(
                        [calDF_E.mean(axis=1),
                         calDF_E.std(axis=1)],
                        axis=1)
                    xmax = calDF_E.values.max()
                    calMetricsEfile = (
                        self.cfg.filenamePrefixCalciumE + 'all.txt'
                    )
                    calMetricsE.to_csv(
                        calMetricsEfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for E neurons..")

                    eps_e = calMetricsE.loc[
                        self.cfg.rewiringEnabledAt * 1000.][0]
                    eta_a_e = 0.56 * eps_e
                    eta_d_e = 0.14 * eps_e
                    args = ("-e", "etad={}".format(eta_d_e),
                            "-e", "etaa={}".format(eta_a_e),
                            "-e", "epsilon={}".format(eps_e),
                            "-e", "outputfilename='growth-curves-E.png'",
                            "-e", "plottitle='Growth curves for E neurons'",
                            "-e", "xmax={}".format(xmax),
                            os.path.join(
                                self.cfg.postprocess_home,
                                self.cfg.gnuplot_files_dir,
                                'plot-growthcurves.plt'))
                    subprocess.call(['gnuplot'] + list(args))
                    print("Growth curves plotted..")
                else:
                    print("No cal metric df for E neurons. Skipping.")
            else:
                calDF_E = calDF_E.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixCalciumI]):
                calDF_I = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixCalciumI)

                if not calDF_I.empty:
                    calMetricsI = pandas.concat(
                        [calDF_I.mean(axis=1),
                         calDF_I.std(axis=1)],
                        axis=1)
                    xmax = calDF_I.values.max()
                    calMetricsIfile = (
                        self.cfg.filenamePrefixCalciumI + 'all.txt'
                    )
                    calMetricsI.to_csv(
                        calMetricsIfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for I neurons..")

                    eps_i = calMetricsI.loc[
                        self.cfg.rewiringEnabledAt * 1000.][0]
                    eta_a_i = 0.56 * eps_i
                    eta_d_i = 0.14 * eps_i
                    args = ("-e", "etad={}".format(eta_d_i),
                            "-e", "etaa={}".format(eta_a_i),
                            "-e", "epsilon={}".format(eps_i),
                            "-e", "outputfilename='growth-curves-I.png'",
                            "-e", "plottitle='Growth curves for I neurons'",
                            "-e", "xmax={}".format(xmax),
                            os.path.join(
                                self.cfg.postprocess_home,
                                self.cfg.gnuplot_files_dir,
                                'plot-growthcurves.plt'))
                    subprocess.call(['gnuplot'] + list(args))
                    print("Growth curves plotted..")
                else:
                    print("No cal metric df for I neurons. Skipping.")
            else:
                calDF_I = calDF_I.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixCalciumLPZE]):
                combiner = nestpp.combineFiles.CombineFiles()

                calDF_lpz_E = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixCalciumLPZE)

                if not calDF_lpz_E.empty:
                    calMetricsLPZE = pandas.concat(
                        [calDF_lpz_E.mean(axis=1),
                         calDF_lpz_E.std(axis=1)],
                        axis=1)
                    calMetricsLPZEfile = (
                        self.cfg.filenamePrefixCalciumLPZE + 'all.txt'
                    )
                    calMetricsLPZE.to_csv(
                        calMetricsLPZEfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for LPZE neurons..")
                else:
                    print("No cal metric df for LPZE neurons. Skipping.")
            else:
                calDF_lpz_E = calDF_lpz_E.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixCalciumLPZI]):
                calDF_lpz_I = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixCalciumLPZI)

                if not calDF_lpz_I.empty:
                    calMetricsLPZI = pandas.concat(
                        [calDF_lpz_I.mean(axis=1),
                         calDF_lpz_I.std(axis=1)],
                        axis=1)
                    calMetricsLPZIfile = (
                        self.cfg.filenamePrefixCalciumLPZI + 'all.txt'
                    )
                    calMetricsLPZI.to_csv(
                        calMetricsLPZIfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for LPZI neurons..")
                else:
                    print("No cal metric df for LPZI neurons. Skipping.")
            else:
                calDF_lpz_I = calDF_lpz_I.append([0])

            if (not calDF_lpz_E.empty) and (not calDF_lpz_I.empty) and \
                    (not calDF_E.empty) and (not calDF_I.empty):
                args = (os.path.join(
                    self.cfg.postprocess_home,
                    self.cfg.gnuplot_files_dir,
                        'plot-cal-metrics.plt'))
                subprocess.call(['gnuplot',
                                args])

            else:
                print("No calcium metric graphs generated.")

    def __postprocess_conductances(self):
        """Post process conductances, print means."""
        if self.cfg.conductancesMetrics:
            print("Processing conductances..")
            conductancesDF_EE = pandas.DataFrame()
            conductancesDF_EI = pandas.DataFrame()
            conductancesDF_IE = pandas.DataFrame()
            conductancesDF_II = pandas.DataFrame()
            import nestpp.combineFiles
            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixConductancesEE]):
                combiner = nestpp.combineFiles.CombineFiles()
                conductancesDF_EE = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixConductancesEE)
                if not conductancesDF_EE.empty:
                    conductanceMetricsEE = pandas.concat(
                        [conductancesDF_EE.mean(axis=1),
                         conductancesDF_EE.std(axis=1)],
                        axis=1)
                    conductancesMetricsEEfile = (
                        self.cfg.filenamePrefixConductancesEE +
                        'mean-all.txt'
                    )
                    conductanceMetricsEE.to_csv(
                        conductancesMetricsEEfile, sep='\t',
                        header=None, line_terminator='\n')

                    conductanceMetricsTotalsEE = conductancesDF_EE.sum(axis=1)
                    conductancesMetricsTotalsEEfile = (
                        self.cfg.filenamePrefixConductancesEE +
                        'total-all.txt'
                    )
                    conductanceMetricsTotalsEE.to_csv(
                        conductancesMetricsTotalsEEfile, sep='\t',
                        header=None)
                    print("Processed EE conductances..")
                else:
                    print("No dataframe for EE conductances. Skipping.")
            else:
                conductancesDF_EE = conductancesDF_EE.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixConductancesEI]):
                conductancesDF_EI = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixConductancesEI)
                if not conductancesDF_EI.empty:
                    conductanceMetricsEI = pandas.concat(
                        [conductancesDF_EI.mean(axis=1),
                         conductancesDF_EI.std(axis=1)],
                        axis=1)
                    conductancesMetricsEIfile = (
                        self.cfg.filenamePrefixConductancesEI +
                        'mean-all.txt'
                    )
                    conductanceMetricsEI.to_csv(
                        conductancesMetricsEIfile, sep='\t',
                        header=None, line_terminator='\n')

                    conductanceMetricsTotalsEI = conductancesDF_EI.sum(axis=1)
                    conductancesMetricsTotalsEIfile = (
                        self.cfg.filenamePrefixConductancesEI +
                        'total-all.txt'
                    )
                    conductanceMetricsTotalsEI.to_csv(
                        conductancesMetricsTotalsEIfile, sep='\t',
                        header=None)
                    print("Processed EI conductances..")
                else:
                    print("No dataframe for EI conductances. Skipping.")
            else:
                conductancesDF_EI = conductancesDF_EI.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixConductancesII]):
                conductancesDF_II = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixConductancesII)
                if not conductancesDF_II.empty:
                    conductanceMetricsII = pandas.concat(
                        [conductancesDF_II.mean(axis=1),
                         conductancesDF_II.std(axis=1)],
                        axis=1)
                    conductancesMetricsIIfile = (
                        self.cfg.filenamePrefixConductancesII +
                        'mean-all.txt'
                    )
                    conductanceMetricsII.to_csv(
                        conductancesMetricsIIfile, sep='\t',
                        header=None, line_terminator='\n')

                    conductanceMetricsTotalsII = conductancesDF_II.sum(axis=1)
                    conductancesMetricsTotalsIIfile = (
                        self.cfg.filenamePrefixConductancesII +
                        'total-all.txt'
                    )
                    conductanceMetricsTotalsII.to_csv(
                        conductancesMetricsTotalsIIfile, sep='\t',
                        header=None)
                    print("Processed II conductances..")
                else:
                    print("No dataframe for II conductances. Skipping.")
            else:
                conductancesDF_II = conductancesDF_II.append([0])

            if self.__reprocess_raw_files(
                    [self.cfg.filenamePrefixConductancesIE]):
                conductancesDF_IE = combiner.combineCSVRowLists(
                    self.cfg.unconsolidatedFilesDir,
                    self.cfg.filenamePrefixConductancesIE)
                if not conductancesDF_IE.empty:
                    conductanceMetricsIE = pandas.concat(
                        [conductancesDF_IE.mean(axis=1),
                         conductancesDF_IE.std(axis=1)],
                        axis=1)
                    conductancesMetricsIEfile = (
                        self.cfg.filenamePrefixConductancesIE +
                        'mean-all.txt'
                    )
                    conductanceMetricsIE.to_csv(
                        conductancesMetricsIEfile, sep='\t',
                        header=None, line_terminator='\n')

                    conductanceMetricsTotalsIE = conductancesDF_IE.sum(axis=1)
                    conductancesMetricsTotalsIEfile = (
                        self.cfg.filenamePrefixConductancesIE +
                        'total-all.txt'
                    )
                    conductanceMetricsTotalsIE.to_csv(
                        conductancesMetricsTotalsIEfile, sep='\t',
                        header=None)
                    print("Processed IE conductances..")
                else:
                    print("No dataframe for IE conductances. Skipping")
            else:
                conductancesDF_IE = conductancesDF_IE.append([0])

            if (
                    (not conductancesDF_EE.empty) and
                    (not conductancesDF_EI.empty) and
                    (not conductancesDF_IE.empty) and
                    (not conductancesDF_II.empty)
            ):
                args = (os.path.join(
                    self.cfg.postprocess_home,
                    self.cfg.gnuplot_files_dir,
                    'plot-conductance-metrics.plt'))
                subprocess.call(['gnuplot',
                                 args])
                print("Conductance graphs plotted..")
            else:
                print("Conductance graphs not generated.")

    def __load_neurons(self, file, cols=[0, 1, 2]):
        """Get a neuron list from a file."""
        neurons = []
        if os.path.exists(file):
            neurons = (numpy.loadtxt(file, delimiter='\t', usecols=cols))
            self.lgr.info("Read {} neurons from {}".format(
                len(neurons), file))
        else:
            self.lgr.error(
                "Unable to find {}. Neurons not loaded.".format(file))

        return neurons

    def __populate_neuron_lists(self):
        """Populate neuron lists."""
        # Excitatory neurons
        # nid   gridx   gridy   posx    posy
        self.neurons['E'] = self.__load_neurons("00-neuron-locations-E.txt",
                                                cols=[0, 3, 4])
        # nid   posx    posy
        self.neurons['lpz_c_E'] = self.__load_neurons(
            "00-lpz-centre-neuron-locations-E.txt")
        self.neurons['lpz_b_E'] = self.__load_neurons(
            "00-lpz-border-neuron-locations-E.txt")
        self.neurons['lpz_E'] = (self.neurons_lpz_b_E + self.neurons_lpz_c_E)
        self.neurons['peri_lpz_E'] = self.__load_neurons(
            "00-peri-lpz-neuron-locations-E.txt")

        # Inhibitory neurons
        # nid   gridx   gridy   posx    posy
        self.neurons['I'] = self.__load_neurons("00-neuron-locations-I.txt",
                                                cols=[0, 3, 4])
        # nid   posx    posy
        self.neurons['lpz_c_I'] = self.__load_neurons(
            "00-lpz-centre-neuron-locations-I.txt")
        self.neurons['lpz_b_I'] = self.__load_neurons(
            "00-lpz-border-neuron-locations-I.txt")
        self.neurons['lpz_I'] = (self.neurons_lpz_b_I + self.neurons_lpz_c_I)
        self.neurons['peri_lpz_I'] = self.__load_neurons(
            "00-peri-lpz-neuron-locations-I.txt")

        # Populate pattern lists and calculate the overlap percentage between
        # each pattern and the LPZ
        self.numpats = self.__get_numpats()
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

    def generate_firing_rate_graphs(self):
        """Generate firing rate graphs."""
        if "firing_rates" not in self.cfg.graph_list:
            return True

        self.lgr.info("Generating mean firing rate graphs vs time")

        if self.__reprocess_raw_files(["firing-", "std-", "cv-"]):
            for neuron_set in self.neurons.keys():
                get_firing_rate_metrics(
                    neuron_set, "spikes-{}.gdf".format(neuron_set),
                    len(self.neurons[neuron_set]))

            self.lgr.info("Generating firing rate graphs")
            plot_using_gnuplot_binary(
                os.path.join(self.cfg.plots_dir, 'plot-firing-rates-IE.plt')
            )

            if self.numpats > 0:
                self.lgr.info("Generating pattern graphs")
                plot_using_gnuplot_binary(
                    os.path.join(self.cfg.plots_dir,
                                 'plot-firing-rates-patterns.plt'),
                    ['-e', 'numpats={}'.format(self.numpats)]
                )

            self.lgr.info("Generating ISI cv graphs")
            plot_using_gnuplot_binary(
                os.path.join(self.cfg.plots_dir, 'plot-cvs.plt'))

            self.lgr.info("Generating STD of firing rates graphs")
            plot_using_gnuplot_binary(
                os.path.join(self.cfg.plots_dir, 'plot-std.plt'))

    def generate_histograms(self):
        """Generate histograms."""
        # firing rate histograms for E and I neurons
        histlist = ['E', 'I']
        self.lgr.info("Generating histograms for {}".format(histlist))
        if len(self.cfg.snapshots['histograms']) > 0:
            for neuron_set in histlist:
                get_individual_firing_rate_snapshots(
                    neuron_set, "spikes-{}.gdf".format(neuron_set),
                    len(self.neurons[neuron_set]),
                    self.cfg.snapshots['histograms'])

            for time in self.cfg.snapshots['histograms']:
                plot_histograms(histlist, time)

    def generate_firing_rate_grid_snapshots(self):
        """Generate top view firing rate snapshots."""
        fr_grid_list = ['E']
        self.lgr.info("Generating histograms for {}".format(fr_grid_list))
        if len(self.cfg.snapshots['firing_rates']) > 0:
            for neuron_set in fr_grid_list:
                get_individual_firing_rate_snapshots(
                    neuron_set, "spikes-{}.gdf".format(neuron_set),
                    len(self.neurons[neuron_set]),
                    self.cfg.snapshots['firing_rates'])

            for time in self.cfg.snapshots['firing_rates']:
                plot_histograms(fr_grid_list, time)

    def generate_raster_graphs(self):
        # rasters for E I only for the moment
        if len(self.cfg.snapshots['rasters']) > 0:
            for neuron_set in ['E', 'I']:
                extract_spikes(neuron_set, "spikes-{}.gdf".format(neuron_set),
                               self.cfg.snapshots['rasters'])

            for t in self.cfg.snapshots['raster']:
                neuron_dict = {
                    'E': [self.neurons['E'][0][0], self.neurons['E'][-1][0]],
                    'I': [self.neurons['I'][0][0], self.neurons['I'][-1][0]],
                }
                plot_rasters(neuron_dict, t, proportion=0.1)

    def plot_neuron_locations(self):
        """Plot graphs showing locations of neurons."""
        self.lgr.info("Generating locations of various neuron sets.")
        graph_dict = {}
        # LPZ E regions
        # LPZ neuron sets are [nid, xcor, ycor]
        for key, value in self.neurons.items():
            if "lpz" in key and "E" in key:
                graph_dict[key] = value
        plot_location_grid(graph_dict)

        # add patterns to that image
        # Patterns are also [nid, xcor, ycor]
        for key, value in self.neurons.items():
            if "pattern-" in key:
                graph_dict[key] = value
        plot_location_grid(graph_dict)

    def __postprocess_spikes(self):
        """Postprocess combined spike files."""

        if self.cfg.grid and len(self.cfg.gridplots_timelist) > 0:
            print("Generating grid rate snapshots")
            import nestpp.gridRatePlotter as grp
            import nestpp.getFiringRates as rg
            rateGetter = rg.getFiringRates()

            # sufficient - covers all neurons
            # no need to also do it for various other sets
            if rateGetter.setup(
                self.cfg.filenameE, 'E',
                self.cfg.neuronsE,
                self.cfg.rows_per_read
            ):
                rateGetter.run(self.cfg.gridplots_timelist)

            # Note, if rate files were also generated for histograms,
            # gridrateplotter will currently also plot them - the output file
            # pattern is the same
            gridrateplotterE = grp.gridRatePlotter(self.cfg)
            # could even pass in the neuron list directly, but it isn't worth
            # the trouble. A single file read wont hurt anyone. It makes the
            # script also usable in isolation.
            gridrateplotterE.setup('E', self.cfg.neuronListE)
            gridrateplotterE.run()

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

    def __postprocess_turnovers(self):
        """Process synaptic turnover graphs."""
        plotting_interval = 1000.
        if self.cfg.SETurnoverMetrics:
            formed_filename = os.path.join(
                self.cfg.unconsolidatedFilesDir +
                (self.cfg.filenameSETurnoverFormed + "0.txt"))
            deleted_filename = os.path.join(
                self.cfg.unconsolidatedFilesDir +
                (self.cfg.filenameSETurnoverDeleted + "0.txt"))
            formed_DF = pandas.read_csv(formed_filename, delimiter='\t',
                                        engine='c', skipinitialspace=True,
                                        lineterminator='\n', dtype=float)
            deleted_DF = pandas.read_csv(deleted_filename, delimiter='\t',
                                         engine='c', skipinitialspace=True,
                                         lineterminator='\n', dtype=float)
            with open(self.cfg.filenameSETurnoverFormed + "totals.txt",
                      'w') as fout, open(self.cfg.filenameSETurnoverFormed +
                                         "LPZ-totals.txt", 'w') as lpzfout:
                current_time = formed_DF.iloc[0][0]
                current_count = 0
                current_lpz_count = 0
                for row in formed_DF.itertuples():
                    if (
                            int(row[1]/plotting_interval) ==
                            int(current_time/plotting_interval)
                    ):
                        current_count += row[3]
                        if row[2] in self.neurons_lpz_E:
                            current_lpz_count += row[3]

                    if (
                            int(row[1]/plotting_interval) >
                            int(current_time/plotting_interval)
                    ):
                        print("{}\t{}".format(
                            int(current_time/plotting_interval),
                            current_count), file=fout)
                        print("{}\t{}".format(
                            int(current_time/plotting_interval),
                            current_lpz_count), file=lpzfout)
                        # Ready for the next iteration
                        current_count = row[3]
                        if row[2] in self.neurons_lpz_E:
                            current_lpz_count = row[3]
                        else:
                            current_lpz_count = 0
                        current_time = row[1]

            with open(self.cfg.filenameSETurnoverDeleted + "totals.txt",
                      'w') as fout, open(self.cfg.filenameSETurnoverDeleted
                                         + "LPZ-totals.txt", 'w') as lpzfout:
                current_time = deleted_DF.iloc[0][0]
                current_count = 0
                current_lpz_count = 0
                for row in deleted_DF.itertuples():
                    if (
                            int(row[1]/plotting_interval) ==
                            int(current_time/plotting_interval)
                    ):
                        current_count += row[4]
                        if row[2] in self.neurons_lpz_E:
                            current_lpz_count += row[4]

                    if (
                            int(row[1]/plotting_interval) >
                            int(current_time/plotting_interval)
                    ):
                        print("{}\t{}".format(
                            int(current_time/plotting_interval),
                            current_count), file=fout)
                        print("{}\t{}".format(
                            int(current_time/plotting_interval),
                            current_lpz_count), file=lpzfout)
                        # Ready for the next iteration
                        current_count = row[4]
                        if row[2] in self.neurons_lpz_E:
                            current_lpz_count = row[4]
                        else:
                            current_lpz_count = 0
                        current_time = row[1]

            args = ['gnuplot', os.path.join(
                    self.cfg.postprocess_home,
                    self.cfg.gnuplot_files_dir,
                    'plot-turnover.plt')]
            subprocess.call(args)

    def __reprocess_raw_files(self, prefixlist):
        """Ask if files should be reprocessed if found."""
        filelist = os.listdir()
        filesfound = []
        for entry in filelist:
            for prefix in prefixlist:
                if prefix in entry:
                    if ".png" not in entry:
                        filesfound.append(entry)

        if len(filesfound) == 0:
            return True

        filesfound.sort()
        if len(filesfound) > 0:
            print("Generated files found: {}".format(len(filesfound)))
            for entry in filesfound:
                print("- {}".format(entry))

            while True:
                regen = self.__input_with_timeout(
                    "Regenerate(Y/N/y/n defaults to Y in 15 seconds)? ", 15.0)
                if regen == "N" or regen == "n":
                    return False
                elif regen == "Y" or regen == "y":
                    return True

    def __input_with_timeout(self, prompt, timeout=30.0):
        """Input but with timeout."""
        astring = 'Y'
        print(prompt, end='', flush=True)
        rlist, _, _ = select([sys.stdin], [], [], timeout)
        if rlist:
            astring = sys.stdin.readline()[0]
        else:
            print("Timed out.. Proceeding..")
        return astring

    def __get_numpats(self):
        """Get number of patterns from list of files in directory."""
        filelist = os.listdir()
        i = 0
        for entry in filelist:
            if entry.startswith('00-pattern-neurons-'):
                i = i+1

        self.lgr.info("Got {} patterns".format(i))
        return i

    def main(self):
        """Do everything."""
        self.__load_config()
        self.__populate_neuron_lists()

        self.plot_neuron_locations()

        self.generate_firing_rate_graphs()
        self.generate_histograms()

        self.__postprocess_synaptic_elements_all()
        self.__postprocess_synaptic_elements_individual()
        self.__postprocess_conductances()
        self.__postprocess_calcium()
        self.__postprocess_turnovers()


if __name__ == "__main__":
    runner = Postprocess()
    runner.main()
