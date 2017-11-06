set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Calcium concentrations"
set ytics border nomirror
set xtics border nomirror

set output "02-calcium-E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";


set output "02-calcium-lpz_c_E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C",

set output "02-calcium-lpz_b_E.png"
plot "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B",

set output "02-calcium-p_lpz_E.png"
plot "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-o_E.png"
plot "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ"

set output "02-calcium-I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-lpz_c_I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C",

set output "02-calcium-lpz_b_I.png"
plot "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B",

set output "02-calcium-p_lpz_I.png"
plot "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-o_I.png"
plot "02-calcium-o_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ"
