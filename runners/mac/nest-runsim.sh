#!/bin/bash

# Copyright 2019 Ankur Sinha 
# Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com> 
# File : nest-runsim.sh
#

SIM_PATH="/simulation-drive/"
SIM_TIME=""
PROGRAM_PATH="$SIM_PATH""$SIM_TIME""/Sinha2016/src/Sinha2016.py"
RESULT_PATH="$SIM_PATH""$SIM_TIME""/result/"
NUM_NODES=24

echo "ANKUR>> Begun at $SIM_TIME"
echo "ANKUR>> Script: ${0}"

cd $RESULT_PATH

mpiexec -n $NUM_NODES python3 $PROGRAM_PATH

END_TIME=$(date +%Y%m%d%H%M)
echo "ANKUR>> Ended at $END_TIME"
