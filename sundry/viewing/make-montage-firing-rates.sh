#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs that show various firing rates

IDENTIFIER=""

usage()
{
    echo "make-montage-firing-rates.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$IDENTIFIER"mean-firing-rates-all-E-zoomed.png \
        "$IDENTIFIER"mean-firing-rates-all-I-zoomed.png \
        "$IDENTIFIER"mean-firing-rates-lpz_c_I-E-zoomed.png \
        "$IDENTIFIER"mean-firing-rates-lpz_b_I-E-zoomed.png \
        "$IDENTIFIER"mean-firing-rates-p_lpz_I-E-zoomed.png \
        "$IDENTIFIER"mean-firing-rates-o_I-E-zoomed.png \
        -tile 2x3 -geometry +2+2  "$IDENTIFIER"firing-rate-montage.png
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
