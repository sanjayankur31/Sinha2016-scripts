set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time in seconds"
set ylabel "Synaptic weight (nS)"
set yrange[-10.:]
set key outside

set output "EE-conductances.png"
set title "Synaptic weights EE"
plot "00-synaptic-weights-EE-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 5 title "SD", "00-synaptic-weights-EE-all.txt" using ($1/1000):2 with linespoints lw 5 title "Mean"

set output "EI-conductances.png"
set title "Synaptic weights EI"
plot "00-synaptic-weights-EI-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 5 title "SD", "00-synaptic-weights-EI-all.txt" using ($1/1000):2 with linespoints lw 5 title "Mean"

set output "II-conductances.png"
set title "Synaptic weights II"
plot "00-synaptic-weights-II-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 5 title "SD", "00-synaptic-weights-II-all.txt" using ($1/1000):2 with linespoints lw 5 title "Mean"

set output "IE-conductances.png"
set title "Synaptic weights IE"
plot "00-synaptic-weights-IE-all.txt" using ($1/1000):(-1*$2):(-1*($2-$3/2)):(-1*($2+$3/2)) with errorbars lw 5 title "SD", "00-synaptic-weights-IE-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "Mean"

set output "all-conductances.png"
set title "All conductances"
plot "00-synaptic-weights-EE-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 5 title "EE (SD) ", "00-synaptic-weights-EE-all.txt" using ($1/1000):2 with linespoints lw 5 title "EE (Mean)", "00-synaptic-weights-EI-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 5 title "EI (SD)", "00-synaptic-weights-EI-all.txt" using ($1/1000):2 with linespoints lw 5 title "EI (Mean)", "00-synaptic-weights-II-all.txt" using ($1/1000):2:($2-$3/2):($2+$3/2) with errorbars lw 5 title "II (SD)", "00-synaptic-weights-II-all.txt" using ($1/1000):2 with linespoints lw 5 title "II (Mean)", "00-synaptic-weights-IE-all.txt" using ($1/1000):(-1*$2):(-1*($2-$3/2)):(-1*($2+$3/2)) with errorbars lw 5 title "IE (SD)", "00-synaptic-weights-IE-all.txt" using ($1/1000):(-1*$2) with linespoints lw 5 title "IE (Mean)"
