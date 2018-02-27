#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs of initial connectivity

PREFIX=""

usage()
{
    echo "make-montage-initial-connectivity.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$PREFIX"75-initial-connections-top-EE-incoming.png \
        "$PREFIX"Grid-plot-lpz_c_E-lpz_b_E-p_lpz_E-o_E.png \
        "$PREFIX"75-initial-connections-top-EE-outgoing.png \
        "$PREFIX"Grid-plot-lpz_c_E-lpz_b_E-p_lpz_E-o_E.png \
        "$PREFIX"75-initial-connections-top-EI-incoming.png \
        "$PREFIX"Grid-plot-lpz_c_I-lpz_b_I-p_lpz_I-o_I.png \
        "$PREFIX"75-initial-connections-top-EI-outgoing.png \
        "$PREFIX"Grid-plot-lpz_c_E-lpz_b_E-p_lpz_E-o_E.png \
        "$PREFIX"75-initial-connections-top-IE-incoming.png \
        "$PREFIX"Grid-plot-lpz_c_E-lpz_b_E-p_lpz_E-o_E.png \
        "$PREFIX"75-initial-connections-top-IE-outgoing.png \
        "$PREFIX"Grid-plot-lpz_c_I-lpz_b_I-p_lpz_I-o_I.png \
        "$PREFIX"75-initial-connections-top-II-incoming.png \
        "$PREFIX"Grid-plot-lpz_c_I-lpz_b_I-p_lpz_I-o_I.png \
        "$PREFIX"75-initial-connections-top-II-outgoing.png \
        "$PREFIX"Grid-plot-lpz_c_I-lpz_b_I-p_lpz_I-o_I.png \
        -tile 4x4 -geometry +2+2  "$PREFIX"75-initial-connections-montage.png
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
