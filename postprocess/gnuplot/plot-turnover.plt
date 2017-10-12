set term pngcairo font "OpenSans, 28" size 1920, 1028
set xlabel "Time (seconds)"
set ylabel "Synaptic turnover"
set xzeroaxis ls -1 lw 2

set output "04-synaptic-turnover.png"
set title "Synaptic turnover"
plot "04-synapses-formed-totals.txt" with lines lw 2 title "Synapses formed", "04-synapses-deleted-totals.txt" using 1:(-1*$2) with lines lw 2 title "Synapses deleted"

set output "04-synaptic-turnover-LPZ.png"
set title "Synaptic turnover in LPZ"
plot "04-synapses-formed-LPZ-totals.txt" with lines lw 2 title "Synapses formed", "04-synapses-deleted-LPZ-totals.txt" using 1:(-1*$2) with lines lw 2 title "Synapses deleted"
