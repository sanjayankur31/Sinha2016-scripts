#!/bin/bash

for folder in "$@";
do
    rsync -avPh asinha@stri-cluster:/stri-data/asinha/simulations-nest/"$folder"/result/ "$folder";
    pushd "$folder";

        ~/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/bash/nest/consolidate-files.sh
        pushd consolidated_files
            cp ~/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/config.ini . -v;
            python3 ~/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/py/postprocess.py nest;
        popd;
    popd;
done
