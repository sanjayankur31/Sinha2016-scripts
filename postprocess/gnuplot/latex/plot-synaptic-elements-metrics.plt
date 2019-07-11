load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
# load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term epslatex color size 5,2.5
set xlabel "Time (\\(s\\))"
set ylabel "Mean synaptic elements"
set border 3
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.01
set yrange [0:]
set key inside center top horizontal

simulation="201905131224"

inputtime1="2000.0"
inputtime2="4000.0"
inputtime3="16600.0"

set arrow nohead from first inputtime1, first 0 to first inputtime1, graph 1 ls 0 lw 2 dt 2
set arrow nohead from first inputtime2, first 0 to first inputtime2, graph 1 ls 0 lw 2 dt 2
set arrow nohead from first inputtime3, first 0 to first inputtime3, graph 1 ls 0 lw 2 dt 2

# means
# E neurons
# post-synaptic
set output simulation."-05-se-con-post-means-lpz_c_E.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_c_E.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-means-lpz_b_E.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_b_E.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-means-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-p_lpz_E.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-means-o_E.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-o_E.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

# I neurons
# post
set output simulation."-05-se-con-post-means-lpz_c_I.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_c_I.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-means-lpz_b_I.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_b_I.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-means-p_lpz_I.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-p_lpz_I.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-means-o_I.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):5 with linespoints ls 1 lw 5 title "E", "05-se-all-o_I.txt" using ($1/1000):7 with linespoints ls 6 lw 5 title "I";

# Pre
set output simulation."-05-se-con-pre-means-lpz_c.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):3 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_c_I.txt" using ($1/1000):3 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-pre-means-p_lpz.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):3 with linespoints ls 1 lw 5 title "E", "05-se-all-p_lpz_I.txt" using ($1/1000):3 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-pre-means-lpz_b.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):3 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_b_I.txt" using ($1/1000):3 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-pre-means-o.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):3 with linespoints ls 1 lw 5 title "E", "05-se-all-o_I.txt" using ($1/1000):3 with linespoints ls 6 lw 5 title "I";

## Totals
set ylabel "Total Synaptic elements"
# Eitatory
# post-synaptic
set output simulation."-05-se-con-post-totals-lpz_c_E.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_c_E.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-totals-lpz_b_E.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_b_E.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-totals-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-p_lpz_E.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-totals-o_E.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-o_E.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

# Iibitory
set output simulation."-05-se-con-post-totals-lpz_c_I.tex"
set title ""
plot "05-se-all-lpz_c_I.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_c_I.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-totals-lpz_b_I.tex"
set title ""
plot "05-se-all-lpz_b_I.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_b_I.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-totals-p_lpz_I.tex"
set title ""
plot "05-se-all-p_lpz_I.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-p_lpz_I.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-post-totals-o_I.tex"
set title ""
plot "05-se-all-o_I.txt" using ($1/1000):17 with linespoints ls 1 lw 5 title "E", "05-se-all-o_I.txt" using ($1/1000):19 with linespoints ls 6 lw 5 title "I";

# pre
set output simulation."-05-se-con-pre-totals-lpz_c.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):15 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_c_I.txt" using ($1/1000):15 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-pre-totals-lpz_b.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):15 with linespoints ls 1 lw 5 title "E", "05-se-all-lpz_b_I.txt" using ($1/1000):15 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-pre-totals-p_lpz.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):15 with linespoints ls 1 lw 5 title "E", "05-se-all-p_lpz_I.txt" using ($1/1000):15 with linespoints ls 6 lw 5 title "I";

set output simulation."-05-se-con-pre-totals-o.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):15 with linespoints ls 1 lw 5 title "E", "05-se-all-o_I.txt" using ($1/1000):15 with linespoints ls 6 lw 5 title "I";

# Both
set output simulation."-05-se-post-means-lpz_c_E.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-lpz_c_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-lpz_c_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-means-lpz_b_E.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-lpz_b_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-lpz_b_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-means-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-p_lpz_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-p_lpz_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-means-o_E.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-o_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-o_E.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-o_E.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

