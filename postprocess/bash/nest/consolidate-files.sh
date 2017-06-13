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

    echo "Combining stim spike files"
    LC_ALL=C sort -k "2" -n --parallel=16 -T $SORTTMPDIR "spikes-stim-""$pat"*.gdf  > "spikes-stim-""$pat"".gdf"
    mv "spikes-stim-""$pat"".gdf" consolidated_files

    echo "Combining pattern neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "patternneurons-""$pat""-rank-"*.txt | uniq > "patternneurons-""$pat"".txt"
    mv "patternneurons-""$pat"".txt" consolidated_files

    echo "Combining recall neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "recallneurons-""$pat""-rank-"*.txt | uniq > "recallneurons-""$pat"".txt"
    mv "recallneurons-""$pat"".txt" consolidated_files

    echo "Combining background neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "backgroundneurons-""$pat""-rank-"*.txt | uniq > "backgroundneurons-""$pat"".txt"
    mv "backgroundneurons-""$pat"".txt" consolidated_files

    echo "Combining lpz background neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "lpz-backgroundneurons-""$pat""-rank-"*.txt | uniq > "lpz-backgroundneurons-""$pat"".txt"
    mv "lpz-backgroundneurons-""$pat"".txt" consolidated_files

    echo "Combining non lpz background neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "non-lpz-backgroundneurons-""$pat""-rank-"*.txt | uniq > "non-lpz-backgroundneurons-""$pat"".txt"
    mv "non-lpz-backgroundneurons-""$pat"".txt" consolidated_files

    echo "Combining lpz I neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "lpz-Ineurons-""$pat""-rank-"*.txt | uniq > "lpz-Ineurons-""$pat"".txt"
    mv "lpz-Ineurons-""$pat"".txt" consolidated_files

    echo "Combining non lpz I neuron files"
    LC_ALL=C sort -n --parallel=16 -T $SORTTMPDIR "non-lpz-Ineurons-""$pat""-rank-"*.txt | uniq > "non-lpz-Ineurons-""$pat"".txt"
    mv "non-lpz-Ineurons-""$pat"".txt" consolidated_files
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

echo "Removed $SORTTMPDIR"
rm -rf $SORTTMPDIR
echo "All files combined."
exit 0
