load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "extent ($\\mu m$)"
set ylabel "extent ($\\mu m$)"
set xtics out border nomirror 0,4000
set ytics out border nomirror 0,4000
unset key
set yrange[-200:15000]
set xrange[-200:12000]

set output o_fn;
plot i_fn using 1:2:($3-$1):($4-$2) with vectors title plot_title;
