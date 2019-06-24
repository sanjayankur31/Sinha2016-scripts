load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
set term epslatex color size 15, 10 font "Helvetica,35"
set xlabel "Percent of overlap with LPZ"
set ylabel "SNR"
set yrange [0:1.5]
set xrange [25:100]
set xtics border nomirror 25
set pointintervalbox 3

set output "SNR-pattern-overlap-allw.tex"
plot "w5/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 7 pt 7 pi -1 ps 3 title "$w^{PAT} = 5 \\times w^{EE}$", "w10/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 7 pt 7 pi -1 ps 3 title "$w^{PAT} = 10 \\times w^{EE}$", "w15/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 7 pt 7 pi -1 ps 3 title "$w^{PAT} = 15 \\times w^{EE}$", "w20/sims-pattern3-final.txt" using ($1*100):2 with linespoints  lw 7 pt 7 pi -1 ps 3 title "$w^{PAT} = 20 \\times w^{EE}$";
