load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time in seconds"
set ylabel "Conductance (nS)"
set lmargin at screen 0.15

# Total E to E
set output "08-total-conductances-E-to-lpz_c_E.png"
set title "Incoming E total conductances to LPZ C E"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-E-to-lpz_b_E.png"
set title "Incoming E total conductances to LPZ B E"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-E-to-p_lpz_E.png"
set title "Incoming E total conductances to P LPZ E"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-E-to-o_E.png"
set title "Incoming E total conductances to non LPZ E"
plot  "08-syn_conns-lpz_c_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

# Total I to E
set output "08-total-conductances-I-to-lpz_c_E.png"
set title "Incoming I total conductances to LPZ C E"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-I-to-lpz_b_E.png"
set title "Incoming I total conductances to LPZ B E"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-I-to-p_lpz_E.png"
set title "Incoming I total conductances to P LPZ E"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-I-to-o_E.png"
set title "Incoming I total conductances to non LPZ E"
plot  "08-syn_conns-lpz_c_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

# Total E to I
set output "08-total-conductances-E-to-lpz_c_I.png"
set title "Incoming E total conductances to LPZ C I"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-E-to-lpz_b_I.png"
set title "Incoming E total conductances to LPZ B I"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-E-to-p_lpz_I.png"
set title "Incoming E total conductances to P LPZ I"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-E-to-o_I.png"
set title "Incoming E total conductances to non LPZ I"
plot  "08-syn_conns-lpz_c_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

# Total I to I
set output "08-total-conductances-I-to-lpz_c_I.png"
set title "Incoming I total conductances to LPZ C I"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-I-to-lpz_b_I.png"
set title "Incoming I total conductances to LPZ B I"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-I-to-p_lpz_I.png"
set title "Incoming I total conductances to P LPZ I"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-total-conductances-I-to-o_I.png"
set title "Incoming I total conductances to non LPZ I"
plot  "08-syn_conns-lpz_c_I-to-o_I-II.txt" using 1:3 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-o_I-II.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-o_I-II.txt" using 1:3 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-o_I-II.txt" using 1:3 with linespoints lw 5 lc 4 title "from non lpz";

# Mean E to E
set output "08-mean-conductances-E-to-lpz_c_E.png"
set title "Incoming E mean conductances to LPZ C E"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_E-EE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_c_E-EE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_c_E-EE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_c_E-EE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-E-to-lpz_b_E.png"
set title "Incoming E mean conductances to LPZ B E"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_E-EE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_b_E-EE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_b_E-EE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_b_E-EE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-E-to-p_lpz_E.png"
set title "Incoming E mean conductances to P LPZ E"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_E-EE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-p_lpz_E-EE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-p_lpz_E-EE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-p_lpz_E-EE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-E-to-o_E.png"
set title "Incoming E mean conductances to non LPZ E"
plot  "08-syn_conns-lpz_c_E-to-o_E-EE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-o_E-EE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-o_E-EE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-o_E-EE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

# Mean I to E
set output "08-mean-conductances-I-to-lpz_c_E.png"
set title "Incoming I mean conductances to LPZ C E"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_E-IE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_c_E-IE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_c_E-IE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_c_E-IE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-I-to-lpz_b_E.png"
set title "Incoming I mean conductances to LPZ B E"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_E-IE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_b_E-IE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_b_E-IE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_b_E-IE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-I-to-p_lpz_E.png"
set title "Incoming I mean conductances to P LPZ E"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_E-IE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-p_lpz_E-IE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-p_lpz_E-IE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-p_lpz_E-IE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-I-to-o_E.png"
set title "Incoming I mean conductances to non LPZ E"
plot  "08-syn_conns-lpz_c_I-to-o_E-IE.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-o_E-IE.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-o_E-IE.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-o_E-IE.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

# Mean E to I
set output "08-mean-conductances-E-to-lpz_c_I.png"
set title "Incoming E mean conductances to LPZ C I"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_I-EI.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_c_I-EI.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_c_I-EI.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_c_I-EI.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-E-to-lpz_b_I.png"
set title "Incoming E mean conductances to LPZ B I"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_I-EI.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-lpz_b_I-EI.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-lpz_b_I-EI.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-lpz_b_I-EI.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-E-to-p_lpz_I.png"
set title "Incoming E mean conductances to P LPZ I"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_I-EI.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-p_lpz_I-EI.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-p_lpz_I-EI.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-p_lpz_I-EI.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-E-to-o_I.png"
set title "Incoming E mean conductances to non LPZ I"
plot  "08-syn_conns-lpz_c_E-to-o_I-EI.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_E-to-o_I-EI.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_E-to-o_I-EI.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_E-to-o_I-EI.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

# Mean I to I
set output "08-mean-conductances-I-to-lpz_c_I.png"
set title "Incoming I mean conductances to LPZ C I"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_I-II.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_c_I-II.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_c_I-II.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_c_I-II.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-I-to-lpz_b_I.png"
set title "Incoming I mean conductances to LPZ B I"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_I-II.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-lpz_b_I-II.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-lpz_b_I-II.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-lpz_b_I-II.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-I-to-p_lpz_I.png"
set title "Incoming I mean conductances to P LPZ I"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_I-II.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-p_lpz_I-II.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-p_lpz_I-II.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-p_lpz_I-II.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-mean-conductances-I-to-o_I.png"
set title "Incoming I mean conductances to non LPZ I"
plot  "08-syn_conns-lpz_c_I-to-o_I-II.txt" using 1:4 with linespoints lw 5 lc 1 title "from lpz c", "08-syn_conns-lpz_b_I-to-o_I-II.txt" using 1:4 with linespoints lw 5 lc 2 title "from lpz b",  "08-syn_conns-p_lpz_I-to-o_I-II.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "08-syn_conns-o_I-to-o_I-II.txt" using 1:4 with linespoints lw 5 lc 4 title "from non lpz";