# I neurons
# post
set output simulation."-05-se-post-means-lpz_c_I.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-lpz_c_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-lpz_c_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-lpz_c_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-means-lpz_b_I.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-lpz_b_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-lpz_b_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-lpz_b_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-means-p_lpz_I.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-p_lpz_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-p_lpz_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-p_lpz_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-means-o_I.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):4 with linespoints lw 5 title "Total E", "05-se-all-o_E.txt" using ($1/1000):5 with linespoints lw 5 title "Connected E", "05-se-all-o_I.txt" using ($1/1000):6 with linespoints lw 5 title "Total I", "05-se-all-o_I.txt" using ($1/1000):7 with linespoints lw 5 title "Connected I";

# Pre
set output simulation."-05-se-pre-means-lpz_c.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total E", "05-se-all-lpz_c_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected E", "05-se-all-lpz_c_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total I", "05-se-all-lpz_c_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-pre-means-p_lpz.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total E", "05-se-all-p_lpz_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected E", "05-se-all-p_lpz_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total I", "05-se-all-p_lpz_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-pre-means-lpz_b.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total E", "05-se-all-lpz_b_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected E", "05-se-all-lpz_b_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total I", "05-se-all-lpz_b_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-pre-means-o.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):2 with linespoints lw 5 title "Total E", "05-se-all-o_E.txt" using ($1/1000):3 with linespoints lw 5 title "Connected E", "05-se-all-o_I.txt" using ($1/1000):2 with linespoints lw 5 title "Total I", "05-se-all-o_I.txt" using ($1/1000):3 with linespoints lw 5 title "Connected I";

## Totals
set ylabel "Total Synaptic elements"
# Eitatory
# post-synaptic
set output simulation."-05-se-post-totals-lpz_c_E.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-lpz_c_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-lpz_c_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-lpz_c_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-totals-lpz_b_E.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-lpz_b_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-lpz_b_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-lpz_b_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-totals-p_lpz_E.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-p_lpz_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-p_lpz_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-p_lpz_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-totals-o_E.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-o_E.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-o_E.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-o_E.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

# Iibitory
set output simulation."-05-se-post-totals-lpz_c_I.tex"
set title ""
plot "05-se-all-lpz_c_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-lpz_c_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-lpz_c_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-lpz_c_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-totals-lpz_b_I.tex"
set title ""
plot "05-se-all-lpz_b_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-lpz_b_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-lpz_b_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-lpz_b_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-totals-p_lpz_I.tex"
set title ""
plot "05-se-all-p_lpz_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-p_lpz_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-p_lpz_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-p_lpz_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-post-totals-o_I.tex"
set title ""
plot "05-se-all-o_I.txt" using ($1/1000):16 with linespoints lw 5 title "Total E", "05-se-all-o_I.txt" using ($1/1000):17 with linespoints lw 5 title "Connected E", "05-se-all-o_I.txt" using ($1/1000):18 with linespoints lw 5 title "Total I", "05-se-all-o_I.txt" using ($1/1000):19 with linespoints lw 5 title "Connected I";

# pre
set output simulation."-05-se-pre-totals-lpz_c.tex"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total E", "05-se-all-lpz_c_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected E", "05-se-all-lpz_c_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total I", "05-se-all-lpz_c_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-pre-totals-lpz_b.tex"
set title ""
plot "05-se-all-lpz_b_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total E", "05-se-all-lpz_b_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected E", "05-se-all-lpz_b_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total I", "05-se-all-lpz_b_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-pre-totals-p_lpz.tex"
set title ""
plot "05-se-all-p_lpz_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total E", "05-se-all-p_lpz_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected E", "05-se-all-p_lpz_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total I", "05-se-all-p_lpz_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected I";

set output simulation."-05-se-pre-totals-o.tex"
set title ""
plot "05-se-all-o_E.txt" using ($1/1000):14 with linespoints lw 5 title "Total E", "05-se-all-o_E.txt" using ($1/1000):15 with linespoints lw 5 title "Connected E", "05-se-all-o_I.txt" using ($1/1000):14 with linespoints lw 5 title "Total I", "05-se-all-o_I.txt" using ($1/1000):15 with linespoints lw 5 title "Connected I";
