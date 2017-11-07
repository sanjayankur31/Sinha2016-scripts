#!/bin/bash
# Generate a montage of images so that they can be all seen at once
# This file includes graphs to do with conductances

PREFIX=""

usage()
{
    echo "make-montage-conductances.sh -y <year prefix>"
    echo "Note, prefix has a trailing dash in it so that it can be left empty if required."
}

main ()
{
    montage \
        "$PREFIX"all-mean-conductances.png \
        "$PREFIX"all-total-conductances.png \
        -tile 1x2 -geometry +2+2  "$PREFIX"conductance-montage.png
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
