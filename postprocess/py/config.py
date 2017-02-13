#!/usr/bin/env python3
"""
Config postprocess variables.

File: config.py

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

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import configparser


class Config:

    """Config post process globals."""

    def __init__(self, taskfile='config.ini'):
        """Initialise."""
        self.timegraphs = True
        self.snr = False
        self.histogram_timelist = [0.]
        self.snr_time = 0.
        self.taskfile = taskfile

        self.postprocessHome = ""
        self.gnuplotFilesDir = ""

        self.filenameE = ""
        self.filenameI = ""
        self.filenameR = ""
        self.filenameB = ""
        self.filenameS = ""
        self.filenameDP = ""
        self.filenameDBGE = ""
        self.filenameDBGI = ""
        self.filenameP = ""
        self.filenameMeanRatesE = ""
        self.filenameMeanRatesI = ""
        self.filenameMeanRatesR = ""
        self.filenameMeanRatesB = ""
        self.filenameMeanRatesS = ""
        self.filenameMeanRatesDP = ""
        self.filenameMeanRatesDBGE = ""
        self.filenameMeanRatesDBGI = ""
        self.filenameMeanRatesP = ""
        self.filenameSTDRatesE = ""
        self.filenameSTDRatesI = ""
        self.filenameSTDRatesR = ""
        self.filenameSTDRatesB = ""
        self.filenameSTDRatesS = ""
        self.filenameSTDRatesDP = ""
        self.filenameSTDRatesDBGE = ""
        self.filenameSTDRatesDBGI = ""
        self.filenameSTDRatesP = ""
        self.filenameMeanCVE = ""
        self.filenameMeanCVI = ""
        self.filenameMeanCVR = ""
        self.filenameMeanCVB = ""
        self.filenameMeanCVS = ""
        self.filenameMeanCVDP = ""
        self.filenameMeanCVDBGE = ""
        self.filenameMeanCVDBGI = ""
        self.filenameMeanCVP = ""
        self.filenameMeanFanoE = ""
        self.filenameMeanFanoI = ""
        self.filenameMeanFanoR = ""
        self.filenameMeanFanoB = ""
        self.filenameMeanFanoS = ""
        self.filenameMeanFanoDP = ""
        self.filenameMeanFanoDBGE = ""
        self.filenameMeanFanoDBGI = ""
        self.filenameMeanFanoP = ""

        # where the unconsolidated files are
        self.unconsolidatedFilesDir = ""
        # The prefixes for these files
        self.filenamePrefixCalciumE = ""
        self.filenamePrefixCalciumI = ""
        self.filenamePrefixSEE = ""
        self.filenamePrefixSEI = ""
        self.filenamePrefixConductancesEE = ""
        self.filenamePrefixConductancesEI = ""
        self.filenamePrefixConductancesII = ""
        self.filenamePrefixConductancesIE = ""

        parser = configparser.ConfigParser()
        parser.read(self.taskfile)

        # Some configs
        self.postprocessHome = parser['default']['postprocessHome']
        self.gnuplotFilesDir = parser['default']['gnuplotFilesDir']

        # all the different neuron sets
        self.neuronsE = parser['default']['neuronsE']
        self.neuronsI = parser['default']['neuronsI']
        self.neuronsR = parser['default']['neuronsR']
        self.neuronsB = parser['default']['neuronsB']
        self.neuronsS = parser['default']['neuronsS']
        self.neuronsDP = parser['default']['neuronsDP']
        self.neuronsDBGE = parser['default']['neuronsDBGE']
        self.neuronsDBGI = parser['default']['neuronsDBGI']
        self.neuronsP = parser['default']['neuronsP']
        self.filenameE = parser['default']['filenameE']
        self.filenameI = parser['default']['filenameI']
        self.filenameR = parser['default']['filenameR']
        self.filenameB = parser['default']['filenameB']
        self.filenameS = parser['default']['filenameS']
        self.filenameDP = parser['default']['filenameDP']
        self.filenameDBGE = parser['default']['filenameDBGE']
        self.filenameDBGI = parser['default']['filenameDBGI']
        self.filenameP = parser['default']['filenameP']

        # where the unconsolidated files are
        # because its easier to consolidate raster files using sort
        self.unconsolidatedFilesDir = parser['default']['unconsolidatedFilesDir']

        self.calciumMetrics = parser['default'].getboolean('calciumMetrics')
        self.filenamePrefixCalciumE = parser['default']['calciumConcPrefixE']
        self.filenamePrefixCalciumI = parser['default']['calciumConcPrefixI']

        self.SETotalsMetrics = parser['default'].getboolean('SETotalsMetrics')
        self.filenamePrefixSETotalsE = parser['default']['SETotalsPrefixE']
        self.filenamePrefixSETotalsI = parser['default']['SETotalsPrefixI']

        self.SEIndividualMetrics = parser['default'].getboolean('SEIndividualMetrics')
        self.filenamePrefixSEIndividualE = parser['default']['SEIndividualPrefixE']
        self.filenamePrefixSEIndividualI = parser['default']['SEIndividualPrefixI']

        self.conductancesMetrics = parser['default'].getboolean('conductancesMetrics')
        self.filenamePrefixConductancesEE = parser['default']['conductancesPrefixEE']
        self.filenamePrefixConductancesEI = parser['default']['conductancesPrefixEI']
        self.filenamePrefixConductancesII = parser['default']['conductancesPrefixII']
        self.filenamePrefixConductancesIE = parser['default']['conductancesPrefixIE']

        self.timegraphs = parser['default'].getboolean('timegraphs')
        self.rows_per_read = int(parser['default']['rows_per_read'])

        # histograms and rasters
        self.histograms = parser['default'].getboolean('histograms')
        self.rasters = parser['default'].getboolean('rasters')
        self.histogram_timelist = [float(s) for s in
                                   parser['histograms']['times'].split()]
        self.store_rate_files = parser['histograms'].getboolean(
            'store_rate_files')
        self.store_raster_files = parser['histograms'].getboolean(
            'store_raster_files')

        # snr
        self.snr = parser['default'].getboolean('snr')
        self.snr_time = float(parser['snr']['times'])

    def __getMeanFiringRateFilename(self, inputname):
        """Generate mean firing rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('firing-rate-{}.gdf'.format(neuronSet))

    def __getSTDFiringRateFilename(self, inputname):
        """Generate STD firing rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('std-rate-{}.gdf'.format(neuronSet))

    def __getMeanCVFilename(self, inputname):
        """Generate CV rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('cv-rate-{}.gdf'.format(neuronSet))

    def __getMeanFanoFilename(self, inputname):
        """Generate Fano rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('fano-rate-{}.gdf'.format(neuronSet))

    def generateOutputFileNames(self):
        """Generate output file names from inputs file patterns."""
        self.filenameMeanRatesE = self.__getMeanFiringRateFilename(
            self.filenameE)
        self.filenameMeanRatesI = self.__getMeanFiringRateFilename(
            self.filenameI)
        self.filenameMeanRatesR = self.__getMeanFiringRateFilename(
            self.filenameR)
        self.filenameMeanRatesB = self.__getMeanFiringRateFilename(
            self.filenameB)
        self.filenameMeanRatesS = self.__getMeanFiringRateFilename(
            self.filenameS)
        self.filenameMeanRatesDP = self.__getMeanFiringRateFilename(
            self.filenameDP)
        self.filenameMeanRatesP = self.__getMeanFiringRateFilename(
            self.filenameP)

        self.filenameSTDRatesE = self.__getSTDFiringRateFilename(
            self.filenameE)
        self.filenameSTDRatesI = self.__getSTDFiringRateFilename(
            self.filenameI)
        self.filenameSTDRatesR = self.__getSTDFiringRateFilename(
            self.filenameR)
        self.filenameSTDRatesB = self.__getSTDFiringRateFilename(
            self.filenameB)
        self.filenameSTDRatesS = self.__getSTDFiringRateFilename(
            self.filenameS)
        self.filenameSTDRatesDP = self.__getSTDFiringRateFilename(
            self.filenameDP)
        self.filenameSTDRatesP = self.__getSTDFiringRateFilename(
            self.filenameP)

        self.filenameMeanCVE = self.__getMeanCVFilename(
            self.filenameE)
        self.filenameMeanCVI = self.__getMeanCVFilename(
            self.filenameI)
        self.filenameMeanCVR = self.__getMeanCVFilename(
            self.filenameR)
        self.filenameMeanCVB = self.__getMeanCVFilename(
            self.filenameB)
        self.filenameMeanCVS = self.__getMeanCVFilename(
            self.filenameS)
        self.filenameMeanCVDP = self.__getMeanCVFilename(
            self.filenameDP)
        self.filenameMeanCVP = self.__getMeanCVFilename(
            self.filenameP)

        self.filenameMeanFanoE = self.__getMeanFanoFilename(
            self.filenameE)
        self.filenameMeanFanoI = self.__getMeanFanoFilename(
            self.filenameI)
        self.filenameMeanFanoR = self.__getMeanFanoFilename(
            self.filenameR)
        self.filenameMeanFanoB = self.__getMeanFanoFilename(
            self.filenameB)
        self.filenameMeanFanoS = self.__getMeanFanoFilename(
            self.filenameS)
        self.filenameMeanFanoDP = self.__getMeanFanoFilename(
            self.filenameDP)
        self.filenameMeanFanoP = self.__getMeanFanoFilename(
            self.filenameP)

if __name__ == "__main__":
    config = Config()
    config.generateOutputFileNames()
