set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Calcium concentrations"
set ytics border nomirror
set xtics border nomirror

set output "01-calcium-concentration-E.png"
set title "Mean and STD calcium concentration for E neuron sets"
plot "01-calcium-E-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD", "01-calcium-E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean"

set output "01-calcium-concentration-I.png"
set title "Mean and STD calcium concentration for I neuron sets"
plot "01-calcium-I-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 6 title "SD", "01-calcium-I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean"
