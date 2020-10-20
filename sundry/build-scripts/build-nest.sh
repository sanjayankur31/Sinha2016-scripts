#!/bin/bash

# Copyright 2019 Ankur Sinha
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
# File : build-nest.sh
#

INSTALL_PATH=""
BRANCH=""
SOURCE_PATH="$HOME/software/nest-simulator/"

build_nest ()
{
    if [[ "$HOSTNAME" = "uhhpc.herts.ac.uk" ]] || [[ $HOSTNAME =~ headnode* ]] || [[ $HOSTNAME =~ ^(node)[0-9]+ ]] ; then
        rm -rf "$INSTALL_PATH"
        module load openmpi-4.0.5
        pushd "$SOURCE_PATH" || exit -1
            git clean -dfx
            git checkout "$BRANCH"
            CFLAGS="$(rpm -E '%optflags')"
            export CFLAGS
            CXXFLAGS="$(rpm -E '%optflags')"
            export CXXFLAGS
            cmake -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_PATH -Dwith-python:STRING=3 -Dwith-mpi:BOOL=ON  .

            echo "Running make:"
            make "$(rpm -E '%_smp_mflags')"
            make install

            echo "Installed NEST to $INSTALL_PATH. Installing mpi4py:"
            pip install --target="$INSTALL_PATH/lib64/python3.5/site-packages/" mpi4py
        popd || exit -1
        echo "Now, do: source /$INSTALL_PATH/bin/nest_vars.sh etc."
        echo "Also remember what module you must load!"

    else
        echo "I don't appear to be on the cluster. Not building."
        exit -1
    fi
}


usage ()
{
    echo "$0 OPTIONS"
    echo

    cat << EOF
OPTIONS
-u upstream version on cluster
-m my branch on cluster
EOF
}

# parse options
while getopts "muh" OPTION
do
    case $OPTION in
        u)
            INSTALL_PATH="$HOME/installed-software/nest-openmpi-upstream/"
            BRANCH="master"
            build_nest
            exit 0
            ;;
        m)
            INSTALL_PATH="$HOME/installed-software/nest-openmpi/"
            BRANCH="disable-str-pl-updates"
            build_nest
            exit 0
            ;;
        h)
            usage
            exit 1
            ;;
        ?)
            echo "Nothing to do."
            usage
            exit 1
            ;;
    esac
done
