#!/bin/bash

# Copyright 2019 Ankur Sinha
# Author: Ankur Sinha <sanjay DOT ankur AT gmail DOT com>
# File : nest-runsim.sh
#

#PBS -l walltime=48:00:00
#PBS -l nodes=4:ppn=32
#PBS -m abe
#PBS -N nest_v_s

module unload mpi/mpich-x86_64
module load mvapich2-1.7

SIM_PATH="/beegfs/general/asinha/simulations-nest/"
SIM_TIME=""
PROGRAM_PATH="$SIM_PATH""$SIM_TIME""/Sinha2016/src/Sinha2016.py"
RESULT_PATH="$SIM_PATH""$SIM_TIME""/result/"
NUM_MPI_NODES=128
MODULE_TO_USE=

echo ------------------------------------------------------
echo 'Job is running on nodes'; cat $PBS_NODEFILE
echo ------------------------------------------------------
echo PBS: qsub is running on $PBS_O_HOST
echo PBS: originating queue is $PBS_O_QUEUE
echo PBS: executing queue is $PBS_QUEUE
echo PBS: working directory is $PBS_O_WORKDIR
echo PBS: execution mode is $PBS_ENVIRONMENT
echo PBS: job identifier is $PBS_JOBID
echo PBS: job name is $PBS_JOBNAME
echo PBS: node file is $PBS_NODEFILE
echo PBS: current home directory is $PBS_O_HOME
echo PBS: PATH = $PBS_O_PATH
echo ------------------------------------------------------

echo "ANKUR>> Begun at $SIM_TIME"
echo "ANKUR>> Script: ${0}"
module load "$MODULE_TO_USE"

cd $RESULT_PATH

mpiexec -n $NUM_MPI_NODES -v python3 $PROGRAM_PATH

module unload "$MODULE_TO_USE"
END_TIME=$(date +%Y%m%d%H%M)
echo "ANKUR>> Ended at $END_TIME"
