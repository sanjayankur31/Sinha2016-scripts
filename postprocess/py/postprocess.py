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

# module imports
from nestpp.utils import (get_config)
from nestpp.plotting_utils import (plot_using_gnuplot_binary, plot_histograms,
                                   plot_location_grid, plot_rasters)
from nestpp.loggerpp import get_module_logger
from nestpp.spike_utils import (get_firing_rate_metrics,
                                get_individual_firing_rate_snapshots,
                                extract_spikes)
from nestpp.file_utils import (reprocess_raw_files,
                               var_combine_files_column_wise,
                               get_info_from_file_series,
                               combine_files_row_wise)


class Postprocess:

    """Main post process worker class."""

    def __init__(self, configfile):
        """Initialise."""
        self.cfg = get_config(configfile)
        self.lgr = get_module_logger(__name__)
        self.neurons = {}
        self.__populate_neuron_lists()

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
        """Populate neuron lists.

        Load all the information once so that other functions do not need to
        read files again and again.
        """
        # Excitatory neurons
        self.neurons['E'] = self.__load_neurons("00-neuron-locations-E.txt",
                                                cols=[0, 1, 2, 3, 4])
        # nid   posx    posy
        self.neurons['lpz_c_E'] = self.__load_neurons(
            "00-lpz-centre-neuron-locations-E.txt")
        self.neurons['lpz_b_E'] = self.__load_neurons(
            "00-lpz-border-neuron-locations-E.txt")
        self.neurons['lpz_E'] = (self.neurons_lpz_b_E + self.neurons_lpz_c_E)
        self.neurons['peri_lpz_E'] = self.__load_neurons(
            "00-peri-lpz-neuron-locations-E.txt")

        # Inhibitory neurons
        self.neurons['I'] = self.__load_neurons("00-neuron-locations-I.txt",
                                                cols=[0, 1, 2, 3, 4])
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

    def generate_synaptic_element_graphs(self):
        """Post process synaptic elements from individual neuronal files."""
        if "syn_elms" not in self.cfg.graph_list:
            return True

        self.lgr.info("Processing synaptic elements..")
        time_list = get_info_from_file_series("..", "05-se-lpz_b_E-0-",
                                              ".txt")
        for neuron_set in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "lpz_c_I",
                           "lpz_b_I", "p_lpz_I"]:
            neuron_set_o_fn = "05-se-{}-all.txt".format(neuron_set)
            if reprocess_raw_files(".", ["05-se-{}-*.txt".format(
                    neuron_set)]):
                with open(neuron_set_o_fn, 'w') as f:
                    for atime in time_list:
                        ses = pandas.DataFrame()
                        ses = combine_files_row_wise(
                            "..", "05-se-{}-*-{}.txt".format(
                                neuron_set, atime), '\t')

                        print("{}\t{}\t{}".format(
                            atime, ses.mean(axis=1),
                            ses.std(axis=1)), file=f)

            self.lgr.info(
                "Processed syn elms metrics for {} neurons..".format(
                    neuron_set))

        plot_using_gnuplot_binary(os.path.join(self.cfg.plots_dir,
                                               'plot-cal-metrics.plt'))

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
        if "calciums" not in self.cfg.graph_list:
            return True

        self.lgr.info("Generating calcium graphs..")
        # get times where the info was logged since these need to be combined
        # first - from any file series for one rank
        time_list = get_info_from_file_series("..", "02-calcium-lpz_b_E-0-",
                                              ".txt")

        for neuron_set in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "lpz_c_I",
                           "lpz_b_I", "p_lpz_I"]:
            neuron_set_o_fn = "02-calcium-{}-all.txt".format(neuron_set)
            eps = 0.
            xmax = 0.
            if reprocess_raw_files(".", ["02-calcium-{}-*.txt".format(
                    neuron_set)]):
                with open(neuron_set_o_fn, 'w') as f:
                    for atime in time_list:
                        cals = pandas.DataFrame()
                        cals = combine_files_row_wise(
                            "..", "02-calcium-{}-*-{}.txt".format(
                                neuron_set, atime), '\t')

                        print("{}\t{}\t{}".format(
                            atime, cals.mean(axis=1),
                            cals.std(axis=1)), file=f)

                        # growth curves
                        if xmax < cals.mean(axis=1):
                            xmax = cals.mean(axis=1)
                        if atime == str(self.cfg.sp_enabled_at * 1000.):
                            eps = cals.mean(axis=1)
                            eta_a = 0.56 * eps
                            eta_d = 0.14 * eps
                            args = (
                                "-e", "etad={}".format(eta_d),
                                "-e", "etaa={}".format(eta_a),
                                "-e", "epsilon={}".format(eps),
                                "-e",
                                "o_fn='growth-curves-{}.png'".format(
                                    neuron_set),
                                "-e",
                                "plot_title='Growth curves for {}'".format(
                                    neuron_set),
                                "-e", "xmax={}".format(xmax),
                            )
                            plot_using_gnuplot_binary(
                                os.path.join(self.cfg.plots_dir,
                                             'plot-growthcurves.plt'),
                                args)

            self.lgr.info(
                "Processed cal metrics for {} neurons..".format(neuron_set))

        plot_using_gnuplot_binary(os.path.join(self.cfg.plots_dir,
                                               'plot-cal-metrics.plt'))

    def generate_conductance_graphs(self):
        """Post process conductances and generate all graphs.

        The conductance sets do not change, so this doesn't require so much
        configuration.

        :returns: True if all went well, else False

        """
        if "conductances" not in self.cfg.graph_list:
            return True

        self.lgr.info("Generating conductance graphs vs time")
        # EE
        conductances_EE = pandas.DataFrame()
        if reprocess_raw_files(".", ["01-synaptic-weights-EE-*"]):
            conductances_EE = var_combine_files_column_wise(
                "../", "01-synaptic-weights-EE-*.txt", ',')
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
        # If I decide to skip the processing, still permit plotting
        else:
            conductances_EE = conductances_EE.append([0])
        # EI
        conductances_EI = pandas.DataFrame()
        if reprocess_raw_files(".", ["01-synaptic-weights-EI-*"]):
            conductances_EI = var_combine_files_column_wise(
                "../", "01-synaptic-weights-EI-*.txt", ',')
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
        # If I decide to skip the processing, still permit plotting
        else:
            conductances_EI = conductances_EI.append([0])
        # II
        conductances_II = pandas.DataFrame()
        if reprocess_raw_files(".", ["01-synaptic-weights-II-*"]):
            conductances_II = var_combine_files_column_wise(
                "../", "01-synaptic-weights-II-*.txt", ',')
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
        # If I decide to skip the processing, still permit plotting
        else:
            conductances_II = conductances_II.append([0])
        # IE
        conductances_IE = pandas.DataFrame()
        if reprocess_raw_files(".", ["01-synaptic-weights-IE-*"]):
            conductances_IE = var_combine_files_column_wise(
                "../", "01-synaptic-weights-IE-*.txt", ',')
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
        # If I decide to skip the processing, still permit plotting
        else:
            conductances_IE = conductances_IE.append([0])

        if (
                (not conductances_EE.empty) and
                (not conductances_EI.empty) and
                (not conductances_IE.empty) and
                (not conductances_II.empty)
        ):
            plot_using_gnuplot_binary(
                os.path.join(self.cfg.plots_dir,
                             'plot-conductance-metrics.plt'))
            self.lgr.info("Conductance graphs plotted..")
        else:
            self.lgr.warning("Conductance graphs not generated.")

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
                    self.neurons[neuron_set],
                    self.cfg.snapshots['histograms'])

            for time in self.cfg.snapshots['histograms']:
                plot_histograms(histlist, time)

    def generate_firing_rate_grid_snapshots(self):
        """Generate top view firing rate snapshots."""
        if len(self.cfg.snapshots['firing_rates']) > 0:
            fr_grid_list = ['E', 'I']
            self.lgr.info(
                "Generating firing rate grid snapshots for {}".format(
                    fr_grid_list))
            for neuron_set in fr_grid_list:
                get_individual_firing_rate_snapshots(
                    neuron_set, "spikes-{}.gdf".format(neuron_set),
                    self.neurons[neuron_set],
                    self.cfg.snapshots['firing_rates'])

                for time in self.cfg.snapshots['firing_rates']:
                    i_fn = "firing-rates-{}-{}.gdf".format(neuron_set, time)
                    o_fn = "firing-rate-grid-plot-{}-{}.png".format(neuron_set,
                                                                    time)
                    args = ['-e', "o_fn='{}'".format(o_fn),
                            '-e', "neuron_set='{}'".format(neuron_set),
                            '-e', "plot_time='{}'".format(time),
                            '-e', "i_fn='{}'".format(i_fn),
                            ]
                    plot_using_gnuplot_binary(
                        os.path.join(self.cfg.plots_dir,
                                     'plot-firing-rates-IE.plt'),
                        args)

    def generate_raster_graphs(self):
        """Plot raster graphs for E and I neurons."""
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

    def plot_snrs(self):
        """Postprocess combined spike files.

        TODO: INCOMPLETE
        """
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
        if "syn_turnover" not in self.cfg.graph_list:
            return True

        for neuron_set in ["lpz_c_E", "lpz_b_E", "p_lpz_E", "lpz_c_I",
                           "lpz_b_I", "p_lpz_I"]:
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
            os.path.join(self.cfg.plots_dir, 'plot-total-synapse-changes.plt'))

    def main(self):
        """Do everything."""

        self.plot_neuron_locations()

        self.generate_firing_rate_graphs()
        self.generate_histograms()
        self.generate_raster_graphs()
        self.generate_firing_rate_grid_snapshots()
        self.generate_conductance_graphs()
        self.generate_calcium_graphs()
        self.generate_total_synapse_change_graphs()
        self.generate_synaptic_element_graphs()

        #  self.plot_snrs()


if __name__ == "__main__":
    runner = Postprocess()
    runner.main()
