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

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
        self.filenameL = ""
        self.filenameP = ""
        self.filenameMeanRatesE = ""
        self.filenameMeanRatesI = ""
        self.filenameMeanRatesR = ""
        self.filenameMeanRatesB = ""
        self.filenameMeanRatesS = ""
        self.filenameMeanRatesL = ""
        self.filenameMeanRatesP = ""
        self.filenameMeanCVE = ""
        self.filenameMeanCVI = ""
        self.filenameMeanCVR = ""
        self.filenameMeanCVB = ""
        self.filenameMeanCVS = ""
        self.filenameMeanCVL = ""
        self.filenameMeanCVP = ""
        self.filenameMeanFanoE = ""
        self.filenameMeanFanoI = ""
        self.filenameMeanFanoR = ""
        self.filenameMeanFanoB = ""
        self.filenameMeanFanoS = ""
        self.filenameMeanFanoL = ""
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
        self.neuronsL = parser['default']['neuronsL']
        self.neuronsP = parser['default']['neuronsP']
        self.filenameE = parser['default']['filenameE']
        self.filenameI = parser['default']['filenameI']
        self.filenameR = parser['default']['filenameR']
        self.filenameB = parser['default']['filenameB']
        self.filenameS = parser['default']['filenameS']
        self.filenameL = parser['default']['filenameL']
        self.filenameP = parser['default']['filenameP']
        self.filenameMeanRatesE = parser['default']['filenameMeanRatesE']
        self.filenameMeanRatesI = parser['default']['filenameMeanRatesI']
        self.filenameMeanRatesR = parser['default']['filenameMeanRatesR']
        self.filenameMeanRatesB = parser['default']['filenameMeanRatesB']
        self.filenameMeanRatesS = parser['default']['filenameMeanRatesS']
        self.filenameMeanRatesL = parser['default']['filenameMeanRatesL']
        self.filenameMeanRatesP = parser['default']['filenameMeanRatesP']
        self.filenameSTDRatesE = parser['default']['filenameSTDRatesE']
        self.filenameSTDRatesI = parser['default']['filenameSTDRatesI']
        self.filenameSTDRatesR = parser['default']['filenameSTDRatesR']
        self.filenameSTDRatesB = parser['default']['filenameSTDRatesB']
        self.filenameSTDRatesS = parser['default']['filenameSTDRatesS']
        self.filenameSTDRatesL = parser['default']['filenameSTDRatesL']
        self.filenameSTDRatesP = parser['default']['filenameSTDRatesP']
        self.filenameMeanCVE = parser['default']['filenameMeanCVE']
        self.filenameMeanCVI = parser['default']['filenameMeanCVI']
        self.filenameMeanCVR = parser['default']['filenameMeanCVR']
        self.filenameMeanCVB = parser['default']['filenameMeanCVB']
        self.filenameMeanCVS = parser['default']['filenameMeanCVS']
        self.filenameMeanCVL = parser['default']['filenameMeanCVL']
        self.filenameMeanCVP = parser['default']['filenameMeanCVP']
        self.filenameMeanFanoE = parser['default']['filenameMeanFanoE']
        self.filenameMeanFanoI = parser['default']['filenameMeanFanoI']
        self.filenameMeanFanoR = parser['default']['filenameMeanFanoR']
        self.filenameMeanFanoB = parser['default']['filenameMeanFanoB']
        self.filenameMeanFanoS = parser['default']['filenameMeanFanoS']
        self.filenameMeanFanoL = parser['default']['filenameMeanFanoL']
        self.filenameMeanFanoP = parser['default']['filenameMeanFanoP']

        # where the unconsolidated files are
        # because its easier to consolidate raster files using sort
        self.unconsolidatedFilesDir = parser['default']['unconsolidatedFilesDir']

        self.calciumMetrics = parser['default'].getboolean('calciumMetrics')
        self.filenamePrefixCalciumE = parser['default']['calciumConcPrefixE']
        self.filenamePrefixCalciumI = parser['default']['calciumConcPrefixI']

        self.SETotalsMetrics = parser['default'].getboolean('SETotalsMetrics')
        self.filenamePrefixSETotalsE = parser['default']['SETotalsPrefixE']
        self.filenamePrefixSETotalsI = parser['default']['SETotalsPrefixI']

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

if __name__ == "__main__":
    config = Config()
