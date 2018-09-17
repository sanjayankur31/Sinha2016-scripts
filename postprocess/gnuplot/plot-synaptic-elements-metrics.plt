load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Mean Synaptic elements"
set ytics border nomirror
set xtics border nomirror
set yrange [0:]
set lmargin at screen 0.15

# means
set output "05-se-all-means-lpz_c_E.png"
set title "Mean Synaptic elements for LPZ C E neurons"
plot "05-se-all-lpz_c_E.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_c_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_c_E.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_c_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-lpz_b_E.png"
set title "Mean Synaptic elements for LPZ B E neurons"
plot "05-se-all-lpz_b_E.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_b_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_b_E.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_b_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-p_lpz_E.png"
set title "Mean Synaptic elements for P LPZ E neurons"
plot "05-se-all-p_lpz_E.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-p_lpz_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-p_lpz_E.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-p_lpz_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-o_E.png"
set title "Mean Synaptic elements for non LPZ E neurons"
plot "05-se-all-o_E.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-o_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-o_E.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-o_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-o_E.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-o_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-lpz_c_I.png"
set title "Mean Synaptic elements for LPZ C I neurons"
plot "05-se-all-lpz_c_I.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_c_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_c_I.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_c_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-lpz_b_I.png"
set title "Mean Synaptic elements for LPZ B I neurons"
plot "05-se-all-lpz_b_I.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_b_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_b_I.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_b_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-p_lpz_I.png"
set title "Mean Synaptic elements for P LPZ I neurons"
plot "05-se-all-p_lpz_I.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-p_lpz_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-p_lpz_I.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-p_lpz_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-all-means-o_I.png"
set title "Mean Synaptic elements for non LPZ I neurons"
plot "05-se-all-o_I.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-all-o_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-all-o_I.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-all-o_I.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-o_I.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-all-o_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";


## Totals
set ylabel "Total Synaptic elements"
set output "05-se-all-totals-lpz_c_E.png"
set title "Total Synaptic elements for LPZ C E neurons"
plot "05-se-all-lpz_c_E.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_c_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_c_E.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_c_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-lpz_b_E.png"
set title "Total Synaptic elements for LPZ B E neurons"
plot "05-se-all-lpz_b_E.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_b_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_b_E.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_b_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-p_lpz_E.png"
set title "Total Synaptic elements for P LPZ E neurons"
plot "05-se-all-p_lpz_E.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-p_lpz_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-p_lpz_E.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-p_lpz_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-o_E.png"
set title "Total Synaptic elements for non LPZ E neurons"
plot "05-se-all-o_E.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-o_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-o_E.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-o_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-o_E.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-o_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-lpz_c_I.png"
set title "Total Synaptic elements for LPZ C I neurons"
plot "05-se-all-lpz_c_I.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_c_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_c_I.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_c_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-lpz_b_I.png"
set title "Total Synaptic elements for LPZ B I neurons"
plot "05-se-all-lpz_b_I.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-lpz_b_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-lpz_b_I.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-lpz_b_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-p_lpz_I.png"
set title "Total Synaptic elements for P LPZ I neurons"
plot "05-se-all-p_lpz_I.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-p_lpz_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-p_lpz_I.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-p_lpz_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output "05-se-all-totals-o_I.png"
set title "Total Synaptic elements for non LPZ I neurons"
plot "05-se-all-o_I.txt" using ($1/1000):14 with linespoints lw 5 title "Expected ax", "05-se-all-o_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax", "05-se-all-o_I.txt" using ($1/1000):16 with linespoints lw 5 title "Expected ex d", "05-se-all-o_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-o_I.txt" using ($1/1000):18 with linespoints lw 5 title "Expected in d", "05-se-all-o_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";
