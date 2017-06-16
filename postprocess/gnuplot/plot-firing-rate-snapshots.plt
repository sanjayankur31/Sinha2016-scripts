load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palettes-snapshot.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1440, 1920
set size ratio -1
set xrange [0:80]
set yrange [0:100]
set xtics border nomirror
set ytics border nomirror
set cblabel "Firing rate (Hz)"
set xlabel "Neurons"
set ylabel "Neurons"

if (file_exists(inputfile)) {
    set output plotname
    set title plottitle
    # row is y, not x
    set view map
    plot inputfile using 1:2:3 with image
}

