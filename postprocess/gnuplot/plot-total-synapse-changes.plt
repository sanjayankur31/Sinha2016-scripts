set term pngcairo font "OpenSans, 28" size 1920, 1028
set xlabel "Time (seconds)"
set ylabel "Number of synapses formed or deleted"
set xzeroaxis ls -1 lw 2
set datafile missing '0'

set output "04-synaptic-changes-lpz_c_E.png"
set title "Synapses formed and deleted in lpz_c_E neurons"
plot "04-synapses-formed-lpz_c_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_c_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-lpz_b_E.png"
set title "Synapses formed and deleted in lpz_b_E neurons"
plot "04-synapses-formed-lpz_b_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_b_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-p_lpz_E.png"
set title "Synapses formed and deleted in p_lpz_E neurons"
plot "04-synapses-formed-p_lpz_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-lpz_c_I.png"
set title "Synapses formed and deleted in lpz_c_I neurons"
plot "04-synapses-formed-lpz_c_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_c_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-lpz_b_I.png"
set title "Synapses formed and deleted in lpz_b_I neurons"
plot "04-synapses-formed-lpz_b_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_b_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-p_lpz_I.png"
set title "Synapses formed and deleted in p_lpz_I neurons"
plot "04-synapses-formed-p_lpz_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-all-E.png"
set title "Synapses formed and deleted in E neurons"
plot "04-synapses-formed-p_lpz_E-totals.txt" with points pt 22 title "Synapses formed p_lpz_E", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted p_lpz_E", "04-synapses-formed-lpz_b_E-totals.txt" with points pt 22 title "Synapses formed lpz_b_E", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted p_lpz_E", "04-synapses-formed-lpz_b_E-totals.txt" with points pt 22 title "Synapses formed lpz_b_E", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted p_lpz_E"

set output "04-synaptic-changes-all-I.png"
set title "Synapses formed and deleted in I neurons"
plot "04-synapses-formed-p_lpz_I-totals.txt" with points pt 22 title "Synapses formed p_lpz_I", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted p_lpz_I", "04-synapses-formed-lpz_b_I-totals.txt" with points pt 22 title "Synapses formed lpz_b_I", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted p_lpz_I", "04-synapses-formed-lpz_b_I-totals.txt" with points pt 22 title "Synapses formed lpz_b_I", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted p_lpz_I"
