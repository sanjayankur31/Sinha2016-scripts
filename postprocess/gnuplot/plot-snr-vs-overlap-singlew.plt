load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Percent of overlap with LPZ"
set ylabel "SNR"
set yrange [0:2]
set xrange [25:100]
set xtics border nomirror 25
set pointintervalbox 3

set output "SNR-pattern-overlap.png"
set title "SNR vs overlap percent"
plot "sims-pattern3-final.txt" using ($1*100):2 with linespoints lt 1 lw 3 pt 7 pi -1 ps 2 title ""
