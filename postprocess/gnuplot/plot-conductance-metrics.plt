load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 4096,1920
set xlabel "Time in seconds"
set ylabel "Synaptic weight (nS)"
set yrange[0.:]
set key outside

set output "EE-mean-conductances.png"
set title "Mean synaptic weights EE"
plot "01-synaptic-weights-EE-mean-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 5 title "SD", "01-synaptic-weights-EE-mean-all.txt" using ($1/1000):2 with linespoints lw 5 title "Mean"

set output "EI-mean-conductances.png"
set title "Mean synaptic weights EI"
plot "01-synaptic-weights-EI-mean-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 5 title "SD", "01-synaptic-weights-EI-mean-all.txt" using ($1/1000):2 with linespoints lw 5 title "Mean"

set output "II-mean-conductances.png"
set title "Mean synaptic weights II"
plot "01-synaptic-weights-II-mean-all.txt" using ($1/1000):(-1*$2):(-1*($2-$3)):(-1*($2+$3)) with errorbars lw 5 title "SD", "01-synaptic-weights-II-mean-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "Mean"

set output "IE-mean-conductances.png"
set title "Mean synaptic weights IE"
plot "01-synaptic-weights-IE-mean-all.txt" using ($1/1000):(-1*$2):(-1*($2-$3)):(-1*($2+$3)) with errorbars lw 5 title "SD", "01-synaptic-weights-IE-mean-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "Mean"

set output "all-mean-conductances.png"
set title "All mean conductances"
plot "01-synaptic-weights-EE-mean-all.txt" using ($1/1000):2 with linespoints lw 5 title "EE (Mean)", "01-synaptic-weights-EI-mean-all.txt" using ($1/1000):2 with linespoints lw 5 title "EI (Mean)", "01-synaptic-weights-II-mean-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "II (Mean)", "01-synaptic-weights-IE-mean-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "IE (Mean)", "01-synaptic-weights-EE-mean-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 5 title "EE (SD) ", "01-synaptic-weights-EI-mean-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 5 title "EI (SD)","01-synaptic-weights-II-mean-all.txt" using ($1/1000):(-1*$2):(-1*($2-$3)):(-1*($2+$3)) with errorbars lw 5 title "II (SD)",  "01-synaptic-weights-IE-mean-all.txt" using ($1/1000):(-1*$2):(-1*($2-$3)):(-1*($2+$3)) with errorbars lw 5 title "IE (SD)"

set output "EE-total-conductances.png"
set title "Total synaptic weights EE"
plot "01-synaptic-weights-EE-total-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total"

set output "EI-total-conductances.png"
set title "Total synaptic weights EI"
plot "01-synaptic-weights-EI-total-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total"

set output "II-total-conductances.png"
set title "Total synaptic weights II"
plot "01-synaptic-weights-II-total-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "Total"

set output "IE-total-conductances.png"
set title "Total synaptic weights IE"
plot "01-synaptic-weights-IE-total-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "Total"

set output "all-total-conductances.png"
set title "All total conductances"
plot "01-synaptic-weights-EE-total-all.txt" using ($1/1000):2 with linespoints lw 5 title "EE (Total)", "01-synaptic-weights-EI-total-all.txt" using ($1/1000):2 with linespoints lw 5 title "EI (Total)", "01-synaptic-weights-II-total-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "II (Total)", "01-synaptic-weights-IE-total-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "IE (Total)"
