#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs of initial connectivity

IDENTIFIER=""

usage()
{
    echo "make-montage-initial-connectivity.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$IDENTIFIER"02-calcium-lpz_c_E.png \
        "$IDENTIFIER"02-calcium-lpz_b_E.png \
        "$IDENTIFIER"02-calcium-p_lpz_E.png \
        "$IDENTIFIER"02-calcium-o_E.png \
        "$IDENTIFIER"08-syn_conns-E-to-lpz_c_E.png \
        "$IDENTIFIER"08-syn_conns-E-to-lpz_b_E.png \
        "$IDENTIFIER"08-syn_conns-E-to-p_lpz_E.png \
        "$IDENTIFIER"08-syn_conns-E-to-o_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-lpz_c_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-lpz_b_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-p_lpz_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-o_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-lpz_c_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-lpz_b_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-p_lpz_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-o_E.png \
        "$IDENTIFIER"08-syn_conns-I-to-lpz_c_E.png \
        "$IDENTIFIER"08-syn_conns-I-to-lpz_b_E.png \
        "$IDENTIFIER"08-syn_conns-I-to-p_lpz_E.png \
        "$IDENTIFIER"08-syn_conns-I-to-o_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-lpz_c_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-lpz_b_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-p_lpz_E.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-o_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-lpz_c_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-lpz_b_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-p_lpz_E.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-o_E.png \
        -tile 4x7 -geometry +2+2  "$IDENTIFIER"75-connections-E-montage.png

    montage \
        "$IDENTIFIER"02-calcium-lpz_c_I.png \
        "$IDENTIFIER"02-calcium-lpz_b_I.png \
        "$IDENTIFIER"02-calcium-p_lpz_I.png \
        "$IDENTIFIER"02-calcium-o_I.png \
        "$IDENTIFIER"08-syn_conns-E-to-lpz_c_I.png \
        "$IDENTIFIER"08-syn_conns-E-to-lpz_b_I.png \
        "$IDENTIFIER"08-syn_conns-E-to-p_lpz_I.png \
        "$IDENTIFIER"08-syn_conns-E-to-o_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-lpz_c_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-lpz_b_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-p_lpz_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-E-to-o_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-lpz_c_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-lpz_b_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-p_lpz_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-E-to-o_I.png \
        "$IDENTIFIER"08-syn_conns-I-to-lpz_c_I.png \
        "$IDENTIFIER"08-syn_conns-I-to-lpz_b_I.png \
        "$IDENTIFIER"08-syn_conns-I-to-p_lpz_I.png \
        "$IDENTIFIER"08-syn_conns-I-to-o_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-lpz_c_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-lpz_b_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-p_lpz_I.png \
        "$IDENTIFIER"081-connection-clustered-histograms-I-to-o_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-lpz_c_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-lpz_b_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-p_lpz_I.png \
        "$IDENTIFIER"081-connection-rowstacked-histograms-I-to-o_I.png \
        -tile 4x7 -geometry +2+2  "$IDENTIFIER"75-connections-I-montage.png

    # Get the number of columns we have. One column for each time.
    COLS=$(ls -- *75-connections-hist-EE*in.png | wc -l)

    montage \
        "$IDENTIFIER"75-connections-hist-EE-*-in.png \
        "$IDENTIFIER"75-connections-hist-IE-*-in.png \
        "$IDENTIFIER"75-connections-hist-EI-*-in.png \
        "$IDENTIFIER"75-connections-hist-II-*-in.png \
        -tile "$COLS"x4 -geometry +2+2 "$IDENTIFIER"75-connections-in-time-lapse-hist-montage.png

    montage \
        "$IDENTIFIER"75-connections-hist-EE-*-out.png \
        "$IDENTIFIER"75-connections-hist-IE-*-out.png \
        "$IDENTIFIER"75-connections-hist-EI-*-out.png \
        "$IDENTIFIER"75-connections-hist-II-*-out.png \
        -tile "$COLS"x4 -geometry +2+2 "$IDENTIFIER"75-connections-out-time-lapse-hist-montage.png

    for REGION in "lpz_c_E" "lpz_b_E" "p_lpz_E" "o_E";
    do
        montage \
            "$IDENTIFIER"75-conns-top-EE-"$REGION"-*-in.png \
            "$IDENTIFIER"75-conns-top-EE-"$REGION"-*-out.png \
            "$IDENTIFIER"75-conns-top-IE-"$REGION"-*-in.png \
            "$IDENTIFIER"75-conns-top-EI-"$REGION"-*-out.png \
            -tile "$COLS"x4 -geometry +2+2 "$IDENTIFIER"75-connections-E-"$REGION"-time-top-montage.png
    done

    for REGION in "lpz_c_I" "lpz_b_I" "p_lpz_I" "o_I";
    do
        montage \
            "$IDENTIFIER"75-conns-top-II-"$REGION"-*-out.png \
            "$IDENTIFIER"75-conns-top-II-"$REGION"-*-out.png \
            "$IDENTIFIER"75-conns-top-EI-"$REGION"-*-in.png \
            "$IDENTIFIER"75-conns-top-IE-"$REGION"-*-out.png \
            -tile "$COLS"x4 -geometry +2+2 "$IDENTIFIER"75-connections-I-"$REGION"-time-top-montage.png
    done
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
