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

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import configparser


class Config:

    """Config post process globals."""

    def __init__(self, taskfile='config.ini'):
        """Initialise."""
        self.timegraphs = True
        self.snr = False
        self.histogram_timelist = [0.]
        self.gridplots_timelist = [0.]
        self.snr_timelist = [0.]
        self.taskfile = taskfile

        self.postprocessHome = ""
        self.gnuplotFilesDir = ""

        self.filenameE = ""
        self.filenameLPZE = ""
        self.filenameI = ""
        self.filenameLPZI = ""
        self.filenameP = ""
        self.filenameB = ""
        self.filenameMeanRatesE = ""
        self.filenameMeanRatesLPZE = ""
        self.filenameMeanRatesI = ""
        self.filenameMeanRatesLPZI = ""
        self.filenamePrefixMeanRatesP = ""
        self.filenamePrefixMeanRatesB = ""
        self.filenameSTDRatesE = ""
        self.filenameSTDRatesLPZE = ""
        self.filenameSTDRatesI = ""
        self.filenameSTDRatesLPZI = ""
        self.filenamePrefixSTDRatesP = ""
        self.filenamePrefixSTDRatesB = ""
        self.filenameMeanCVE = ""
        self.filenameMeanCVLPZE = ""
        self.filenameMeanCVI = ""
        self.filenameMeanCVLPZI = ""
        self.filenamePrefixMeanCVP = ""
        self.filenamePrefixMeanCVB = ""
        self.filenameMeanFanoE = ""
        self.filenameMeanFanoLPZE = ""
        self.filenameMeanFanoI = ""
        self.filenameMeanFanoLPZI = ""
        self.filenamePrefixMeanFanoP = ""
        self.filenamePrefixMeanFanoB = ""

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

        self.numpats = 0
        self.neuronsE = 0
        self.neuronsI = 0
        self.neuronsLPZE = 0
        self.neuronsLPZI = 0

        parser = configparser.ConfigParser()
        parser.read(self.taskfile)

        # Some configs
        self.postprocessHome = parser['default']['postprocessHome']
        self.gnuplotFilesDir = parser['default']['gnuplotFilesDir']

        # all the different neuron sets
        self.filenameE = parser['default']['filenameE']
        self.neuronListE = parser['default']['neuronListE']
        self.filenameLPZE = parser['default']['filenameLPZE']
        self.neuronListLPZE = parser['default']['neuronListLPZE']
        self.filenameI = parser['default']['filenameI']
        self.neuronListI = parser['default']['neuronListI']
        self.filenameLPZI = parser['default']['filenameLPZI']
        self.neuronListLPZI = parser['default']['neuronListLPZI']
        # multiple patterns and so related files
        self.filenamePrefixB = parser['default']['filenamePrefixB']
        self.neuronListPrefixB = parser['default']['neuronListPrefixB']
        self.filenamePrefixP = parser['default']['filenamePrefixP']
        self.neuronListPrefixP = parser['default']['neuronListPrefixP']

        # where the unconsolidated files are
        # because its easier to consolidate raster files using sort
        self.unconsolidatedFilesDir = parser['default']['unconsolidatedFilesDir']

        self.calciumMetrics = parser['default'].getboolean('calciumMetrics')
        self.filenamePrefixCalciumE = parser['default']['calciumConcPrefixE']
        self.filenamePrefixCalciumI = parser['default']['calciumConcPrefixI']
        self.filenamePrefixCalciumLPZE = parser['default']['calciumConcPrefixLPZE']
        self.filenamePrefixCalciumLPZI = parser['default']['calciumConcPrefixLPZI']

        self.SETotalsMetrics = parser['default'].getboolean('SETotalsMetrics')
        self.filenamePrefixSETotalsE = parser['default']['SETotalsPrefixE']
        self.filenamePrefixSETotalsI = parser['default']['SETotalsPrefixI']
        self.filenamePrefixSETotalsLPZE = parser['default']['SETotalsPrefixLPZE']
        self.filenamePrefixSETotalsLPZI = parser['default']['SETotalsPrefixLPZI']

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
        self.grid = parser['default'].getboolean('grids')
        self.histogram_timelist = [float(s) for s in
                                   parser['histograms']['times'].split()]
        self.gridplots_timelist = [float(s) for s in
                                   parser['gridplots']['times'].split()]
        self.store_rate_files = parser['histograms'].getboolean(
            'store_rate_files')
        self.store_raster_files = parser['histograms'].getboolean(
            'store_raster_files')

        # snr
        self.snr = parser['default'].getboolean('snr')
        self.snr_timelist = [float(s) for s in parser['snr']['times'].split()]

    def __getMeanFiringRateFilename(self, inputname):
        """Generate mean firing rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('firing-rate-{}'.format(neuronSet))

    def __getSTDFiringRateFilename(self, inputname):
        """Generate STD firing rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('std-rate-{}'.format(neuronSet))

    def __getMeanCVFilename(self, inputname):
        """Generate CV rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('cv-rate-{}'.format(neuronSet))

    def __getMeanFanoFilename(self, inputname):
        """Generate Fano rate filename."""
        neuronSet = (inputname.split(sep='-', maxsplit=1)[1]).split(sep='.')[0]
        return ('fano-rate-{}'.format(neuronSet))

    def generateOutputFileNames(self):
        """Generate output file names from inputs file patterns."""
        self.filenameMeanRatesE = self.__getMeanFiringRateFilename(
            self.filenameE) + ".gdf"
        self.filenameMeanRatesLPZE = self.__getMeanFiringRateFilename(
            self.filenameLPZE) + ".gdf"
        self.filenameMeanRatesI = self.__getMeanFiringRateFilename(
            self.filenameI) + ".gdf"
        self.filenameMeanRatesLPZI = self.__getMeanFiringRateFilename(
            self.filenameLPZI) + ".gdf"
        self.filenamePrefixMeanRatesB = self.__getMeanFiringRateFilename(
            self.filenamePrefixB)
        self.filenamePrefixMeanRatesP = self.__getMeanFiringRateFilename(
            self.filenamePrefixP)

        self.filenameSTDRatesE = self.__getSTDFiringRateFilename(
            self.filenameE) + ".gdf"
        self.filenameSTDRatesLPZE = self.__getSTDFiringRateFilename(
            self.filenameLPZE) + ".gdf"
        self.filenameSTDRatesI = self.__getSTDFiringRateFilename(
            self.filenameI) + ".gdf"
        self.filenameSTDRatesLPZI = self.__getSTDFiringRateFilename(
            self.filenameLPZI) + ".gdf"
        self.filenamePrefixSTDRatesB = self.__getSTDFiringRateFilename(
            self.filenamePrefixB)
        self.filenamePrefixSTDRatesP = self.__getSTDFiringRateFilename(
            self.filenamePrefixP)

        self.filenameMeanCVE = self.__getMeanCVFilename(
            self.filenameE) + ".gdf"
        self.filenameMeanCVLPZE = self.__getMeanCVFilename(
            self.filenameLPZE) + ".gdf"
        self.filenameMeanCVI = self.__getMeanCVFilename(
            self.filenameI) + ".gdf"
        self.filenameMeanCVLPZI = self.__getMeanCVFilename(
            self.filenameLPZI) + ".gdf"
        self.filenamePrefixMeanCVB = self.__getMeanCVFilename(
            self.filenamePrefixB)
        self.filenamePrefixMeanCVP = self.__getMeanCVFilename(
            self.filenamePrefixP)

        self.filenameMeanFanoE = self.__getMeanFanoFilename(
            self.filenameE) + ".gdf"
        self.filenameMeanFanoE = self.__getMeanFanoFilename(
            self.filenameE) + ".gdf"
        self.filenameMeanFanoI = self.__getMeanFanoFilename(
            self.filenameI) + ".gdf"
        self.filenameMeanFanoLPZI = self.__getMeanFanoFilename(
            self.filenameLPZI) + ".gdf"
        self.filenamePrefixMeanFanoB = self.__getMeanFanoFilename(
            self.filenamePrefixB)
        self.filenamePrefixMeanFanoDP = self.__getMeanFanoFilename(
            self.filenamePrefixDP)
        self.filenamePrefixMeanFanoP = self.__getMeanFanoFilename(
            self.filenamePrefixP)

if __name__ == "__main__":
    config = Config()
    config.generateOutputFileNames()
