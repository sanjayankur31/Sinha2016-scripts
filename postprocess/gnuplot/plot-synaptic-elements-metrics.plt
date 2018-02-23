load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Mean Synaptic elements"
set ytics border nomirror
set xtics border nomirror
set yrange [0:]
set lmargin at screen 0.15

set output "05-se-lpz_c_E-all.png"
set title "Mean Synaptic elements for LPZ C E neurons"
plot "05-se-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-lpz_c_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_c_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-lpz_c_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_c_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-lpz_c_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-lpz_b_E-all.png"
set title "Mean Synaptic elements for LPZ B E neurons"
plot "05-se-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-lpz_b_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_b_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-lpz_b_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_b_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-lpz_b_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-p_lpz_E-all.png"
set title "Mean Synaptic elements for P LPZ E neurons"
plot "05-se-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-p_lpz_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-p_lpz_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-p_lpz_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-p_lpz_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-p_lpz_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-o_E-all.png"
set title "Mean Synaptic elements for non LPZ E neurons"
plot "05-se-o_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-o_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-o_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-o_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-o_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-o_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-lpz_c_I-all.png"
set title "Mean Synaptic elements for LPZ C I neurons"
plot "05-se-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-lpz_c_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_c_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-lpz_c_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_c_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-lpz_c_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-lpz_b_I-all.png"
set title "Mean Synaptic elements for LPZ B I neurons"
plot "05-se-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-lpz_b_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_b_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-lpz_b_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_b_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-lpz_b_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-p_lpz_I-all.png"
set title "Mean Synaptic elements for P LPZ I neurons"
plot "05-se-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-p_lpz_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-p_lpz_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-p_lpz_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-p_lpz_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-p_lpz_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-o_I-all.png"
set title "Mean Synaptic elements for non LPZ I neurons"
plot "05-se-o_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Expected ax", "05-se-o_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-o_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Expected ex d", "05-se-o_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-o_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Expected in d", "05-se-o_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";
