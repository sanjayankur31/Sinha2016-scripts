set term pngcairo font "OpenSans, 28" size 4096,1920
set xlabel "Time (seconds)"
set ylabel "Synaptic turnover"
set key outside
set xzeroaxis ls -1 lw 2

set output "04-synaptic-turnover.png"
set title "Synaptic turnover"
plot "04-synapses-formed-totals.txt" with lines lw 2 title "Synapses formed", "04-synapses-deleted-totals.txt" using 1:(-1*$2) with lines lw 2 title "Synapses deleted"
