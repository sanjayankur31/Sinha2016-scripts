set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Number of synapses formed or deleted"
set xzeroaxis ls -1 lw 2
set datafile missing '0'
set xrange[0:]
set lmargin at screen 0.15

set output "04-synaptic-changes-lpz_c_E.png"
set title "Synapses formed and deleted in LPZ C E neurons"
plot "04-synapses-formed-lpz_c_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_c_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-lpz_b_E.png"
set title "Synapses formed and deleted in LPZ B E neurons"
plot "04-synapses-formed-lpz_b_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_b_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-p_lpz_E.png"
set title "Synapses formed and deleted in P LPZ E neurons"
plot "04-synapses-formed-p_lpz_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-o_E.png"
set title "Synapses formed and deleted in non LPZ E neurons"
plot "04-synapses-formed-o_E-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-o_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-lpz_c_I.png"
set title "Synapses formed and deleted in LPZ C I neurons"
plot "04-synapses-formed-lpz_c_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_c_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-lpz_b_I.png"
set title "Synapses formed and deleted in LPZ B I neurons"
plot "04-synapses-formed-lpz_b_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-lpz_b_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-p_lpz_I.png"
set title "Synapses formed and deleted in P LPZ I neurons"
plot "04-synapses-formed-p_lpz_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-o_I.png"
set title "Synapses formed and deleted in non LPZ I neurons"
plot "04-synapses-formed-o_I-totals.txt" with points pt 22 title "Synapses formed", "04-synapses-deleted-o_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted"

set output "04-synaptic-changes-all-E.png"
set title "Synapses formed and deleted in E neurons"
plot "04-synapses-formed-p_lpz_E-totals.txt" with points pt 22 title "Synapses formed P LPZ E", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted P LPZ E", "04-synapses-formed-lpz_b_E-totals.txt" with points pt 22 title "Synapses formed LPZ B E", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted P LPZ E", "04-synapses-formed-lpz_b_E-totals.txt" with points pt 22 title "Synapses formed LPZ B E", "04-synapses-deleted-p_lpz_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted P LPZ E", "04-synapses-formed-o_E-totals.txt" with points pt 22 title "Synapses formed non LPZ E", "04-synapses-deleted-o_E-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted non LPZ E"

set output "04-synaptic-changes-all-I.png"
set title "Synapses formed and deleted in I neurons"
plot "04-synapses-formed-p_lpz_I-totals.txt" with points pt 22 title "Synapses formed P LPZ I", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted P LPZ I", "04-synapses-formed-lpz_b_I-totals.txt" with points pt 22 title "Synapses formed LPZ B I", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted P LPZ I", "04-synapses-formed-lpz_b_I-totals.txt" with points pt 22 title "Synapses formed LPZ B I", "04-synapses-deleted-p_lpz_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted P LPZ I", "04-synapses-formed-o_I-totals.txt" with points pt 22 title "Synapses formed non LPZ I", "04-synapses-deleted-o_I-totals.txt" using 1:(-1*$2) with points pt 7 title "Synapses deleted non LPZ I"
