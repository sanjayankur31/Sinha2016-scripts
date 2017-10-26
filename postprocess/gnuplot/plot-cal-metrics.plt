set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Calcium concentrations"
set ytics border nomirror
set xtics border nomirror

set output "02-calcium-concentration-E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD LPZ C", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C"
plot "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD LPZ B", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B"
plot "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD P LPZ", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-concentration-I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD LPZ C", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C"
plot "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD LPZ B", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B"
plot "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD P LPZ", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"
