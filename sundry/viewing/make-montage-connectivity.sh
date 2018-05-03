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
        "$PREFIX"02-calcium-lpz_c_E.png \
        "$PREFIX"02-calcium-lpz_b_E.png \
        "$PREFIX"02-calcium-p_lpz_E.png \
        "$PREFIX"02-calcium-o_E.png \
        "$PREFIX"08-syn_conns-E-to-lpz_c_E.png \
        "$PREFIX"08-syn_conns-E-to-lpz_b_E.png \
        "$PREFIX"08-syn_conns-E-to-p_lpz_E.png \
        "$PREFIX"08-syn_conns-E-to-o_E.png \
        "$PREFIX"08-syn_conns-I-to-lpz_c_E.png \
        "$PREFIX"08-syn_conns-I-to-lpz_b_E.png \
        "$PREFIX"08-syn_conns-I-to-p_lpz_E.png \
        "$PREFIX"08-syn_conns-I-to-o_E.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-lpz_c_E.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-lpz_b_E.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-p_lpz_E.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-o_E.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-lpz_c_E.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-lpz_b_E.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-p_lpz_E.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-o_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-lpz_c_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-lpz_b_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-p_lpz_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-o_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-lpz_c_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-lpz_b_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-p_lpz_E.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-o_E.png \
        -tile 4x7 -geometry +2+2  "$PREFIX"75-connections-E-montage.png

    montage \
        "$PREFIX"02-calcium-lpz_c_I.png \
        "$PREFIX"02-calcium-lpz_b_I.png \
        "$PREFIX"02-calcium-p_lpz_I.png \
        "$PREFIX"02-calcium-o_I.png \
        "$PREFIX"08-syn_conns-E-to-lpz_c_I.png \
        "$PREFIX"08-syn_conns-E-to-lpz_b_I.png \
        "$PREFIX"08-syn_conns-E-to-p_lpz_I.png \
        "$PREFIX"08-syn_conns-E-to-o_I.png \
        "$PREFIX"08-syn_conns-I-to-lpz_c_I.png \
        "$PREFIX"08-syn_conns-I-to-lpz_b_I.png \
        "$PREFIX"08-syn_conns-I-to-p_lpz_I.png \
        "$PREFIX"08-syn_conns-I-to-o_I.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-lpz_c_I.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-lpz_b_I.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-p_lpz_I.png \
        "$PREFIX"081-connection-clustered-histograms-E-to-o_I.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-lpz_c_I.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-lpz_b_I.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-p_lpz_I.png \
        "$PREFIX"081-connection-clustered-histograms-I-to-o_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-lpz_c_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-lpz_b_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-p_lpz_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-E-to-o_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-lpz_c_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-lpz_b_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-p_lpz_I.png \
        "$PREFIX"081-connection-rowstacked-histograms-I-to-o_I.png \
        -tile 4x7 -geometry +2+2  "$PREFIX"75-connections-I-montage.png

    # Get the number of columns we have. One column for each time.
    COLS=$(ls -- *75-connections-hist-EE*incoming.png | wc -l)

    montage \
        "$PREFIX"75-connections-hist-EE-*-incoming.png \
        "$PREFIX"75-connections-hist-IE-*-incoming.png \
        "$PREFIX"75-connections-hist-EI-*-incoming.png \
        "$PREFIX"75-connections-hist-II-*-incoming.png \
        -tile "$COLS"x4 -geometry +2+2 "$PREFIX"75-connections-incoming-time-lapse-hist-montage.png

    montage \
        "$PREFIX"75-connections-top-EE-*-incoming.png \
        "$PREFIX"75-connections-top-IE-*-incoming.png \
        "$PREFIX"75-connections-top-EI-*-incoming.png \
        "$PREFIX"75-connections-top-II-*-incoming.png \
        -tile "$COLS"x4 -geometry +2+2 "$PREFIX"75-connections-incoming-time-lapse-top-montage.png

    montage \
        "$PREFIX"75-connections-hist-EE-*-outgoing.png \
        "$PREFIX"75-connections-hist-IE-*-outgoing.png \
        "$PREFIX"75-connections-hist-EI-*-outgoing.png \
        "$PREFIX"75-connections-hist-II-*-outgoing.png \
        -tile "$COLS"x4 -geometry +2+2 "$PREFIX"75-connections-outgoing-time-lapse-hist-montage.png

    montage \
        "$PREFIX"75-connections-top-EE-*-outgoing.png \
        "$PREFIX"75-connections-top-IE-*-outgoing.png \
        "$PREFIX"75-connections-top-EI-*-outgoing.png \
        "$PREFIX"75-connections-top-II-*-outgoing.png \
        -tile "$COLS"x4 -geometry +2+2 "$PREFIX"75-connections-outgoing-time-lapse-top-montage.png
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
