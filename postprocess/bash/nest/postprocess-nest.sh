#!/bin/bash
# Copyright 2017 Ankur Sinha

# This is a master script that does whatever is needed to postprocess
# simulations. The paths may need updating depending on one's simulation and
# postprocessing setup

# There is no error checking here, so if anything is wrong, it'll break.

# Where the combined files and resultant graphs are kept
CONSOLIDATED_DIR="consolidated_files"
# location of postprocessing script repository
SCRIPTS_HOME="/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/"
# location of data generated by simulation
CLUSTER_PATH="asinha@uhhpc:/beegfs/general/asinha/simulations-nest/"
# TMP dir for sorting and so on
SORTTMPDIR="/simulation-drive/sort-tmpdir"
# name of generated directory
DIRNAME=""
# Number of parallel calls
NUM_PARALLEL=16

function setup() {
    pushd "$DIRNAME"
        echo "Creating consolidated dir and copying info files"
        mkdir "$CONSOLIDATED_DIR"

        echo "Moving neuron location files"
        cp -v -- 00-locations*.txt "$CONSOLIDATED_DIR"/
        echo "Moving commit info file"
        cp -v -- 00-GIT* "$CONSOLIDATED_DIR"/
        echo "Moving parameter info file"
        cp -v -- 99* "$CONSOLIDATED_DIR"/

        echo "Moving simulation output files"
        cp -v -- nest*.* "$CONSOLIDATED_DIR"/
    popd
}

# combine spike files and the sort and move them to the $CONSOLIDATED_DIR
combine ()
{
    pushd "$DIRNAME"
        echo "Created $SORTTMPDIR"
        mkdir -p "$SORTTMPDIR"
        # Get number of patterns in this simulation
        # I know what I'm doing here, there may be a better way, but this
        # works.
        # shellcheck disable=SC2010
        NUMPATS="$(ls spikes-pattern* | grep -Eo 'pattern-[0-9]+' | sort  | uniq | sed 's/pattern-//' | wc -l)"

        echo "Combining files for NEST simulation"

        # Merge multiple pattern files
        for pat in $(seq 1 "$NUMPATS"); do
            echo "Combining pattern spike files"
            LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" "spikes-pattern-""$pat"*.gdf  > "spikes-pattern-""$pat"".gdf"
            mv "spikes-pattern-""$pat"".gdf" "$CONSOLIDATED_DIR"

            echo "Combining background spike files"
            LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" "spikes-background-""$pat"*.gdf  > "spikes-background-""$pat"".gdf"
            mv "spikes-background-""$pat"".gdf" "$CONSOLIDATED_DIR"

            echo "Moving pattern neuron files"
            mv "00-pattern-neurons-""$pat"".txt" "$CONSOLIDATED_DIR"

            echo "Moving background neuron files"
            mv "00-background-neurons-""$pat"".txt" "$CONSOLIDATED_DIR"
        done

        echo "Combining lpz_c_E files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-lpz_c_E*.gdf > spikes-lpz_c_E.gdf

        echo "Combining lpz_b_E files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-lpz_b_E*.gdf > spikes-lpz_b_E.gdf

        echo "Combining p_lpz_E files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-p_lpz_E*.gdf > spikes-p_lpz_E.gdf

        echo "Combining o_E files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-o_E*.gdf > spikes-o_E.gdf

        echo "Combining all E files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-p_lpz_E.gdf spikes-lpz_c_E.gdf spikes-lpz_b_E.gdf spikes-o_E.gdf > spikes-E.gdf

        mv spikes-lpz_c_E.gdf "$CONSOLIDATED_DIR"
        mv spikes-lpz_b_E.gdf "$CONSOLIDATED_DIR"
        mv spikes-p_lpz_E.gdf "$CONSOLIDATED_DIR"
        mv spikes-o_E.gdf "$CONSOLIDATED_DIR"
        mv spikes-E.gdf "$CONSOLIDATED_DIR"

        echo "Combining lpz_c_I files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-lpz_c_I*.gdf > spikes-lpz_c_I.gdf

        echo "Combining lpz_b_I files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-lpz_b_I*.gdf > spikes-lpz_b_I.gdf

        echo "Combining p_lpz_I files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-p_lpz_I*.gdf > spikes-p_lpz_I.gdf

        echo "Combining o_I files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-o_I*.gdf > spikes-o_I.gdf

        echo "Combining all I files"
        LC_ALL=C sort -k "2" -n --parallel=16 -T "$SORTTMPDIR" spikes-p_lpz_I.gdf spikes-lpz_c_I.gdf spikes-lpz_b_I.gdf spikes-o_I.gdf > spikes-I.gdf

        mv spikes-lpz_c_I.gdf "$CONSOLIDATED_DIR"
        mv spikes-lpz_b_I.gdf "$CONSOLIDATED_DIR"
        mv spikes-p_lpz_I.gdf "$CONSOLIDATED_DIR"
        mv spikes-o_I.gdf "$CONSOLIDATED_DIR"
        mv spikes-I.gdf "$CONSOLIDATED_DIR"
    popd
}

