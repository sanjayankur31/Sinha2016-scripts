load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Number of incoming synapses"
set ytics border nomirror
set xtics border nomirror
set xrange[0:]
set yrange[0:]
set format y "%.1tx10^{%T}"
set lmargin at screen 0.15

# incoming E to E
set output "08-syn_conns-E-to-lpz_c_E.png"
set title "Incoming E connections to LPZ C E"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_E-EE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_c_E-EE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_c_E-EE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_c_E-EE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-E-to-lpz_b_E.png"
set title "Incoming E connections to LPZ B E"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_E-EE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_b_E-EE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_b_E-EE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_b_E-EE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-E-to-p_lpz_E.png"
set title "Incoming E connections to P LPZ E"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_E-EE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-p_lpz_E-EE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-p_lpz_E-EE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-p_lpz_E-EE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-E-to-o_E.png"
set title "Incoming E connections to non LPZ E"
plot  "08-syn_conns-lpz_c_E-to-o_E-EE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-o_E-EE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-o_E-EE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-o_E-EE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

# incoming I to E
set output "08-syn_conns-I-to-lpz_c_E.png"
set title "Incoming I connections to LPZ C E"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_E-IE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_c_E-IE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_c_E-IE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_c_E-IE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-I-to-lpz_b_E.png"
set title "Incoming I connections to LPZ B E"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_E-IE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_b_E-IE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_b_E-IE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_b_E-IE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-I-to-p_lpz_E.png"
set title "Incoming I connections to P LPZ E"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_E-IE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-p_lpz_E-IE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-p_lpz_E-IE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-p_lpz_E-IE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-I-to-o_E.png"
set title "Incoming I connections to non LPZ E"
plot  "08-syn_conns-lpz_c_I-to-o_E-IE.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-o_E-IE.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-o_E-IE.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-o_E-IE.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

# incoming E to I neurons
set output "08-syn_conns-E-to-lpz_c_I.png"
set title "Incoming E connections to LPZ C I"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_I-EI.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_c_I-EI.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_c_I-EI.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_c_I-EI.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-E-to-lpz_b_I.png"
set title "Incoming E connections to LPZ B I"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_I-EI.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_b_I-EI.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_b_I-EI.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_b_I-EI.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-E-to-p_lpz_I.png"
set title "Incoming E connections to P LPZ I"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_I-EI.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-p_lpz_I-EI.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-p_lpz_I-EI.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-p_lpz_I-EI.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-E-to-o_I.png"
set title "Incoming E connections to non LPZ I"
plot  "08-syn_conns-lpz_c_E-to-o_I-EI.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-o_I-EI.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-o_I-EI.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-o_I-EI.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

# incoming I to I
set output "08-syn_conns-I-to-lpz_c_I.png"
set title "Incoming I connections to LPZ C I"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_I-II.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_c_I-II.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_c_I-II.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_c_I-II.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-I-to-lpz_b_I.png"
set title "Incoming I connections to LPZ B I"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_I-II.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_b_I-II.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_b_I-II.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_b_I-II.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-I-to-p_lpz_I.png"
set title "Incoming I connections to P LPZ I"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_I-II.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-p_lpz_I-II.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-p_lpz_I-II.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-p_lpz_I-II.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-syn_conns-I-to-o_I.png"
set title "Incoming I connections to non LPZ I"
plot  "08-syn_conns-lpz_c_I-to-o_I-II.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-o_I-II.txt" using 1:2 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-o_I-II.txt" using 1:2 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-o_I-II.txt" using 1:2 with linespoints lw 5 lc 4 title "from non lpz";
