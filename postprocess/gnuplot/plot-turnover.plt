set term pngcairo font "OpenSans, 28" size 1920, 1028
set xlabel "Time (seconds)"
set ylabel "Synaptic turnover"
set xzeroaxis ls -1 lw 2
set datafile missing '0'
set lmargin at screen 0.15

set output "04-synaptic-change.png"
set title "Synapses formed and deleted in all neurons"
plot "04-synapses-formed-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-change-LPZ.png"
set title "Synapses formed and deleted in LPZ"
plot "04-synapses-formed-LPZ-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-LPZ-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"
