load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
# load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term epslatex color size 5,2.5
set xlabel "Time (\\(s\\))"
set ylabel "Total Synaptic elements"
set border 3
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.01
set yrange [0:]

simulation="201905131224"

set arrow nohead from first 2000, graph 0 to first 2000, graph 1 ls 0 lw 2 dt 2
set arrow nohead from first 4000, first 0 to first 4000, graph 1 ls 0 lw 2 dt 2
set arrow nohead from first 6000, first 0 to first 6000, graph 1 ls 0 lw 2 dt 2

## Totals
# pre
set output simulation."-05-se-con-pre-totals-lpz_c_I-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):15 with linespoints ls 1 lw 5 title "Exc", "05-se-all-lpz_c_I.txt" using ($1/1000):15 with linespoints ls 6 lw 5 title "Inh";
