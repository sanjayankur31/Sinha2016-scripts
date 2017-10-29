set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Synaptic elements"
set ytics border nomirror
set xtics border nomirror
set yrange [0:]

set output "05-se-lpz_c_E-all.png"
set title "Synaptic elements for LPZ C E neurons"
plot "05-se-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "05-se-lpz_c_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_c_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-lpz_c_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_c_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-lpz_c_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-lpz_b_E-all.png"
set title "Synaptic elements for LPZ B E neurons"
plot "05-se-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "05-se-lpz_b_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_b_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-lpz_b_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_b_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-lpz_b_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-p_lpz_E-all.png"
set title "Synaptic elements for P LPZ E neurons"
plot "05-se-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "05-se-p_lpz_E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-p_lpz_E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-p_lpz_E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-p_lpz_E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-p_lpz_E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-lpz_c_I-all.png"
set title "Synaptic elements for LPZ C I neurons"
plot "05-se-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "05-se-lpz_c_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_c_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-lpz_c_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_c_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-lpz_c_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-lpz_b_I-all.png"
set title "Synaptic elements for LPZ B I neurons"
plot "05-se-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "05-se-lpz_b_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-lpz_b_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-lpz_b_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-lpz_b_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-lpz_b_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output "05-se-p_lpz_I-all.png"
set title "Synaptic elements for P LPZ I neurons"
plot "05-se-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "05-se-p_lpz_I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "05-se-p_lpz_I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-p_lpz_I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-p_lpz_I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-p_lpz_I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";
