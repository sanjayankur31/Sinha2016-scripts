load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Percent of overlap with LPZ"
set ylabel "SNR"
set yrange [0:]
set xrange [25:100]
set xtics border nomirror 25
set pointintervalbox 3

set output "SNR-pattern-overlap-allw.png"
set title "SNR vs overlap percent for different wPat values"
plot "w5/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 3 pt 7 pi -1 ps 2 title "wPat = 5 wEE", "w10/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 3 pt 7 pi -1 ps 2 title "wPat = 10 wEE", "w15/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 3 pt 7 pi -1 ps 2 title "wPat = 15 wEE", "w20/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 3 pt 7 pi -1 ps 2 title "wPat = 20 wEE";
