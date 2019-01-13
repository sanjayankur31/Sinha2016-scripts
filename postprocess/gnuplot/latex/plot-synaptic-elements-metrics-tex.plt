load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term epslatex color size 5,2.5
set xlabel "Time (\\(s\\))"
set ylabel "Mean synaptic elements"
set border 3
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.01
set yrange [0:]

simulation="201811221433"

# means
# E neurons
# post-synaptic
set output simulation."-05-se-post-means-lpz_c_E.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-lpz_c_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-means-lpz_b_E.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-lpz_b_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-means-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-p_lpz_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-means-o_E.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-o_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-o_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-o_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

# I neurons
# post
set output simulation."-05-se-post-means-lpz_c_I.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-lpz_c_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-means-lpz_b_I.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-lpz_b_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-means-p_lpz_I.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-p_lpz_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-means-o_I.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "05-se-all-o_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "05-se-all-o_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "05-se-all-o_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d";

# Pre
set output simulation."-05-se-pre-means-lpz_c.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax E", "05-se-all-lpz_c_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax E", "05-se-all-lpz_c_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax I", "05-se-all-lpz_c_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax I";

set output simulation."-05-se-pre-means-p_lpz.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax E", "05-se-all-p_lpz_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax E", "05-se-all-p_lpz_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax I", "05-se-all-p_lpz_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax I";

set output simulation."-05-se-pre-means-lpz_b.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax E", "05-se-all-lpz_b_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax E", "05-se-all-lpz_b_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax I", "05-se-all-lpz_b_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax I";

set output simulation."-05-se-pre-means-o.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax E", "05-se-all-o_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax E", "05-se-all-o_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax I", "05-se-all-o_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax I";

## Totals
set ylabel "Total Synaptic elements"
# Excitatory
# post-synaptic
set output simulation."-05-se-post-totals-lpz_c_E.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-lpz_c_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-totals-lpz_b_E.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-lpz_b_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-totals-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-p_lpz_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-totals-o_E.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-o_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-o_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-o_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

# Inhibitory
set output simulation."-05-se-post-totals-lpz_c_I.tex"
set title ""
plot "05-se-all-lpz_c_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_c_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-lpz_c_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-totals-lpz_b_I.tex"
set title ""
plot "05-se-all-lpz_b_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-lpz_b_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-lpz_b_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-totals-p_lpz_I.tex"
set title ""
plot "05-se-all-p_lpz_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-p_lpz_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-p_lpz_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

set output simulation."-05-se-post-totals-o_I.tex"
set title ""
plot "05-se-all-o_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total ex d", "05-se-all-o_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected ex d", "05-se-all-o_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total in d", "05-se-all-o_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected in d";

# pre
set output simulation."-05-se-pre-totals-lpz_c.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax E", "05-se-all-lpz_c_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax E", "05-se-all-lpz_c_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax I", "05-se-all-lpz_c_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax I";

set output simulation."-05-se-pre-totals-lpz_b.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax E", "05-se-all-lpz_b_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax E", "05-se-all-lpz_b_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax I", "05-se-all-lpz_b_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax I";

set output simulation."-05-se-pre-totals-p_lpz.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax E", "05-se-all-p_lpz_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax E", "05-se-all-p_lpz_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax I", "05-se-all-p_lpz_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax I";

set output simulation."-05-se-pre-totals-o.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax E", "05-se-all-o_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax E", "05-se-all-o_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total ax I", "05-se-all-o_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected ax I";
