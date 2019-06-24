#!/bin/bash

# Copyright 2019 Ankur Sinha 
# Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com> 
# File : start-nest-job.sh
#
# Queue's up a new nest job for me.

SOURCE_PATH="/home/asinha/Documents/02_Code/00_mine/Sinha2016/"
SCRIPT_PATH="/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/"
GIT_COMMIT=""
SIM_PATH="/simulation-drive/"
SIM_TIME=$(date +%Y%m%d%H%M)
RUN_SCRIPT="mac/nest-runsim.sh"
RUN_NEW=""
ERROR="no"
NUM_NODES=50
CUR_SIM_PATH=""

function run_task
{
    pushd "$CUR_SIM_PATH"
        sh "$RUN_NEW"
    popd
}

function setup_env
{
    CUR_SIM_PATH="$SIM_PATH""$SIM_TIME"
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
        sed -i "s|nodes=.*|nodes=$NUM_NODES|" "$RUN_NEW"
        sed -i "s|NUM_NODES=.*|NUM_NODES=$NUM_NODES|" "$RUN_NEW"
        sed -i "s|SIM_TIME=.*|SIM_TIME=$SIM_TIME|" "$RUN_NEW"

        mkdir -v result
        pushd "Sinha2016"
            git show > ../result/"00-GIT-COMMIT-""$GIT_COMMIT"
        popd

        mkdir -v result/consolidated_files/
        cp -v "$SCRIPT_PATH/config.ini" result/consolidated_files/
    popd
}

function usage
{
    echo "Usage: $0"
    echo "Queue up a job to run a particular git commit"
    echo "$0 <git_commit> <number_nodes>"
}

if [ "$#" -ne 2 ];
then
    echo "Error occurred. Exiting..."
    echo "Received $# arguments. Expected: 2"
    usage
    exit -1
fi

GIT_COMMIT="$1"
NUM_NODES="$2"
setup_env
run_task

exit 0
