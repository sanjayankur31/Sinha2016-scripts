load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "X ({/Symbol s} = X x 150{/Symbol m})"
set ylabel "Number of incoming connections"
set lmargin at screen 0.15

set output "08-syn_conns_to_lpz_c_E.png"
set title "To LPZ C"
plot "conns_to_E.csv" using 1:2 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:3 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:4 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:5 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($2+$3+$4+$5) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_lpz_b_E.png"
set title "To LPZ B"
plot "conns_to_E.csv" using 1:6 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:7 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:8 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:9 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($6+$7+$8+$9) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_p_lpz_E.png"
set title "To P LPZ"
plot "conns_to_E.csv" using 1:10 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:11 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:12 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:13 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($10+$11+$12+$13) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_o_E.png"
set title "To non LPZ"
plot "conns_to_E.csv" using 1:14 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:15 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:16 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:16 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($14+$15+$16+$17) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_E.png"
set title "Totals to different regions"
plot "conns_to_E.csv" using 1:19 with linespoints lw 6 pt 7 title "to LPZ C", "conns_to_E.csv" using 1:20 with linespoints lw 6 pt 7 title "to LPZ B", "conns_to_E.csv" using 1:21 with linespoints lw 6 pt 7 title "to P LPZ", "conns_to_E.csv" using 1:22 with linespoints lw 6 pt 7 title "to O LPZ";

set xrange[0:25]
set output "08-syn_conns_to_lpz_c_E-zoomed.png"
set title "To LPZ C"
plot "conns_to_E.csv" using 1:2 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:3 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:4 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:5 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($2+$3+$4+$5) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_lpz_b_E-zoomed.png"
set title "To LPZ B"
plot "conns_to_E.csv" using 1:6 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:7 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:8 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:9 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($6+$7+$8+$9) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_p_lpz_E-zoomed.png"
set title "To P LPZ"
plot "conns_to_E.csv" using 1:10 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:11 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:12 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:13 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($10+$11+$12+$13) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_o_E-zoomed.png"
set title "To non LPZ"
plot "conns_to_E.csv" using 1:14 with linespoints lw 6 pt 7 title "from non LPZ", "conns_to_E.csv" using 1:15 with linespoints lw 6 pt 7 title "from P LPZ", "conns_to_E.csv" using 1:16 with linespoints lw 6 pt 7 title "from LPZ B", "conns_to_E.csv" using 1:16 with linespoints lw 6 pt 7 title "from LPZ C", "conns_to_E.csv" using 1:($14+$15+$16+$17) with linespoints lw 6 pt 7 title "Total";

set output "08-syn_conns_to_E-zoomed.png"
set title "Totals to different regions"
plot "conns_to_E.csv" using 1:19 with linespoints lw 6 pt 7 title "to LPZ C", "conns_to_E.csv" using 1:20 with linespoints lw 6 pt 7 title "to LPZ B", "conns_to_E.csv" using 1:21 with linespoints lw 6 pt 7 title "to P LPZ", "conns_to_E.csv" using 1:22 with linespoints lw 6 pt 7 title "to O LPZ";

