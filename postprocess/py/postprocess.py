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
import subprocess


class Postprocess:

    """Main post process worker class."""

    def __init__(self):
        """Initialise."""
        self.configfile = "config.ini"

    def __load_config(self):
        """Load configuration file."""
        if os.path.isfile(self.configfile):
            self.config = Config(self.configfile)
            print("Config file {} loaded successfully.".format(
                self.configfile))
        else:
            sys.exit("Could not find config file: {}. Exiting.".format(
                self.configfile))

    def __postprocess_synaptic_elements_individual(self):
        """Post process synaptic elements from individual neuronal files."""
        if self.config.SETotalsMetrics:
            print("Processing synaptic elements for individual neurons..")
            import nest.combineFiles
            combiner = nest.combineFiles.CombineFiles()

            # E neurons
            timeddfDict = combiner.combineTimedTSVColDataFiles(
                self.config.unconsolidatedFilesDir,
                self.config.filenamePrefixSEIndividualE)

            if not timeddfDict.empty:
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

            if not timeddfDict.empty:
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
                print("No dataframes for E synaptic elements. Skipping.")

    def __postprocess_synaptic_elements_all(self):
        """Post total synaptic element files."""
        if self.config.SETotalsMetrics:
            print("Processing synaptic element information..")
            import nest.combineFiles
            combiner = nest.combineFiles.CombineFiles()

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
                print("No dataframe for all E synaptic elements. Skipping.")

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

                args = (os.path.join(
                    self.config.postprocessHome,
                    self.config.gnuplotFilesDir,
                        'plot-synaptic-elements-metrics.plt'))
                subprocess.call(['gnuplot',
                                args])
                print("Synaptic elements graphs generated..")
            else:
                print("No datafame for all I synaptic elements. Skipping.")

    def __postprocess_calcium(self):
        """Postprocess calcium files."""
        if self.config.calciumMetrics:
            print("Processing calcium concentration information..")
            import nest.combineFiles
            combiner = nest.combineFiles.CombineFiles()

            calDF_E = combiner.combineCSVRowLists(
                self.config.unconsolidatedFilesDir,
                self.config.filenamePrefixCalciumE)

            if not calDF_E.empty:
                calMetricsE = pandas.concat(
                    [calDF_E.mean(axis=1),
                     calDF_E.std(axis=1)],
                    axis=1)
                calMetricsEfile = (
                    self.config.filenamePrefixCalciumE + 'all.txt'
                )
                calMetricsE.to_csv(
                    calMetricsEfile, sep='\t',
                    header=None, line_terminator='\n')
                print("Processed cal metrics for E neurons..")
            else:
                print("No cal metric df for E neurons. Skipping.")

            calDF_I = combiner.combineCSVRowLists(
                self.config.unconsolidatedFilesDir,
                self.config.filenamePrefixCalciumI)

            if not calDF_I.empty:
                calMetricsI = pandas.concat(
                    [calDF_I.mean(axis=1),
                     calDF_I.std(axis=1)],
                    axis=1)
                calMetricsIfile = (
                    self.config.filenamePrefixCalciumI + 'all.txt'
                )
                calMetricsI.to_csv(
                    calMetricsIfile, sep='\t',
                    header=None, line_terminator='\n')
                print("Processed cal metrics for I neurons..")
            else:
                print("No cal metric df for I neurons. Skipping.")

            if (not calDF_E.empty) and (not calDF_I.empty):
                args = (os.path.join(
                    self.config.postprocessHome,
                    self.config.gnuplotFilesDir,
                        'plot-cal-metrics.plt'))
                subprocess.call(['gnuplot',
                                args])
                print("Calcium graphs generated..")
            else:
                print("No calcium metric graphs generated.")

    def __postprocess_conductances(self):
        """Post process conductances, print means."""
        if self.config.conductancesMetrics:
            print("Processing conductances..")
            import nest.combineFiles
            combiner = nest.combineFiles.CombineFiles()
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

            if ((not conductancesDF_EE.empty) and (not conductancesDF_EI.empty)
                    and (not conductancesDF_IE.empty)
                    and (not conductancesDF_II.empty)):
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
        if self.config.timegraphs:
            print("Generating timegraph..")
            import nest.timeGraphPlotter as TGP
            tgp = TGP.timeGraphPlotter(self.config)
            tgp.plot_all()

        if self.config.histograms:
            print("Generating histograms..")
            import nest.dualHistogramPlotter as pltH
            import nest.getFiringRates as rg
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

            rateGetterB = rg.getFiringRates()
            if rateGetterB.setup(self.config.filenameB, 'B',
                                 self.config.neuronsB,
                                 self.config.rows_per_read):
                rateGetterB.run(self.config.histogram_timelist)

            rateGetterS = rg.getFiringRates()
            if rateGetterS.setup(self.config.filenameS, 'S',
                                 self.config.neuronsS,
                                 self.config.rows_per_read):
                rateGetterS.run(self.config.histogram_timelist)

            plotterBS = pltH.dualHistogramPlotter()
            if plotterBS.setup('B', 'S', self.config.neuronsB,
                               self.config.neuronsS):
                plotterBS.run()

        if self.config.rasters:
            print("Generating rasters..")
            import nest.dualRasterPlotter as pltR
            rasterPlotterEI = pltR.dualRasterPlotter()
            if rasterPlotterEI.setup('E', 'I', self.config.neuronsE,
                                     self.config.neuronsI,
                                     self.config.rows_per_read):
                rasterPlotterEI.run(self.config.histogram_timelist)

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
