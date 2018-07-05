#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs of conductances.

PREFIX=""

usage()
{
    echo "make-montage-initial-conductances.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$PREFIX"02-calcium-lpz_c_E.png \
        "$PREFIX"02-calcium-lpz_b_E.png \
        "$PREFIX"02-calcium-p_lpz_E.png \
        "$PREFIX"02-calcium-o_E.png \
        "$PREFIX"08-total-conductances-E-to-lpz_c_E.png \
        "$PREFIX"08-total-conductances-E-to-lpz_b_E.png \
        "$PREFIX"08-total-conductances-E-to-p_lpz_E.png \
        "$PREFIX"08-total-conductances-E-to-o_E.png \
        "$PREFIX"08-mean-conductances-E-to-lpz_c_E.png \
        "$PREFIX"08-mean-conductances-E-to-lpz_b_E.png \
        "$PREFIX"08-mean-conductances-E-to-p_lpz_E.png \
        "$PREFIX"08-mean-conductances-E-to-o_E.png \
        "$PREFIX"08-total-conductances-I-to-lpz_c_E.png \
        "$PREFIX"08-total-conductances-I-to-lpz_b_E.png \
        "$PREFIX"08-total-conductances-I-to-p_lpz_E.png \
        "$PREFIX"08-total-conductances-I-to-o_E.png \
        "$PREFIX"08-mean-conductances-I-to-lpz_c_E.png \
        "$PREFIX"08-mean-conductances-I-to-lpz_b_E.png \
        "$PREFIX"08-mean-conductances-I-to-p_lpz_E.png \
        "$PREFIX"08-mean-conductances-I-to-o_E.png \
        -tile 4x5 -geometry +2+2  "$PREFIX"75-conductances-E-montage.png

    montage \
        "$PREFIX"02-calcium-lpz_c_I.png \
        "$PREFIX"02-calcium-lpz_b_I.png \
        "$PREFIX"02-calcium-p_lpz_I.png \
        "$PREFIX"02-calcium-o_I.png \
        "$PREFIX"08-total-conductances-E-to-lpz_c_I.png \
        "$PREFIX"08-total-conductances-E-to-lpz_b_I.png \
        "$PREFIX"08-total-conductances-E-to-p_lpz_I.png \
        "$PREFIX"08-total-conductances-E-to-o_I.png \
        "$PREFIX"08-mean-conductances-E-to-lpz_c_I.png \
        "$PREFIX"08-mean-conductances-E-to-lpz_b_I.png \
        "$PREFIX"08-mean-conductances-E-to-p_lpz_I.png \
        "$PREFIX"08-mean-conductances-E-to-o_I.png \
        "$PREFIX"08-total-conductances-I-to-lpz_c_I.png \
        "$PREFIX"08-total-conductances-I-to-lpz_b_I.png \
        "$PREFIX"08-total-conductances-I-to-p_lpz_I.png \
        "$PREFIX"08-total-conductances-I-to-o_I.png \
        "$PREFIX"08-mean-conductances-I-to-lpz_c_I.png \
        "$PREFIX"08-mean-conductances-I-to-lpz_b_I.png \
        "$PREFIX"08-mean-conductances-I-to-p_lpz_I.png \
        "$PREFIX"08-mean-conductances-I-to-o_I.png \
        -tile 4x5 -geometry +2+2  "$PREFIX"75-conductances-I-montage.png

    montage \
        "$PREFIX"02-calcium-lpz_c_E.png \
        "$PREFIX"02-calcium-lpz_b_E.png \
        "$PREFIX"02-calcium-p_lpz_E.png \
        "$PREFIX"02-calcium-o_E.png \
        "$PREFIX"08-total-conductances-E-to-lpz_c_E.png \
        "$PREFIX"08-total-conductances-E-to-lpz_b_E.png \
        "$PREFIX"08-total-conductances-E-to-p_lpz_E.png \
        "$PREFIX"08-total-conductances-E-to-o_E.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-lpz_c_E.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-lpz_b_E.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-p_lpz_E.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-o_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-lpz_c_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-lpz_b_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-p_lpz_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-o_E.png \
        "$PREFIX"08-total-conductances-I-to-lpz_c_E.png \
        "$PREFIX"08-total-conductances-I-to-lpz_b_E.png \
        "$PREFIX"08-total-conductances-I-to-p_lpz_E.png \
        "$PREFIX"08-total-conductances-I-to-o_E.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-lpz_c_E.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-lpz_b_E.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-p_lpz_E.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-o_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-lpz_c_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-lpz_b_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-p_lpz_E.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-o_E.png \
        -tile 4x7 -geometry +2+2  "$PREFIX"75-conductances-E-montage.png

    montage \
        "$PREFIX"02-calcium-lpz_c_I.png \
        "$PREFIX"02-calcium-lpz_b_I.png \
        "$PREFIX"02-calcium-p_lpz_I.png \
        "$PREFIX"02-calcium-o_I.png \
        "$PREFIX"08-total-conductances-E-to-lpz_c_I.png \
        "$PREFIX"08-total-conductances-E-to-lpz_b_I.png \
        "$PREFIX"08-total-conductances-E-to-p_lpz_I.png \
        "$PREFIX"08-total-conductances-E-to-o_I.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-lpz_c_I.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-lpz_b_I.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-p_lpz_I.png \
        "$PREFIX"081-conductance-clustered-histograms-E-to-o_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-lpz_c_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-lpz_b_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-p_lpz_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-E-to-o_I.png \
        "$PREFIX"08-total-conductances-I-to-lpz_c_I.png \
        "$PREFIX"08-total-conductances-I-to-lpz_b_I.png \
        "$PREFIX"08-total-conductances-I-to-p_lpz_I.png \
        "$PREFIX"08-total-conductances-I-to-o_I.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-lpz_c_I.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-lpz_b_I.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-p_lpz_I.png \
        "$PREFIX"081-conductance-clustered-histograms-I-to-o_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-lpz_c_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-lpz_b_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-p_lpz_I.png \
        "$PREFIX"081-conductance-rowstacked-histograms-I-to-o_I.png \
        -tile 4x7 -geometry +2+2  "$PREFIX"75-conductances-I-montage.png
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
