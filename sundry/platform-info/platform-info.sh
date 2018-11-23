#!/bin/bash
# Gather platform information something like
# http://rescience.github.io/platform/

get_machine_info ()
{
    echo "Machine/platform"
    head -n 6 /etc/os-release
    echo

    echo "Kernel"
    uname -mosv
    echo

    echo "GCC:"
    gcc --version | head -n 1
    echo

    echo "Compiler flags:"
    rpm -E '%{optflags}'
    echo

    echo "Python:"
    python3 -c 'import sys; print(sys.version);'
    echo

    echo "NumPy:"
    python3 -c 'import numpy; print(numpy.version.version);'
    echo
}


get_info_sim ()
{
    echo "** Platform information for simulation run:"
    module load nest-mvapich2-upstream
    echo

    echo "** This work has made use of the University of Hertfordshire's high-performance computing facility at http://uhhpc.herts.ac.uk/"
    get_machine_info
    echo

    echo "NEST:"
    python3 -c 'import nest; print(nest.version());' 2>&1 | grep "^NEST"
    echo

    echo "MPI:"
    python3 -c 'import mpi4py; print(mpi4py.get_config());'
    echo

    module unload nest-mvapich2-upstream
}

get_info_pp()
{
    echo "Platform information for simulation analysis:"
    echo

    get_machine_info

    echo "sort:"
    sort --version | head -n 1
    echo

    echo "GNUPLOT:"
    gnuplot --version
    echo
}

usage ()
{
    cat << EOF
    usage: $0 OPTION

    OPTIONS:
    -h  Show this message and quit

    -s Get simulation platform information

    -p Get post-processing platform information
EOF
}


# check for options
if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

# parse options
while getopts "sph" OPTION
do
    case $OPTION in
        s)
            get_info_sim
            ;;
        p)
            get_info_pp
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
