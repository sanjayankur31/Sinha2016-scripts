#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs of conductances.

IDENTIFIER=""

usage()
{
    echo "make-montage-initial-conductances.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$IDENTIFIER"02-calcium-lpz_c_E.png \
        "$IDENTIFIER"02-calcium-lpz_b_E.png \
        "$IDENTIFIER"02-calcium-p_lpz_E.png \
        "$IDENTIFIER"02-calcium-o_E.png \
        "$IDENTIFIER"08-total-conductances-E-to-lpz_c_E.png \
        "$IDENTIFIER"08-total-conductances-E-to-lpz_b_E.png \
        "$IDENTIFIER"08-total-conductances-E-to-p_lpz_E.png \
        "$IDENTIFIER"08-total-conductances-E-to-o_E.png \
        "$IDENTIFIER"08-total-conductances-I-to-lpz_c_E.png \
        "$IDENTIFIER"08-total-conductances-I-to-lpz_b_E.png \
        "$IDENTIFIER"08-total-conductances-I-to-p_lpz_E.png \
        "$IDENTIFIER"08-total-conductances-I-to-o_E.png \
        "$IDENTIFIER"08-mean-conductances-E-to-lpz_c_E.png \
        "$IDENTIFIER"08-mean-conductances-E-to-lpz_b_E.png \
        "$IDENTIFIER"08-mean-conductances-E-to-p_lpz_E.png \
        "$IDENTIFIER"08-mean-conductances-E-to-o_E.png \
        "$IDENTIFIER"08-mean-conductances-I-to-lpz_c_E.png \
        "$IDENTIFIER"08-mean-conductances-I-to-lpz_b_E.png \
        "$IDENTIFIER"08-mean-conductances-I-to-p_lpz_E.png \
        "$IDENTIFIER"08-mean-conductances-I-to-o_E.png \
        -tile 4x5 -geometry +2+2  "$IDENTIFIER"75-conductances-E-montage.png

    montage \
        "$IDENTIFIER"02-calcium-lpz_c_I.png \
        "$IDENTIFIER"02-calcium-lpz_b_I.png \
        "$IDENTIFIER"02-calcium-p_lpz_I.png \
        "$IDENTIFIER"02-calcium-o_I.png \
        "$IDENTIFIER"08-total-conductances-E-to-lpz_c_I.png \
        "$IDENTIFIER"08-total-conductances-E-to-lpz_b_I.png \
        "$IDENTIFIER"08-total-conductances-E-to-p_lpz_I.png \
        "$IDENTIFIER"08-total-conductances-E-to-o_I.png \
        "$IDENTIFIER"08-total-conductances-I-to-lpz_c_I.png \
        "$IDENTIFIER"08-total-conductances-I-to-lpz_b_I.png \
        "$IDENTIFIER"08-total-conductances-I-to-p_lpz_I.png \
        "$IDENTIFIER"08-total-conductances-I-to-o_I.png \
        "$IDENTIFIER"08-mean-conductances-E-to-lpz_c_I.png \
        "$IDENTIFIER"08-mean-conductances-E-to-lpz_b_I.png \
        "$IDENTIFIER"08-mean-conductances-E-to-p_lpz_I.png \
        "$IDENTIFIER"08-mean-conductances-E-to-o_I.png \
        "$IDENTIFIER"08-mean-conductances-I-to-lpz_c_I.png \
        "$IDENTIFIER"08-mean-conductances-I-to-lpz_b_I.png \
        "$IDENTIFIER"08-mean-conductances-I-to-p_lpz_I.png \
        "$IDENTIFIER"08-mean-conductances-I-to-o_I.png \
        -tile 4x5 -geometry +2+2  "$IDENTIFIER"75-conductances-I-montage.png

    montage \
        "$IDENTIFIER"02-calcium-lpz_c_E.png \
        "$IDENTIFIER"02-calcium-lpz_b_E.png \
        "$IDENTIFIER"02-calcium-p_lpz_E.png \
        "$IDENTIFIER"02-calcium-o_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-lpz_c_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-lpz_b_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-p_lpz_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-o_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-lpz_c_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-lpz_b_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-p_lpz_E.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-o_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-lpz_c_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-lpz_b_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-p_lpz_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-o_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-lpz_c_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-lpz_b_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-p_lpz_E.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-o_E.png \
        -tile 4x5 -geometry +2+2  "$IDENTIFIER"75-conductances-histograms-E-montage.png

    montage \
        "$IDENTIFIER"02-calcium-lpz_c_I.png \
        "$IDENTIFIER"02-calcium-lpz_b_I.png \
        "$IDENTIFIER"02-calcium-p_lpz_I.png \
        "$IDENTIFIER"02-calcium-o_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-lpz_c_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-lpz_b_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-p_lpz_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-E-to-o_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-lpz_c_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-lpz_b_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-p_lpz_I.png \
        "$IDENTIFIER"081-conductance-clustered-histograms-I-to-o_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-lpz_c_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-lpz_b_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-p_lpz_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-E-to-o_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-lpz_c_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-lpz_b_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-p_lpz_I.png \
        "$IDENTIFIER"081-conductance-rowstacked-histograms-I-to-o_I.png \
        -tile 4x5 -geometry +2+2  "$IDENTIFIER"75-conductances-histograms-I-montage.png

    montage \
        "$IDENTIFIER"02-calcium-lpz_c_E.png \
        "$IDENTIFIER"02-calcium-lpz_b_E.png \
        "$IDENTIFIER"02-calcium-p_lpz_E.png \
        "$IDENTIFIER"02-calcium-o_E.png \
        "$IDENTIFIER"08-net-regional-conductances-to-lpz_c_E.png \
        "$IDENTIFIER"08-net-regional-conductances-to-lpz_b_E.png \
        "$IDENTIFIER"08-net-regional-conductances-to-p_lpz_E.png \
        "$IDENTIFIER"08-net-regional-conductances-to-o_E.png \
        "$IDENTIFIER"08-net-conductances-to-lpz_c_E.png \
        "$IDENTIFIER"08-net-conductances-to-lpz_b_E.png \
        "$IDENTIFIER"08-net-conductances-to-p_lpz_E.png \
        "$IDENTIFIER"08-net-conductances-to-o_E.png \
        "$IDENTIFIER"08-net-conductances-slope-to-lpz_c_E.png \
        "$IDENTIFIER"08-net-conductances-slope-to-lpz_b_E.png \
        "$IDENTIFIER"08-net-conductances-slope-to-p_lpz_E.png \
        "$IDENTIFIER"08-net-conductances-slope-to-o_E.png \
        -tile 4x4 -geometry +2+2  "$IDENTIFIER"75-net-conductances-E-montage.png

    montage \
        "$IDENTIFIER"02-calcium-lpz_c_I.png \
        "$IDENTIFIER"02-calcium-lpz_b_I.png \
        "$IDENTIFIER"02-calcium-p_lpz_I.png \
        "$IDENTIFIER"02-calcium-o_I.png \
        "$IDENTIFIER"08-net-regional-conductances-to-lpz_c_I.png \
        "$IDENTIFIER"08-net-regional-conductances-to-lpz_b_I.png \
        "$IDENTIFIER"08-net-regional-conductances-to-p_lpz_I.png \
        "$IDENTIFIER"08-net-regional-conductances-to-o_I.png \
        "$IDENTIFIER"08-net-conductances-to-lpz_c_I.png \
        "$IDENTIFIER"08-net-conductances-to-lpz_b_I.png \
        "$IDENTIFIER"08-net-conductances-to-p_lpz_I.png \
        "$IDENTIFIER"08-net-conductances-to-o_I.png \
        "$IDENTIFIER"08-net-conductances-slope-to-lpz_c_I.png \
        "$IDENTIFIER"08-net-conductances-slope-to-lpz_b_I.png \
        "$IDENTIFIER"08-net-conductances-slope-to-p_lpz_I.png \
        "$IDENTIFIER"08-net-conductances-slope-to-o_I.png \
        -tile 4x4 -geometry +2+2  "$IDENTIFIER"75-net-conductances-I-montage.png
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