# Fetches the files from the generated location to the local machine for
# postprocessing
# For parallel rsync, refer to:
# https://gist.github.com/rcoup/5358786
# https://gist.github.com/rcoup/5358786#gistcomment-1452246
# Note that this works well if all files are in the same directory and may need
# tweaks if there are multiple subdirectories.
fetch ()
{
    command -v parallel > /dev/null 2>&1 || { echo "GNU parallel is required but cannot be found. Exiting" >&2 ; exit 1; }

    TMPDIR=$(mktemp -d)
    echo "TMPDIR is: $TMPDIR"
    echo "Fetching file list"
    rsync --out-format="%l %n" -m --no-v --dry-run --recursive "$CLUSTER_PATH/$DIRNAME"/result/. "$DIRNAME" | sed '/\//d' | sort -n -r > "$TMPDIR"/"$DIRNAME".all

    echo "Calculating chunks"
    cat $TMPDIR/"$DIRNAME".all | cut -d\  -f2 | split -d -a1 -n r/10 - $TMPDIR/chunk.

    # echo "Chunks are:"
    # find "$TMPDIR" -type f -name "chunk.*" -printf "\n*** %p ***\n" -exec cat {} \;

    echo "Starting transfers..."
    find "$TMPDIR" -type f -name "chunk.*" | parallel -j $NUM_PARALLEL -t --verbose --progress rsync -z --ignore-existing --info=progress2 --human-readable --files-from={} "$CLUSTER_PATH/$DIRNAME"/result/ "$DIRNAME"

    # Don't need to use parallel for these two files
    echo "Fetching simulation logs"
    rsync -azmhR --ignore-existing --info=progress2 "$CLUSTER_PATH/$DIRNAME"/nest*.e* "$CLUSTER_PATH/$DIRNAME"/nest*.o* "$DIRNAME"

    echo "Remove file list"
    rm -rvf "$TMPDIR"
}

# runs the python postprocessing script that does the analysis and graph
# generation
pypostprocess ()
{
    pushd "$DIRNAME/$CONSOLIDATED_DIR"
        cp -v "$SCRIPTS_HOME/config.ini" .
        python3 "$SCRIPTS_HOME/postprocess/py/postprocess.py"
    popd
}

# renames files by appending the simulation timestamp (which is the directory
# name in my setup) to all generated graph files
rename_files ()
{
    pushd "$DIRNAME/$CONSOLIDATED_DIR"
        for i in *.png;
        do
            # only rename a file if it isn't already renamed
            if [[ "$i" != "$DIRNAME-"* ]]; then
                mv "$i" "$DIRNAME-$i" -v
            fi
        done
    popd
}

# Describes how this script should be used
usage ()
{
    cat << EOF
    usage: $0 flag <simulation directory name>

    Master script file that calls various scripts to postprocess simulation data.

    Tip: To postprocess multiple simulation directories, run this in a for loop.

    OPTIONS:
    -h  Show this message and quit

    -a  fetch, combine, pypostprocess, rename

    -f  fetch
        fetches files from the stri-cluster

    -c  combine spike files

    -p  pypostprocess, rename
        Copies over a fresh copy of config.ini, so make sure that's modified
        to how you want it

    -r  prepend directory name to generated png files
        iterates over all pngs and appends the dirname prefix.

EOF

}

# check for options
if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

# parse options
while getopts "a:f:c:p:r:h" OPTION
do
    case $OPTION in
        a)
            DIRNAME=$OPTARG
            fetch
            setup
            combine
            pypostprocess
            rename_files
            ;;
        f)
            DIRNAME=$OPTARG
            fetch
            setup
            ;;
        c)
            DIRNAME=$OPTARG
            setup
            combine
            ;;
        p)
            DIRNAME=$OPTARG
            setup
            pypostprocess
            rename_files
            ;;
        r)
            DIRNAME=$OPTARG
            rename_files
            ;;
        h)
            usage
            exit 1
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done
