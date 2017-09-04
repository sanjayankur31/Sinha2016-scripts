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

from config import Config
import sys
import os
import pandas
import numpy
import subprocess
from select import select


class Postprocess:

    """Main post process worker class."""

    def __init__(self):
        """Initialise."""
        self.configfile = "config.ini"

    def __load_config(self):
        """Load configuration file."""
        if os.path.isfile(self.configfile):
            self.config = Config(self.configfile)
            self.config.generateOutputFileNames()
            print("Config file {} loaded successfully.".format(
                self.configfile))
        else:
            sys.exit("Could not find config file: {}. Exiting.".format(
                self.configfile))

    def __postprocess_synaptic_elements_individual(self):
        """Post process synaptic elements from individual neuronal files."""
        if self.config.SEIndividualMetrics:
            print("Processing synaptic elements for individual neurons..")
            import nestpp.combineFiles
            combiner = nestpp.combineFiles.CombineFiles()

            # E neurons
            timeddfDict = combiner.combineTimedTSVColDataFiles(
                self.config.unconsolidatedFilesDir,
                self.config.filenamePrefixSEIndividualE)

            if timeddfDict:
                for time, df in timeddfDict.items():
                    syn_elms_ind_DF_filename = (
                        self.config.filenamePrefixSEIndividualE +
                        str(time) + ".txt")
                    df.to_csv(
                        syn_elms_ind_DF_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for E neurons" +
                          " at time {}..".format(time))

                    args = ['gnuplot',
                            '-e',
                            "plotname='{}'".format(
                                self.config.filenamePrefixSEIndividualE +
                                str(time) + ".png"),
                            '-e',
                            'plottitle={}'.format(
                                "'Synaptic elements at time {}'".format(
                                    str(time))),
                            '-e',
                            "inputfile='{}'".format(
                                syn_elms_ind_DF_filename),
                            os.path.join(
                                self.config.postprocessHome,
                                self.config.gnuplotFilesDir,
                                'plot-ind-synaptic-elements-metrics.plt')]
                    subprocess.call(args)
                    print("E neuron synaptic elements graph" +
                          " at time {} generated.".format(time))
            else:
                print("No dataframes for E synaptic elements. Skipping.")

            # I neurons
            timeddfDict = combiner.combineTimedTSVColDataFiles(
                self.config.unconsolidatedFilesDir,
                self.config.filenamePrefixSEIndividualI)

            if timeddfDict:
                for time, df in timeddfDict.items():
                    syn_elms_ind_DF_filename = (
                        self.config.filenamePrefixSEIndividualI +
                        str(time) + ".txt")
                    df.to_csv(
                        syn_elms_ind_DF_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for I neurons" +
                          " at time {}..".format(time))

                    args = ['gnuplot',
                            '-e',
                            "plotname='{}'".format(
                                self.config.filenamePrefixSEIndividualI +
                                str(time) + ".png"),
                            '-e',
                            'plottitle={}'.format(
                                "'Synaptic elements at time {}'".format(
                                    str(time))),
                            '-e',
                            "inputfile='{}'".format(
                                syn_elms_ind_DF_filename),
                            os.path.join(
                                self.config.postprocessHome,
                                self.config.gnuplotFilesDir,
                                'plot-ind-synaptic-elements-metrics.plt')]
                    subprocess.call(args)
                    print("I neuron synaptic elements graph" +
                          " at time {} generated.".format(time))
            else:
                print("No dataframes for I synaptic elements. Skipping.")

    def __postprocess_synaptic_elements_all(self):
        """Post total synaptic element files."""
        if self.config.SETotalsMetrics:
            print("Processing synaptic element information..")
            import nestpp.combineFiles
            combiner = nestpp.combineFiles.CombineFiles()

            syn_elms_DF_E = pandas.DataFrame()
            syn_elms_DF_I = pandas.DataFrame()
            syn_elms_DF_LPZ_E = pandas.DataFrame()
            syn_elms_DF_LPZ_I = pandas.DataFrame()
            if self.__reprocess_raw_files([self.config.filenamePrefixSETotalsE]):
                syn_elms_DF_E = combiner.combineTSVRowData(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixSETotalsE)

                if not syn_elms_DF_E.empty:
                    syn_elms_E_filename = (
                        self.config.filenamePrefixSETotalsE + 'all.txt'
                    )
                    syn_elms_DF_E.to_csv(
                        syn_elms_E_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for E neurons..")
                else:
                    print("No dataframe for all E syn elements. Skipping.")
            else:
                syn_elms_DF_E = syn_elms_DF_E.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixSETotalsLPZE]):
                syn_elms_DF_LPZ_E = combiner.combineTSVRowData(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixSETotalsLPZE)

                if not syn_elms_DF_LPZ_E.empty:
                    syn_elms_E_filename = (
                        self.config.filenamePrefixSETotalsLPZE + 'all.txt'
                    )
                    syn_elms_DF_LPZ_E.to_csv(
                        syn_elms_E_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for LPZ E neurons..")
                else:
                    print("No dataframe for all E syn elements. Skipping.")
            else:
                syn_elms_DF_LPZ_E = syn_elms_DF_LPZ_E.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixSETotalsI]):
                syn_elms_DF_I = combiner.combineTSVRowData(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixSETotalsI)

                if not syn_elms_DF_I.empty:
                    syn_elms_I_filename = (
                        self.config.filenamePrefixSETotalsI + 'all.txt'
                    )
                    syn_elms_DF_I.to_csv(
                        syn_elms_I_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for I neurons..")
            else:
                syn_elms_DF_I = syn_elms_DF_I.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixSETotalsLPZI]):
                syn_elms_DF_LPZ_I = combiner.combineTSVRowData(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixSETotalsLPZI)

                if not syn_elms_DF_LPZ_I.empty:
                    syn_elms_I_filename = (
                        self.config.filenamePrefixSETotalsLPZI + 'all.txt'
                    )
                    syn_elms_DF_LPZ_I.to_csv(
                        syn_elms_I_filename, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed synaptic elements for LPZ I neurons..")
            else:
                syn_elms_DF_LPZ_I = syn_elms_DF_LPZ_I.append([0])

            args = (os.path.join(
                self.config.postprocessHome,
                self.config.gnuplotFilesDir,
                    'plot-synaptic-elements-metrics.plt'))
            subprocess.call(['gnuplot',
                            args])

            args = (os.path.join(
                self.config.postprocessHome,
                self.config.gnuplotFilesDir,
                    'plot-lpz-synaptic-elements-metrics.plt'))
            subprocess.call(['gnuplot',
                            args])
            print("Synaptic elements graphs generated..")

    def __postprocess_calcium(self):
        """Postprocess calcium files."""
        if self.config.calciumMetrics:
            import nestpp.combineFiles
            calDF_E = pandas.DataFrame()
            calDF_I = pandas.DataFrame()
            calDF_LPZE = pandas.DataFrame()
            calDF_LPZI = pandas.DataFrame()
            print("Processing calcium concentration information..")
            if self.__reprocess_raw_files([self.config.filenamePrefixCalciumE]):
                combiner = nestpp.combineFiles.CombineFiles()

                calDF_E = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixCalciumE)

                if not calDF_E.empty:
                    calMetricsE = pandas.concat(
                        [calDF_E.mean(axis=1),
                         calDF_E.std(axis=1)],
                        axis=1)
                    xmax = calDF_E.values.max()
                    calMetricsEfile = (
                        self.config.filenamePrefixCalciumE + 'all.txt'
                    )
                    calMetricsE.to_csv(
                        calMetricsEfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for E neurons..")

                    eps_e = calMetricsE.loc[self.config.rewiringEnabledAt * 1000.][0]
                    eta_a_e = 0.56 * eps_e
                    eta_d_e = 0.14 * eps_e
                    args = ("-e", "etad={}".format(eta_d_e),
                            "-e", "etaa={}".format(eta_a_e),
                            "-e", "epsilon={}".format(eps_e),
                            "-e", "outputfilename='growth-curves-E.png'",
                            "-e", "plottitle='Growth curves for E neurons'",
                            "-e", "xmax={}".format(xmax),
                            os.path.join(
                                self.config.postprocessHome,
                                self.config.gnuplotFilesDir,
                                'plot-growthcurves.plt'))
                    subprocess.call(['gnuplot'] + list(args))
                    print("Growth curves plotted..")
                else:
                    print("No cal metric df for E neurons. Skipping.")
            else:
                calDF_E = calDF_E.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixCalciumI]):
                calDF_I = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixCalciumI)

                if not calDF_I.empty:
                    calMetricsI = pandas.concat(
                        [calDF_I.mean(axis=1),
                         calDF_I.std(axis=1)],
                        axis=1)
                    xmax = calDF_I.values.max()
                    calMetricsIfile = (
                        self.config.filenamePrefixCalciumI + 'all.txt'
                    )
                    calMetricsI.to_csv(
                        calMetricsIfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for I neurons..")

                    eps_i = calMetricsI.loc[self.config.rewiringEnabledAt * 1000.][0]
                    eta_a_i = 0.56 * eps_i
                    eta_d_i = 0.14 * eps_i
                    args = ("-e", "etad={}".format(eta_d_i),
                            "-e", "etaa={}".format(eta_a_i),
                            "-e", "epsilon={}".format(eps_i),
                            "-e", "outputfilename='growth-curves-I.png'",
                            "-e", "plottitle='Growth curves for I neurons'",
                            "-e", "xmax={}".format(xmax),
                            os.path.join(
                                self.config.postprocessHome,
                                self.config.gnuplotFilesDir,
                                'plot-growthcurves.plt'))
                    subprocess.call(['gnuplot'] + list(args))
                    print("Growth curves plotted..")
                else:
                    print("No cal metric df for I neurons. Skipping.")
            else:
                calDF_I = calDF_I.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixCalciumLPZE]):
                combiner = nestpp.combineFiles.CombineFiles()

                calDF_LPZE = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixCalciumLPZE)

                if not calDF_LPZE.empty:
                    calMetricsLPZE = pandas.concat(
                        [calDF_LPZE.mean(axis=1),
                         calDF_LPZE.std(axis=1)],
                        axis=1)
                    calMetricsLPZEfile = (
                        self.config.filenamePrefixCalciumLPZE + 'all.txt'
                    )
                    calMetricsLPZE.to_csv(
                        calMetricsLPZEfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for LPZE neurons..")
                else:
                    print("No cal metric df for LPZE neurons. Skipping.")
            else:
                calDF_LPZE = calDF_LPZE.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixCalciumLPZI]):
                calDF_LPZI = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixCalciumLPZI)

                if not calDF_LPZI.empty:
                    calMetricsLPZI = pandas.concat(
                        [calDF_LPZI.mean(axis=1),
                         calDF_LPZI.std(axis=1)],
                        axis=1)
                    calMetricsLPZIfile = (
                        self.config.filenamePrefixCalciumLPZI + 'all.txt'
                    )
                    calMetricsLPZI.to_csv(
                        calMetricsLPZIfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed cal metrics for LPZI neurons..")
                else:
                    print("No cal metric df for LPZI neurons. Skipping.")
            else:
                calDF_LPZI = calDF_LPZI.append([0])

            if (not calDF_LPZE.empty) and (not calDF_LPZI.empty) and \
                    (not calDF_E.empty) and (not calDF_I.empty):
                args = (os.path.join(
                    self.config.postprocessHome,
                    self.config.gnuplotFilesDir,
                        'plot-cal-metrics.plt'))
                subprocess.call(['gnuplot',
                                args])

            else:
                print("No calcium metric graphs generated.")

    def __postprocess_conductances(self):
        """Post process conductances, print means."""
        if self.config.conductancesMetrics:
            print("Processing conductances..")
            conductancesDF_EE = pandas.DataFrame()
            conductancesDF_EI = pandas.DataFrame()
            conductancesDF_IE = pandas.DataFrame()
            conductancesDF_II = pandas.DataFrame()
            import nestpp.combineFiles
            if self.__reprocess_raw_files([self.config.filenamePrefixConductancesEE]):
                combiner = nestpp.combineFiles.CombineFiles()
                conductancesDF_EE = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixConductancesEE)
                if not conductancesDF_EE.empty:
                    conductanceMetricsEE = pandas.concat(
                        [conductancesDF_EE.mean(axis=1),
                         conductancesDF_EE.std(axis=1)],
                        axis=1)
                    conductancesMetricsEEfile = (
                        self.config.filenamePrefixConductancesEE + 'all.txt'
                    )
                    conductanceMetricsEE.to_csv(
                        conductancesMetricsEEfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed EE conductances..")
                else:
                    print("No dataframe for EE conductances. Skipping.")
            else:
                conductancesDF_EE = conductancesDF_EE.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixConductancesEI]):
                conductancesDF_EI = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixConductancesEI)
                if not conductancesDF_EI.empty:
                    conductanceMetricsEI = pandas.concat(
                        [conductancesDF_EI.mean(axis=1),
                         conductancesDF_EI.std(axis=1)],
                        axis=1)
                    conductancesMetricsEIfile = (
                        self.config.filenamePrefixConductancesEI + 'all.txt'
                    )
                    conductanceMetricsEI.to_csv(
                        conductancesMetricsEIfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed EI conductances..")
                else:
                    print("No dataframe for EI conductances. Skipping.")
            else:
                conductancesDF_EI = conductancesDF_EI.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixConductancesII]):
                conductancesDF_II = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixConductancesII)
                if not conductancesDF_II.empty:
                    conductanceMetricsII = pandas.concat(
                        [conductancesDF_II.mean(axis=1),
                         conductancesDF_II.std(axis=1)],
                        axis=1)
                    conductancesMetricsIIfile = (
                        self.config.filenamePrefixConductancesII + 'all.txt'
                    )
                    conductanceMetricsII.to_csv(
                        conductancesMetricsIIfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed II conductances..")
                else:
                    print("No dataframe for II conductances. Skipping.")
            else:
                conductancesDF_II = conductancesDF_II.append([0])

            if self.__reprocess_raw_files([self.config.filenamePrefixConductancesIE]):
                conductancesDF_IE = combiner.combineCSVRowLists(
                    self.config.unconsolidatedFilesDir,
                    self.config.filenamePrefixConductancesIE)
                if not conductancesDF_IE.empty:
                    conductanceMetricsIE = pandas.concat(
                        [conductancesDF_IE.mean(axis=1),
                         conductancesDF_IE.std(axis=1)],
                        axis=1)
                    conductancesMetricsIEfile = (
                        self.config.filenamePrefixConductancesIE + 'all.txt'
                    )
                    conductanceMetricsIE.to_csv(
                        conductancesMetricsIEfile, sep='\t',
                        header=None, line_terminator='\n')
                    print("Processed IE conductances..")
                else:
                    print("No dataframe for IE conductances. Skipping")
            else:
                conductancesDF_IE = conductancesDF_IE.append([0])

            if ((not conductancesDF_EE.empty) and
                (not conductancesDF_EI.empty) and
                (not conductancesDF_IE.empty) and
                (not conductancesDF_II.empty)):
                args = (os.path.join(
                    self.config.postprocessHome,
                    self.config.gnuplotFilesDir,
                    'plot-conductance-metrics.plt'))
                subprocess.call(['gnuplot',
                                 args])
                print("Conductance graphs plotted..")
            else:
                print("Conductance graphs not generated.")

    def __postprocess_spikes(self):
        """Postprocess combined spike files."""
        self.config.neuronsE = len(numpy.loadtxt(self.config.neuronListE,
                                                 delimiter='\t', usecols=0))

        neuronsLPZE = (numpy.loadtxt(self.config.neuronListLPZE,
                                     delimiter='\t', usecols=0))
        self.config.neuronsLPZE = len(neuronsLPZE)

        self.config.neuronsI = len(numpy.loadtxt(self.config.neuronListI,
                                                 delimiter='\t', usecols=0))
        self.config.neuronsLPZI = len(numpy.loadtxt(self.config.neuronListLPZI,
                                                    delimiter='\t', usecols=0))
        self.config.numpats = self.__get_numpats()

        with open("00-pattern-overlap.txt", 'w') as f:
            for i in range(1, self.config.numpats + 1):
                neuronsP = (numpy.loadtxt(
                    self.config.neuronListPrefixP + str(i) + ".txt",
                    delimiter='\t', usecols=0))
                numP = len(neuronsP)
                neuronsB = (numpy.loadtxt(
                    self.config.neuronListPrefixB + str(i) + ".txt",
                    delimiter='\t', usecols=0))
                numB = len(neuronsB)

                self.config.neuronsP.append(numP)
                self.config.neuronsB.append(numB)

                neuronsOverlap = set(neuronsLPZE).intersection(set(neuronsP))
                overlapp_percent = len(neuronsOverlap)/len(neuronsP)
                print("{}\t{}".format(i, overlapp_percent), file=f)

        print("Got {} numpats".format(self.config.numpats))
        if self.config.timegraphs:
            print("Generating timegraph..")
            import nestpp.timeGraphPlotter as TGP
            tgp = TGP.timeGraphPlotter(self.config)
            if self.__reprocess_raw_files(["firing-", "std-", "cv-"]):
                tgp.get_firing_rates_from_spikes()
            tgp.plot_all()

        if self.config.histograms:
            print("Generating histograms..")
            import nestpp.dualHistogramPlotter as pltH
            import nestpp.getFiringRates as rg
            rateGetterE = rg.getFiringRates()
            if rateGetterE.setup(self.config.filenameE, 'E',
                                 self.config.neuronsE,
                                 self.config.rows_per_read):
                rateGetterE.run(self.config.histogram_timelist)

            rateGetterI = rg.getFiringRates()
            if rateGetterI.setup(self.config.filenameI, 'I',
                                 self.config.neuronsI,
                                 self.config.rows_per_read):
                rateGetterI.run(self.config.histogram_timelist)

            plotterEI = pltH.dualHistogramPlotter()
            if plotterEI.setup('E', 'I', self.config.neuronsE,
                               self.config.neuronsI):
                plotterEI.run()

        if self.config.rasters:
            import nestpp.rasterPlotter as pltR
            rasterPlotter = pltR.rasterPlotter()
            optiondict = [
                {
                    'neuronSet': 'E',
                    'neuronsFileName': self.config.neuronListE,
                    'spikesFileName': self.config.filenameE
                },
                {
                    'neuronSet': 'I',
                    'neuronsFileName': self.config.neuronListI,
                    'spikesFileName': self.config.filenameI
                },
            ]
            if rasterPlotter.setup(optiondict):
                print("Doing the work.")
                rasterPlotter.run(self.config.histogram_timelist)

            optiondict = [
                {
                    'neuronSet': 'LPZE',
                    'neuronsFileName': self.config.neuronListLPZE,
                    'spikesFileName': self.config.filenameLPZE
                },
            ]
            if rasterPlotter.setup(optiondict):
                print("Doing the work.")
                rasterPlotter.run(self.config.histogram_timelist)

        if self.config.grid:
            print("Generating grids..")
            import nestpp.gridPlotter as gp

            gridplotter = gp.gridPlotter()
            gridplotter.setup(self.config)
            gridplotter.read_files()
            gridplotter.plot_E_graph()
            gridplotter.plot_I_graph()
            gridplotter.plot_EI_graph()
            gridplotter.plot_single_pattern_graphs()
            gridplotter.plot_all_pattern_graph()

        if self.config.grid and len(self.config.gridplots_timelist) > 0:
            print("Generating grid rate snapshots")
            import nestpp.gridRatePlotter as grp
            import nestpp.getFiringRates as rg
            rateGetter = rg.getFiringRates()

            # sufficient - covers all neurons
            # no need to also do it for various other sets
            if rateGetter.setup(
                self.config.filenameE, 'E',
                self.config.neuronsE,
                self.config.rows_per_read
            ):
                rateGetter.run(self.config.gridplots_timelist)

            # Note, if rate files were also generated for histograms,
            # gridrateplotter will currently also plot them - the output file
            # pattern is the same
            gridrateplotterE = grp.gridRatePlotter(self.config)
            # could even pass in the neuron list directly, but it isn't worth
            # the trouble. A single file read wont hurt anyone. It makes the
            # script also usable in isolation.
            gridrateplotterE.setup('E', self.config.neuronListE)
            gridrateplotterE.run()

        if self.config.snr:
            import nestpp.getFiringRates as rg
            import nestpp.calculateSNR as snr
            snrCalculator = snr.calculateSNR()
            patFilesB = []
            patFilesP = []

            for i in range(1, self.config.numpats + 1):
                # use firing rate getter and do stuff
                rateGetterB = rg.getFiringRates()
                if rateGetterB.setup(
                    self.config.filenamePrefixB + str(i) + ".gdf",
                    'B-{}'.format(i),
                    self.config.neuronsB[i-1],
                    self.config.rows_per_read
                ):
                    patFilesB = rateGetterB.run(self.config.snr_timelist)

                rateGetterP = rg.getFiringRates()
                if rateGetterP.setup(
                    self.config.filenamePrefixP + str(i) + ".gdf",
                    'P-{}'.format(i),
                    self.config.neuronsP[i-1],
                    self.config.rows_per_read
                ):
                    patFilesP = rateGetterP.run(self.config.snr_timelist)
                    print("patfilesP is: {} ".format(patFilesP))

                with open("00-SNR-pattern-{}.txt".format(str(i)), 'w') as f:
                    for j in range(0, len(self.config.snr_timelist)):
                        snr = snrCalculator.run(patFilesP[j], patFilesB[j])
                        print("{}\t{}".format(self.config.snr_timelist[j], snr),
                              file=f)

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
        return i

    def main(self):
        """Do everything."""
        self.__load_config()
        self.__postprocess_synaptic_elements_all()
        self.__postprocess_synaptic_elements_individual()
        self.__postprocess_conductances()
        self.__postprocess_calcium()
        self.__postprocess_spikes()

if __name__ == "__main__":
    runner = Postprocess()
    runner.main()
