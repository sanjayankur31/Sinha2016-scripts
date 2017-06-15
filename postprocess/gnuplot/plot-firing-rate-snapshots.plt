load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1920,1028
set size ratio -1

set xrange[-1:81]
set yrange[-1:101]
if (file_exists(inputfile)) {
    set output plotname
    set title plottitle
    # row is y, not x
    plot inputfile using 2:1:3 with image
}

