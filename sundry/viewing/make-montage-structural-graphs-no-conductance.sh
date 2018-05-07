#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs to do with structural plasticity
# This version skips the conductance graphs that may not be generated when the
# simulation did not complete.

PREFIX=""

usage()
{
    echo "make-montage-structural-graphs-no-conductance.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    echo "$PREFIX Generating structural plasticity montages"
    montage \
        "$PREFIX"growth-curves-E.png \
        "$PREFIX"growth-curves-I.png \
        "$PREFIX"growth-curves-elements-E.png \
        "$PREFIX"growth-curves-elements-I.png \
        "$PREFIX"02-calcium-lpz_c_E.png \
        "$PREFIX"02-calcium-lpz_b_E.png \
        "$PREFIX"02-calcium-p_lpz_E.png \
        "$PREFIX"02-calcium-o_E.png \
        "$PREFIX"05-se-all-lpz_c_E.png \
        "$PREFIX"05-se-all-lpz_b_E.png \
        "$PREFIX"05-se-all-p_lpz_E.png \
        "$PREFIX"05-se-all-o_E.png \
        -tile 4x3 -geometry +2+2  "$PREFIX"structural-plasticity-montage-E.png

    montage \
        "$PREFIX"growth-curves-E.png \
        "$PREFIX"growth-curves-I.png \
        "$PREFIX"growth-curves-elements-E.png \
        "$PREFIX"growth-curves-elements-I.png \
        "$PREFIX"02-calcium-lpz_c_I.png \
        "$PREFIX"02-calcium-lpz_b_I.png \
        "$PREFIX"02-calcium-p_lpz_I.png \
        "$PREFIX"02-calcium-o_I.png \
        "$PREFIX"05-se-all-lpz_c_I.png \
        "$PREFIX"05-se-all-lpz_b_I.png \
        "$PREFIX"05-se-all-p_lpz_I.png \
        "$PREFIX"05-se-all-o_I.png \
        -tile 4x3 -geometry +2+2  "$PREFIX"structural-plasticity-montage-I.png
}



# check for options
if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

while getopts "y:h" OPTION
do
    case $OPTION in
        y)
            PREFIX=$OPTARG
            main
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
