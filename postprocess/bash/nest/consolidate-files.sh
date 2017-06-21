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

SORTTMPDIR="/simulation-drive/sort-tmpdir"
echo "Created $SORTTMPDIR"
mkdir -p $SORTTMPDIR
# Get number of patterns in this simulation
NUMPATS="$(ls spikes-pattern* | grep -Eo 'pattern-[0-9]+' | sort  | uniq | sed 's/pattern-//' | wc -l)"

echo "Combining files for NEST simulation"
mkdir consolidated_files

# Merge multiple pattern files
for pat in $(seq 1 $NUMPATS); do
    echo "Combining pattern spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-pattern-""$pat"*.gdf  > "spikes-pattern-""$pat"".gdf"
    mv "spikes-pattern-""$pat"".gdf" consolidated_files

    echo "Combining background spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-background-""$pat"*.gdf  > "spikes-background-""$pat"".gdf"
    mv "spikes-background-""$pat"".gdf" consolidated_files

    echo "Combining recall spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-recall-""$pat"*.gdf  > "spikes-recall-""$pat"".gdf"
    mv "spikes-recall-""$pat"".gdf" consolidated_files

    echo "Combining lpz-pattern spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-lpz-pattern-""$pat"*.gdf  > "spikes-lpz-pattern-""$pat"".gdf"
    mv "spikes-lpz-pattern-""$pat"".gdf" consolidated_files

    echo "Combining lpz-bg-E spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-lpz-bg-E-""$pat"*.gdf  > "spikes-lpz-bg-E-""$pat"".gdf"
    mv "spikes-lpz-bg-E-""$pat"".gdf" consolidated_files

    echo "Combining lpz-bg-I spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-lpz-bg-I-""$pat"*.gdf  > "spikes-lpz-bg-I-""$pat"".gdf"
    mv "spikes-lpz-bg-I-""$pat"".gdf" consolidated_files

    echo "Moving pattern neuron files"
    mv "00-pattern-neurons-""$pat"".txt" consolidated_files

    echo "Moving background neuron files"
    mv "00-background-neurons-""$pat"".txt" consolidated_files

    echo "Moving recall neuron files"
    mv "00-recall-neurons-""$pat"".txt" consolidated_files
done

echo "Combining E files"
LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR spikes-E*.gdf > spikes-E.gdf
mv spikes-E.gdf consolidated_files

echo "Combining I files"
LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR spikes-I*.gdf > spikes-I.gdf
mv spikes-I.gdf consolidated_files

echo "Combining LPZ E files"
LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR spikes-lpz-E*.gdf > spikes-lpz-E.gdf
mv spikes-lpz-E.gdf consolidated_files

echo "Combining LPZ I files"
LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR spikes-lpz-I*.gdf > spikes-lpz-I.gdf
mv spikes-lpz-I.gdf consolidated_files

echo "Moving neuron location files"
mv *neuron* consolidated_files/ -v

echo "Removed $SORTTMPDIR"
rm -rf $SORTTMPDIR
echo "All files combined."
exit 0
