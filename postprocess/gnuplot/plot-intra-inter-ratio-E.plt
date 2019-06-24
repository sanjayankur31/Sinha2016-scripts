load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "X ({/Symbol s} = X x 150{/Symbol m})"
set ylabel "Intra/Inter connection ratio"

set output "08-syn_conns_intra_inter_ratio-E.png"
set title "Intra-inter layer ratio of incoming E connections to E neurons"
plot "conns_to_E.csv" using 1:24 with linespoints lw 6 pt 7 title "non LPZ", "conns_to_E.csv" using 1:26 with linespoints lw 6 pt 7 title "P LPZ", "conns_to_E.csv" using 1:25 with linespoints lw 6 pt 7 title "LPZ B", "conns_to_E.csv" using 1:27 with linespoints lw 6 pt 7 title "LPZ C";

set xrange[0:15]
set output "08-syn_conns_intra_inter_ratio-E-zoomed.png"
set title "Intra-inter layer ratio of incoming E connections to E neurons"
plot "conns_to_E.csv" using 1:24 with linespoints lw 6 pt 7 title "non LPZ", "conns_to_E.csv" using 1:26 with linespoints lw 6 pt 7 title "P LPZ", "conns_to_E.csv" using 1:25 with linespoints lw 6 pt 7 title "LPZ B", "conns_to_E.csv" using 1:27 with linespoints lw 6 pt 7 title "LPZ C";
