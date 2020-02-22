# Usage: gnuplot plot-firing-rates-IE-tex.plt
load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,2.0
set xlabel "Number of patterns"
set ylabel "\\% coverage"
set border 3
set ytics border nomirror autofreq 0.5
set xtics border nomirror 12
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [:1]
set xrange [:50]
set key inside center top horizontal

set output "pattern-coverage.tex"
set title ""
plot "pattern_overlap_data.txt" with lines ls 1  title "";
