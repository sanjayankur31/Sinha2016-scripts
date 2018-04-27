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
    montage \
        "$PREFIX"growth-curves-E.png \
        "$PREFIX"growth-curves-I.png \
        "$PREFIX"growth-curves-elements-E.png \
        "$PREFIX"growth-curves-elements-I.png \
        "$PREFIX"02-calcium-lpz_c_E.png \
        "$PREFIX"02-calcium-lpz_b_E.png \
        "$PREFIX"02-calcium-p_lpz_E.png \
        "$PREFIX"02-calcium-o_E.png \
        "$PREFIX"05-se-lpz_c_E-all.png \
        "$PREFIX"05-se-lpz_b_E-all.png \
        "$PREFIX"05-se-p_lpz_E-all.png \
        "$PREFIX"05-se-o_E-all.png \
        "$PREFIX"081-connection-histograms-lpz_c.png \
        "$PREFIX"081-connection-histograms-lpz_b.png \
        "$PREFIX"081-connection-histograms-p_lpz.png \
        "$PREFIX"081-connection-histograms-o.png \
        "$PREFIX"08-syn_conns-E-to-lpz_c_E.png \
        "$PREFIX"08-syn_conns-E-to-lpz_b_E.png \
        "$PREFIX"08-syn_conns-E-to-p_lpz_E.png \
        "$PREFIX"08-syn_conns-E-to-o_E.png \
        "$PREFIX"08-syn_conns-I-to-lpz_c_E.png \
        "$PREFIX"08-syn_conns-I-to-lpz_b_E.png \
        "$PREFIX"08-syn_conns-I-to-p_lpz_E.png \
        "$PREFIX"08-syn_conns-I-to-o_E.png \
        -tile 4x6 -geometry +2+2  "$PREFIX"structural-plasticity-montage-E.png

    montage \
        "$PREFIX"growth-curves-E.png \
        "$PREFIX"growth-curves-I.png \
        "$PREFIX"growth-curves-elements-E.png \
        "$PREFIX"growth-curves-elements-I.png \
        "$PREFIX"02-calcium-lpz_c_I.png \
        "$PREFIX"02-calcium-lpz_b_I.png \
        "$PREFIX"02-calcium-p_lpz_I.png \
        "$PREFIX"02-calcium-o_I.png \
        "$PREFIX"05-se-lpz_c_I-all.png \
        "$PREFIX"05-se-lpz_b_I-all.png \
        "$PREFIX"05-se-p_lpz_I-all.png \
        "$PREFIX"05-se-o_I-all.png \
        "$PREFIX"081-connection-histograms-lpz_c.png \
        "$PREFIX"081-connection-histograms-lpz_b.png \
        "$PREFIX"081-connection-histograms-p_lpz.png \
        "$PREFIX"081-connection-histograms-o.png \
        "$PREFIX"08-syn_conns-E-to-lpz_c_I.png \
        "$PREFIX"08-syn_conns-E-to-lpz_b_I.png \
        "$PREFIX"08-syn_conns-E-to-p_lpz_I.png \
        "$PREFIX"08-syn_conns-E-to-o_I.png \
        "$PREFIX"08-syn_conns-I-to-lpz_c_I.png \
        "$PREFIX"08-syn_conns-I-to-lpz_b_I.png \
        "$PREFIX"08-syn_conns-I-to-p_lpz_I.png \
        "$PREFIX"08-syn_conns-I-to-o_I.png \
        -tile 4x6 -geometry +2+2  "$PREFIX"structural-plasticity-montage-I.png
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
