set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Calcium concentrations"
set ytics border nomirror
set xtics border nomirror

# to also plot the three values for easier analysis
set xrange[0:100]
eps=system("head -1 09-growth-curve-params-lpz_c_E.txt  | awk '{print $3}'")
etaa=system("head -1 09-growth-curve-params-lpz_c_E.txt  | awk '{print $2}'")
etad=system("head -1 09-growth-curve-params-lpz_c_E.txt  | awk '{print $1}'")
set arrow from 0,etad to 100,etad nohead lw 3
set arrow from 0,eps to 100, eps nohead lw 3
set arrow from 0,etaa to 100,etaa nohead lw 3

set output "02-calcium-E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
# plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";


set output "02-calcium-lpz_c_E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C",

set output "02-calcium-lpz_b_E.png"
plot "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B",

set output "02-calcium-p_lpz_E.png"
plot "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-o_E.png"
plot "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ"

set xrange[0:150]
eps=system("head -1 09-growth-curve-params-lpz_c_I.txt  | awk '{print $3}'")
etaa=system("head -1 09-growth-curve-params-lpz_c_I.txt  | awk '{print $2}'")
etad=system("head -1 09-growth-curve-params-lpz_c_I.txt  | awk '{print $1}'")
set arrow from 0,etad to 150,etad nohead lw 3
set arrow from 0,eps to 150, eps nohead lw 3
set arrow from 0,etaa to 150,etaa nohead lw 3
set output "02-calcium-I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
#plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

set output "02-calcium-lpz_c_I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C",

set output "02-calcium-lpz_b_I.png"
plot "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B",

set output "02-calcium-p_lpz_I.png"
plot "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-o_I.png"
plot "02-calcium-o_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ"
