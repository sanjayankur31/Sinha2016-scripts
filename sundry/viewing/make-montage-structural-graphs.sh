#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs to do with structural plasticity

PREFIX=""

usage()
{
    echo "montage.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$PREFIX"growth-curves-lpz_b_E.png \
        "$PREFIX"growth-curves-lpz_b_I.png \
        "$PREFIX"02-calcium-E.png \
        "$PREFIX"02-calcium-I.png \
        "$PREFIX"05-se-lpz_c_E-all.png \
        "$PREFIX"05-se-lpz_c_I-all.png \
        "$PREFIX"05-se-lpz_b_E-all.png \
        "$PREFIX"05-se-lpz_b_I-all.png \
        "$PREFIX"05-se-p_lpz_E-all.png \
        "$PREFIX"05-se-p_lpz_I-all.png \
        "$PREFIX"05-se-o_E-all.png \
        "$PREFIX"05-se-o_I-all.png \
        -tile 2x6 -geometry +2+2  "$PREFIX"montage.png
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
