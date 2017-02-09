#!/bin/bash

# Copyright 2016 Ankur Sinha 
# Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com> 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# File : consolidate-spikes.sh
#

SORTTMPDIR="/home/asinha/dump/sort-tmpdir"
# Get number of patterns in this simulation
NUMPATS="$(ls spikes-pattern* | grep -Eo 'pattern-[0-9]+' | sort  | uniq | sed 's/pattern-//' | wc -l)"

echo "Combining files for NEST simulation"
mkdir consolidated_files

# Merge multiple pattern files
for pat in $(seq 1 $NUMPATS); do
    echo "Combining background files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-background-""$pat"*.gdf  > "spikes-background-""$pat"".gdf"
    mv "spikes-background-""$pat"".gdf" consolidated_files

    echo "Combining deaffed-bg-E files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-deaffed-bg-E-""$pat"*.gdf  > "spikes-deaffed-bg-E-""$pat"".gdf"
    mv "spikes-deaffed-bg-E-""$pat"".gdf" consolidated_files

    echo "Combining deaffed-bg-I files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-deaffed-bg-I-""$pat"*.gdf  > "spikes-deaffed-bg-I-""$pat"".gdf"
    mv "spikes-deaffed-bg-I-""$pat"".gdf" consolidated_files

    echo "Combining deaffed-pattern files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-deaffed-pattern-""$pat"*.gdf  > "spikes-deaffed-pattern-""$pat"".gdf"
    mv "spikes-deaffed-pattern-""$pat"".gdf" consolidated_files

    echo "Combining pattern files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-pattern-""$pat"*.gdf  > "spikes-pattern-""$pat"".gdf"
    mv "spikes-pattern-""$pat"".gdf" consolidated_files

    echo "Combining recall files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-recall-""$pat"*.gdf  > "spikes-recall-""$pat"".gdf"
    mv "spikes-recall-""$pat"".gdf" consolidated_files

    echo "Combining stim files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-stim-""$pat"*.gdf  > "spikes-stim-""$pat"".gdf"
    mv "spikes-stim-""$pat"".gdf" consolidated_files
done

echo "Combining E files"
LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR spikes-*E*.gdf > spikes-E.gdf
mv spikes-E.gdf consolidated_files

echo "Combining I files"
LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR spikes-*I*.gdf > spikes-I.gdf
mv spikes-I.gdf consolidated_files

echo "All files combined."
exit 0
