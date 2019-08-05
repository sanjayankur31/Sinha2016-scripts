#!/bin/bash

rsync -avPh mac:/simulation-drive/$1/consolidated_files/{*.png,*GIT*,*simulation*txt,00*txt} $1
