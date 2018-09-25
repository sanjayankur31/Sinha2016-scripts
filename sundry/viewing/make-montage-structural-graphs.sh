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
        "$IDENTIFIER"growth-curves-E.png \
        "$IDENTIFIER"growth-curves-E.png \
        "$IDENTIFIER"growth-curves-E.png \
        "$IDENTIFIER"02-calcium-lpz_c_E.png \
        "$IDENTIFIER"02-calcium-lpz_b_E.png \
        "$IDENTIFIER"02-calcium-p_lpz_E.png \
        "$IDENTIFIER"02-calcium-o_E.png \
        "$IDENTIFIER"05-se-all-totals-lpz_c_E.png \
        "$IDENTIFIER"05-se-all-totals-lpz_b_E.png \
        "$IDENTIFIER"05-se-all-totals-p_lpz_E.png \
        "$IDENTIFIER"05-se-all-totals-o_E.png \
        "$IDENTIFIER"05-se-all-means-lpz_c_E.png \
        "$IDENTIFIER"05-se-all-means-lpz_b_E.png \
        "$IDENTIFIER"05-se-all-means-p_lpz_E.png \
        "$IDENTIFIER"05-se-all-means-o_E.png \
        -tile 4x4 -geometry +2+2  "$IDENTIFIER"structural-plasticity-montage-E.png

    montage \
        "$IDENTIFIER"growth-curves-I.png \
        "$IDENTIFIER"growth-curves-I.png \
        "$IDENTIFIER"growth-curves-I.png \
        "$IDENTIFIER"growth-curves-I.png \
        "$IDENTIFIER"02-calcium-lpz_c_I.png \
        "$IDENTIFIER"02-calcium-lpz_b_I.png \
        "$IDENTIFIER"02-calcium-p_lpz_I.png \
        "$IDENTIFIER"02-calcium-o_I.png \
        "$IDENTIFIER"05-se-all-totals-lpz_c_I.png \
        "$IDENTIFIER"05-se-all-totals-lpz_b_I.png \
        "$IDENTIFIER"05-se-all-totals-p_lpz_I.png \
        "$IDENTIFIER"05-se-all-totals-o_I.png \
        "$IDENTIFIER"05-se-all-means-lpz_c_I.png \
        "$IDENTIFIER"05-se-all-means-lpz_b_I.png \
        "$IDENTIFIER"05-se-all-means-p_lpz_I.png \
        "$IDENTIFIER"05-se-all-means-o_I.png \
        -tile 4x4 -geometry +2+2  "$IDENTIFIER"structural-plasticity-montage-I.png

    # Get the number of columns we have. One column for each time.
    COLS=$(ls -- *05-se-ax-total-I*.png | wc -l)
    montage \
        "$IDENTIFIER"05-se-ax-total-E*.png \
        "$IDENTIFIER"05-se-denE-total-E*.png \
        "$IDENTIFIER"05-se-denI-total-E*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-total-montage-E.png

    montage \
        "$IDENTIFIER"05-se-ax-con-E*.png \
        "$IDENTIFIER"05-se-denE-con-E*.png \
        "$IDENTIFIER"05-se-denI-con-E*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-con-montage-E.png

    montage \
        "$IDENTIFIER"05-se-ax-total-I*.png \
        "$IDENTIFIER"05-se-denE-total-I*.png \
        "$IDENTIFIER"05-se-denI-total-I*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-total-montage-I.png

    montage \
        "$IDENTIFIER"05-se-ax-con-I*.png \
        "$IDENTIFIER"05-se-denE-con-I*.png \
        "$IDENTIFIER"05-se-denI-con-I*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-con-montage-I.png

    COLS=$(ls -- *05-se-ax-hist-all-I*.png | wc -l)
    montage \
        "$IDENTIFIER"05-se-ax-hist-all-E*.png \
        "$IDENTIFIER"05-se-denE-hist-all-E*.png \
        "$IDENTIFIER"05-se-denI-hist-all-E*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-hist-all-montage-E.png

    montage \
        "$IDENTIFIER"05-se-ax-hist-con-E*.png \
        "$IDENTIFIER"05-se-denE-hist-con-E*.png \
        "$IDENTIFIER"05-se-denI-hist-con-E*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-hist-con-montage-E.png

    montage \
        "$IDENTIFIER"05-se-ax-hist-all-I*.png \
        "$IDENTIFIER"05-se-denE-hist-all-I*.png \
        "$IDENTIFIER"05-se-denI-hist-all-I*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-hist-all-montage-I.png

    montage \
        "$IDENTIFIER"05-se-ax-hist-con-I*.png \
        "$IDENTIFIER"05-se-denE-hist-con-I*.png \
        "$IDENTIFIER"05-se-denI-hist-con-I*.png \
        -tile "$COLS"x3 -geometry +2+2 "$IDENTIFIER"05-se-hist-con-montage-I.png
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
