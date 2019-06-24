# Requires the following arguments
# psiE: optimal homeostatic point for E
# psiI: optimal homeostatic point for I
# xmax: max x value to plot (in seconds)
# ymax: max y value to plot
# simid: id of the sim (for identification purposes)

load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/neuron-locations.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0

set term epslatex color size 5,3
set lmargin at screen 0.15

set xlabel "Time (\\(s\\))"
# Fix in the LaTeX source later
set ylabel "\\(\\overline\{[Ca^{2+}]\}\\)"
set ytics border nomirror
set xtics border nomirror
set yrange[0:]

set xrange[0:xmax]
set yrange[0:ymax]

set arrow from 0,psiE to xmax,psiE nohead lw 1
set label at xmax,psiE left "\\(\\overline\{\\psi_E\}\\)" offset 1,0
set output simid."-calcium-E.tex"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 lc 8 title "LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Peri LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Other";

unset arrow
unset label
set arrow from 0,psiI to xmax,psiI nohead lw 1
set label at xmax,psiI left "\\(\\overline\{\\psi_I\}\\)" offset 1,0
set output simid."-calcium-I.tex"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 lc 8 title "LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Peri LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Other";
