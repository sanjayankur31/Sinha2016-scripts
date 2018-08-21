#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs to do with structural plasticity
# This version skips the conductance graphs that may not be generated when the
# simulation did not complete.

IDENTIFIER=""

usage()
{
    echo "make-montage-structural-graphs-no-conductance.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    echo "$IDENTIFIER Generating structural plasticity montages"
    montage \
        "$IDENTIFIER"growth-curves-E.png \
        "$IDENTIFIER"growth-curves-I.png \
        "$IDENTIFIER"growth-curves-elements-E.png \
        "$IDENTIFIER"growth-curves-elements-I.png \
        "$IDENTIFIER"02-calcium-lpz_c_E.png \
        "$IDENTIFIER"02-calcium-lpz_b_E.png \
        "$IDENTIFIER"02-calcium-p_lpz_E.png \
        "$IDENTIFIER"02-calcium-o_E.png \
        "$IDENTIFIER"05-se-all-lpz_c_E.png \
        "$IDENTIFIER"05-se-all-lpz_b_E.png \
        "$IDENTIFIER"05-se-all-p_lpz_E.png \
        "$IDENTIFIER"05-se-all-o_E.png \
        -tile 4x3 -geometry +2+2  "$IDENTIFIER"structural-plasticity-montage-E.png

    montage \
        "$IDENTIFIER"growth-curves-E.png \
        "$IDENTIFIER"growth-curves-I.png \
        "$IDENTIFIER"growth-curves-elements-E.png \
        "$IDENTIFIER"growth-curves-elements-I.png \
        "$IDENTIFIER"02-calcium-lpz_c_I.png \
        "$IDENTIFIER"02-calcium-lpz_b_I.png \
        "$IDENTIFIER"02-calcium-p_lpz_I.png \
        "$IDENTIFIER"02-calcium-o_I.png \
        "$IDENTIFIER"05-se-all-lpz_c_I.png \
        "$IDENTIFIER"05-se-all-lpz_b_I.png \
        "$IDENTIFIER"05-se-all-p_lpz_I.png \
        "$IDENTIFIER"05-se-all-o_I.png \
        -tile 4x3 -geometry +2+2  "$IDENTIFIER"structural-plasticity-montage-I.png
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
            IDENTIFIER=$OPTARG
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
