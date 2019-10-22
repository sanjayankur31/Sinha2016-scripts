# Usage: gnuplot plot-firing-rates-IE-tex.plt
load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,1.5
set xlabel "Time (\\(\\times 1000s\\))"
set ylabel "CV(ISI)"
set border 3
set ytics border nomirror 1
set xtics border nomirror 2000 format "%.0s"
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [0:7]
set key inside center top horizontal

simulation="201908061027"
inputtime1="1500.0"
inputtime2="2001.5"
inputtime3="4000.0"
inputtime4="18000.0"


set arrow nohead from first inputtime1, first 0.5 to first inputtime1, first 2 ls 0 lw 2 dt 2
set arrow nohead from first inputtime2, first 0.5 to first inputtime2, first 2 ls 0 lw 2 dt 2
set arrow nohead from first inputtime3, first 0.5 to first inputtime3, first 2 ls 0 lw 2 dt 2
set arrow nohead from first inputtime4, first 0.5 to first inputtime4, first 2 ls 0 lw 2 dt 2
# Horizontal line marking 1
set arrow nohead from first 0, first 1 to graph 1, first 1 lc black lw 4

set yrange[0.5:1.5]
set output simulation."-ISI-cv-lpz_c_E-p_lpz_E.tex"
set title ""
plot "ISI-cv-lpz_c_E.gdf" with linespoints ls 1 pt 7 ps 0.4 title "LPZ C", "ISI-cv-p_lpz_E.gdf" with linespoints ls 3 lw 2 pt 7 ps 0.4 title "Peri-LPZ";

