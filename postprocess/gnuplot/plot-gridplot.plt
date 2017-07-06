load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
set term epslatex color size 13, 15 "Helvetica,35"
set xlabel "extent ($\\mu m$)"
set ylabel "extent ($\\mu m$)"
set xtics out border nomirror 0,4000
set ytics out border nomirror 0,4000
unset border
unset key
set yrange[-200:15000]
set xrange[-200:12000]

set label "$Pattern~1$" at 6000,7500 center front
set label "$Pattern~3$" at 6000,12000 center front
set label "$Pattern~2$" at 10000,2000 center front
set label "$LPZ$" at 6000,4100 center front

set output "gridplot.tex"
plot "201706261702-00-neuron-locations-E.txt" using 4:5 with points pt 7 title "E", "201706261702-00-lpz-neuron-locations-E.txt" using 2:3 with points pt 7 title "LPZ", "201706261702-00-pattern-neurons-1.txt" using 2:3 with points pt 7 title "Pattern 1", "201706261702-00-pattern-neurons-2.txt" using 2:3 with points pt 7 title "Pattern 2", "201706261702-00-pattern-neurons-3.txt" using 2:3 with points pt 7 title "Pattern 3";

