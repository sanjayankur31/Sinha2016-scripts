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
        self.filenamePrefixMeanRatesR = ""
        self.filenamePrefixMeanRatesB = ""
        self.filenamePrefixMeanRatesS = ""
        self.filenamePrefixMeanRatesDP = ""
        self.filenamePrefixMeanRatesDBGE = ""
        self.filenamePrefixMeanRatesDBGI = ""
        self.filenamePrefixMeanRatesP = ""
        self.filenameSTDRatesE = ""
        self.filenameSTDRatesI = ""
        self.filenamePrefixSTDRatesR = ""
        self.filenamePrefixSTDRatesB = ""
        self.filenamePrefixSTDRatesS = ""
        self.filenamePrefixSTDRatesDP = ""
        self.filenamePrefixSTDRatesDBGE = ""
        self.filenamePrefixSTDRatesDBGI = ""
        self.filenamePrefixSTDRatesP = ""
        self.filenameMeanCVE = ""
        self.filenameMeanCVI = ""
        self.filenamePrefixMeanCVR = ""
        self.filenamePrefixMeanCVB = ""
        self.filenamePrefixMeanCVS = ""
        self.filenamePrefixMeanCVDP = ""
        self.filenamePrefixMeanCVDBGE = ""
        self.filenamePrefixMeanCVDBGI = ""
        self.filenamePrefixMeanCVP = ""
        self.filenameMeanFanoE = ""
        self.filenameMeanFanoI = ""
        self.filenamePrefixMeanFanoR = ""
        self.filenamePrefixMeanFanoB = ""
        self.filenamePrefixMeanFanoS = ""
        self.filenamePrefixMeanFanoDP = ""
        self.filenamePrefixMeanFanoDBGE = ""
        self.filenamePrefixMeanFanoDBGI = ""
        self.filenamePrefixMeanFanoP = ""

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
        self.neuronListE = parser['default']['neuronListE']
        self.filenameI = parser['default']['filenameI']
        self.neuronListI = parser['default']['neuronListI']
        # multiple patterns and so related files
        self.filenamePrefixR = parser['default']['filenamePrefixR']
        self.neuronListPrefixR = parser['default']['neuronListPrefixR']
        self.filenamePrefixB = parser['default']['filenamePrefixB']
        self.neuronListPrefixB = parser['default']['neuronListPrefixB']
        self.filenamePrefixS = parser['default']['filenamePrefixS']
        self.neuronListPrefixS = parser['default']['neuronListPrefixS']
        self.filenamePrefixDP = parser['default']['filenamePrefixDP']
        self.neuronListPrefixDP = parser['default']['neuronListPrefixDP']
        self.filenamePrefixDBGE = parser['default']['filenamePrefixDBGE']
        self.neuronListPrefixDBGE = parser['default']['neuronListPrefixDBGE']
        self.filenamePrefixDBGI = parser['default']['filenamePrefixDBGI']
        self.neuronListPrefixDBGI = parser['default']['neuronListPrefixDBGI']
        self.filenamePrefixP = parser['default']['filenamePrefixP']
        self.neuronListPrefixP = parser['default']['neuronListPrefixP']

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
        self.snr_time = float(parser['snr']['times'])


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
        self.filenameMeanRatesI = self.__getMeanFiringRateFilename(
            self.filenameI) + ".gdf"
        self.filenamePrefixMeanRatesR = self.__getMeanFiringRateFilename(
            self.filenamePrefixR)
        self.filenamePrefixMeanRatesB = self.__getMeanFiringRateFilename(
            self.filenamePrefixB)
        self.filenamePrefixMeanRatesS = self.__getMeanFiringRateFilename(
            self.filenamePrefixS)
        self.filenamePrefixMeanRatesDP = self.__getMeanFiringRateFilename(
            self.filenamePrefixDP)
        self.filenamePrefixMeanRatesP = self.__getMeanFiringRateFilename(
            self.filenamePrefixP)
        self.filenamePrefixMeanRatesDBGE = self.__getMeanFiringRateFilename(
            self.filenamePrefixDBGE)
        self.filenamePrefixMeanRatesDBGI = self.__getMeanFiringRateFilename(
            self.filenamePrefixDBGI)

        self.filenameSTDRatesE = self.__getSTDFiringRateFilename(
            self.filenameE) + ".gdf"
        self.filenameSTDRatesI = self.__getSTDFiringRateFilename(
            self.filenameI) + ".gdf"
        self.filenamePrefixSTDRatesR = self.__getSTDFiringRateFilename(
            self.filenamePrefixR)
        self.filenamePrefixSTDRatesB = self.__getSTDFiringRateFilename(
            self.filenamePrefixB)
        self.filenamePrefixSTDRatesS = self.__getSTDFiringRateFilename(
            self.filenamePrefixS)
        self.filenamePrefixSTDRatesDP = self.__getSTDFiringRateFilename(
            self.filenamePrefixDP)
        self.filenamePrefixSTDRatesP = self.__getSTDFiringRateFilename(
            self.filenamePrefixP)
        self.filenamePrefixSTDRatesDBGE = self.__getSTDFiringRateFilename(
            self.filenamePrefixDBGE)
        self.filenamePrefixSTDRatesDBGI = self.__getSTDFiringRateFilename(
            self.filenamePrefixDBGI)

        self.filenameMeanCVE = self.__getMeanCVFilename(
            self.filenameE) + ".gdf"
        self.filenameMeanCVI = self.__getMeanCVFilename(
            self.filenameI) + ".gdf"
        self.filenamePrefixMeanCVR = self.__getMeanCVFilename(
            self.filenamePrefixR)
        self.filenamePrefixMeanCVB = self.__getMeanCVFilename(
            self.filenamePrefixB)
        self.filenamePrefixMeanCVS = self.__getMeanCVFilename(
            self.filenamePrefixS)
        self.filenamePrefixMeanCVDP = self.__getMeanCVFilename(
            self.filenamePrefixDP)
        self.filenamePrefixMeanCVP = self.__getMeanCVFilename(
            self.filenamePrefixP)
        self.filenamePrefixMeanCVDBGE = self.__getMeanCVFilename(
            self.filenamePrefixDBGE)
        self.filenamePrefixMeanCVDBGI = self.__getMeanCVFilename(
            self.filenamePrefixDBGI)

        self.filenameMeanFanoE = self.__getMeanFanoFilename(
            self.filenameE) + ".gdf"
        self.filenameMeanFanoI = self.__getMeanFanoFilename(
            self.filenameI) + ".gdf"
        self.filenamePrefixMeanFanoR = self.__getMeanFanoFilename(
            self.filenamePrefixR)
        self.filenamePrefixMeanFanoB = self.__getMeanFanoFilename(
            self.filenamePrefixB)
        self.filenamePrefixMeanFanoS = self.__getMeanFanoFilename(
            self.filenamePrefixS)
        self.filenamePrefixMeanFanoDP = self.__getMeanFanoFilename(
            self.filenamePrefixDP)
        self.filenamePrefixMeanFanoP = self.__getMeanFanoFilename(
            self.filenamePrefixP)
        self.filenamePrefixMeanFanoDBGE = self.__getMeanFanoFilename(
            self.filenamePrefixDBGE)
        self.filenamePrefixMeanFanoDBGI = self.__getMeanFanoFilename(
            self.filenamePrefixDBGI)

if __name__ == "__main__":
    config = Config()
    config.generateOutputFileNames()
