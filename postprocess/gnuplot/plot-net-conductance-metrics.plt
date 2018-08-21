load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time in seconds"
set ylabel "Conductance (nS)"
set lmargin at screen 0.15

# Net region wise E
set output "08-net-regional-conductances-to-lpz_c_E.png"
set title "Incoming regional net conductance to LPZ C E"
plot  "081-conductance-net-lpz_c_E.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-lpz_c_E.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-lpz_c_E.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-lpz_c_E.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-net-regional-conductances-to-lpz_b_E.png"
set title "Incoming regional net conductance to LPZ B E"
plot  "081-conductance-net-lpz_b_E.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-lpz_b_E.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-lpz_b_E.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-lpz_b_E.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-net-regional-conductances-to-p_lpz_E.png"
set title "Incoming regional net conductance to peri LPZ E"
plot  "081-conductance-net-p_lpz_E.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-p_lpz_E.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-p_lpz_E.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-p_lpz_E.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-net-regional-conductances-to-o_E.png"
set title "Incoming regional net conductance to other E neurons"
plot  "081-conductance-net-o_E.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-o_E.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-o_E.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-o_E.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

# Net region wise I
set output "08-net-regional-conductances-to-lpz_c_I.png"
set title "Incoming regional net conductance to LPZ C I"
plot  "081-conductance-net-lpz_c_I.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-lpz_c_I.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-lpz_c_I.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-lpz_c_I.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-net-regional-conductances-to-lpz_b_I.png"
set title "Incoming regional net conductance to LPZ B I"
plot  "081-conductance-net-lpz_b_I.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-lpz_b_I.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-lpz_b_I.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-lpz_b_I.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-net-regional-conductances-to-p_lpz_I.png"
set title "Incoming regional net conductance to peri LPZ I"
plot  "081-conductance-net-p_lpz_I.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-p_lpz_I.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-p_lpz_I.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-p_lpz_I.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

set output "08-net-regional-conductances-to-o_I.png"
set title "Incoming regional net conductance to other I neurons"
plot  "081-conductance-net-o_I.txt" using 1:2 with linespoints lw 5 lc 1 title "from lpz c", "081-conductance-net-o_I.txt" using 1:3 with linespoints lw 5 lc 2 title "from lpz b",  "081-conductance-net-o_I.txt" using 1:4 with linespoints lw 5 lc 3 title "from peri lpz", "081-conductance-net-o_I.txt" using 1:5 with linespoints lw 5 lc 4 title "from non lpz";

# Net totals E
set output "08-net-conductances-to-lpz_c_E.png"
set title "Incoming net conductance to LPZ C E"
plot  "081-conductance-net-lpz_c_E.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

set output "08-net-conductances-to-lpz_b_E.png"
set title "Incoming net conductance to LPZ B E"
plot  "081-conductance-net-lpz_b_E.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

set output "08-net-conductances-to-p_lpz_E.png"
set title "Incoming net conductance to peri LPZ E"
plot  "081-conductance-net-p_lpz_E.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

set output "08-net-conductances-to-o_E.png"
set title "Incoming net conductance to other E neurons"
plot  "081-conductance-net-o_E.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

# Net totals I
set output "08-net-conductances-to-lpz_c_I.png"
set title "Incoming net conductance to LPZ C I"
plot  "081-conductance-net-lpz_c_I.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

set output "08-net-conductances-to-lpz_b_I.png"
set title "Incoming net conductance to LPZ B I"
plot  "081-conductance-net-lpz_b_I.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

set output "08-net-conductances-to-p_lpz_I.png"
set title "Incoming net conductance to peri LPZ I"
plot  "081-conductance-net-p_lpz_I.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

set output "08-net-conductances-to-o_I.png"
set title "Incoming net conductance to other I neurons"
plot  "081-conductance-net-o_I.txt" using 1:($2+$3+$4+$5) with linespoints lw 5 lc 1;

# Slope of net conductance E
set ylabel "Rate of change of conductance (delta g/t)"

set output "08-net-conductances-slope-to-lpz_c_E.png"
set title "Incoming net conductance to LPZ C E"
plot  "081-conductance-net-lpz_c_E.txt" using 1:6 with linespoints lw 5 lc 1;

set output "08-net-conductances-slope-to-lpz_b_E.png"
set title "Rate of change of incoming net conductance to LPZ B E"
plot  "081-conductance-net-lpz_b_E.txt" using 1:6 with linespoints lw 5 lc 1;

set output "08-net-conductances-slope-to-p_lpz_E.png"
set title "Rate of change of incoming net conductance to peri LPZ E"
plot  "081-conductance-net-p_lpz_E.txt" using 1:6 with linespoints lw 5 lc 1;

set output "08-net-conductances-slope-to-o_E.png"
set title "Rate of change of incoming net conductance to other E neurons"
plot  "081-conductance-net-o_E.txt" using 1:6 with linespoints lw 5 lc 1;

# Slope of net conductances I
set output "08-net-conductances-slope-to-lpz_c_I.png"
set title "Rate of change of incoming net conductance to LPZ C I"
plot  "081-conductance-net-lpz_c_I.txt" using 1:6 with linespoints lw 5 lc 1;

set output "08-net-conductances-slope-to-lpz_b_I.png"
set title "Rate of change of incoming net conductance to LPZ B I"
plot  "081-conductance-net-lpz_b_I.txt" using 1:6 with linespoints lw 5 lc 1;

set output "08-net-conductances-slope-to-p_lpz_I.png"
set title "Rate of change of incoming net conductance to peri LPZ I"
plot  "081-conductance-net-p_lpz_I.txt" using 1:6 with linespoints lw 5 lc 1;

set output "08-net-conductances-slope-to-o_I.png"
set title "incoming net conductance to other I neurons"
plot  "081-conductance-net-o_I.txt" using 1:6 with linespoints lw 5 lc 1;
