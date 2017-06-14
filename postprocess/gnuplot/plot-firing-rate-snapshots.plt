load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1920,1028

if (file_exists(inputfile)) {
    set output plotname
    set title plottitle
    set view map
    set dgrid3d
    splot inputfile using 1:2:3 with pm3d
}

