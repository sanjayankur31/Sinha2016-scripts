#!/bin/bash

# Copyright 2015 Ankur Sinha
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
# File : start-nest-job.sh
#
# Queue's up a new nest job for me.

SOURCE_PATH="/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016/"
SCRIPT_PATH="/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/runners/"
GIT_COMMIT=""
SIM_PATH="/beegfs/general/asinha/simulations-nest/"
SIM_TIME=$(date +%Y%m%d%H%M)
RUN_SCRIPT="stri-cluster/nest-runsim.sh"
RUN_NEW=""
ERROR="no"
NUM_NODES=4
NUM_PROCS=0
NUM_MPI_NODES=128
WALLTIME="48:00:00"
CUR_SIM_PATH=""
MODULE_TO_USE=""

function queue_task
{
    pushd "$CUR_SIM_PATH"
        qsub "$RUN_NEW"
    popd
}

function setup_env
{
    CUR_SIM_PATH="$SIM_PATH""$SIM_TIME"
    echo "Setting up simulation: $SIM_TIME/$GIT_COMMIT"
    echo "This simulation will run in: $CUR_SIM_PATH"
    mkdir -pv "$CUR_SIM_PATH"

    pushd "$CUR_SIM_PATH"
        echo "Cloning source repository..."
        git clone "$SOURCE_PATH" "Sinha2016"

        pushd "Sinha2016"
            echo "Checking out commit $GIT_COMMIT..."
            git checkout -b this_sim "$GIT_COMMIT"
            if [ "$?" -ne 0 ]
            then
                echo "Error occured. Could not checkout $GIT_COMMIT. Exiting..."
                ERROR="yes"
            fi
        popd

        if [ "xyes" ==  x"$ERROR" ]
        then
            exit -1
        fi

        RUN_NEW="nest_""$GIT_COMMIT"".sh"
        echo "Setting up $RUN_NEW..."
        cp "$SCRIPT_PATH""$RUN_SCRIPT" "$RUN_NEW" -v
        sed -i "s|nest_v_s|nest_$GIT_COMMIT|" "$RUN_NEW"
        if [[ 0 -eq "$NUM_PROCS" ]]
        then
            sed -i "s|nodes=.*|nodes=$NUM_NODES|" "$RUN_NEW"
        else
            sed -i "s|nodes=.*|nodes=$NUM_NODES:ppn=$NUM_PROCS|" "$RUN_NEW"
        fi
        sed -i "s|NUM_MPI_NODES=.*|NUM_MPI_NODES=$NUM_MPI_NODES|" "$RUN_NEW"
        sed -i "s|walltime=.*|walltime=$WALLTIME|" "$RUN_NEW"
        sed -i "s|SIM_TIME=.*|SIM_TIME=$SIM_TIME|" "$RUN_NEW"
        sed -i "s|MODULE_TO_USE=.*|MODULE_TO_USE=$MODULE_TO_USE|" "$RUN_NEW"

        mkdir -v result
        pushd "Sinha2016"
            git show > ../result/"00-GIT-COMMIT-""$GIT_COMMIT"
        popd

        mkdir -v result/consolidated_files/
    popd
}

function usage
{
    echo "Usage: $0"
    echo "Queue up a job to run a particular git commit"
    echo "$0 OPTIONS"
    echo ""
    echo "OPTIONS:"
    echo "-g <git commit>"
    echo "-n <number of nodes>"
    echo "-p <number of processors per node>"
    echo "   use zero to not use ppn"
    echo "-w <requested walltime>"
    echo "-m <module to use>"

}

if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

while getopts "g:n:p:w:m:h" OPTION
do
    case $OPTION in
        g)
            GIT_COMMIT="$OPTARG"
            ;;
        n)
            NUM_NODES="$OPTARG"
            ;;
        p)
            NUM_PROCS="$OPTARG"
            ;;
        w)
            WALLTIME="$OPTARG"
            ;;
        m)
            MODULE_TO_USE="$OPTARG"
            ;;
        h)
            usage
            exit 0
            ;;
        ?)
            usage
            exit 0
            ;;
    esac
done

if [[ "x" == x"$MODULE_TO_USE" ]]
then
    echo "You must choose an environment module."
    echo
    usage
    exit -1
fi

if [[ "x" == x"$GIT_COMMIT" ]]
then
    echo "You must choose a git commit to run."
    echo
    usage
    exit -1
fi

if [[ 0 -eq "$NUM_PROCS" ]]
then
    echo "Num procs not specified, using nodes as total number."
    NUM_MPI_NODES="$NUM_NODES"
else
    NUM_MPI_NODES=$((NUM_NODES*NUM_PROCS))
fi

setup_env
queue_task

exit 0
