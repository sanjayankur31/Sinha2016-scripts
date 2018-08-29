load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/neuron-locations.pal'
set xlabel "Time (\\(s\\))"
set ylabel "\\(g (nS)\\)"
set term epslatex color size 5,3
set lmargin at screen 0.15
set yrange [0:]

# Total E to E
set output simid."-08-total-conductances-E-to-lpz_c_E.tex"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-lpz_c_E-EE.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-E-to-lpz_b_E.tex"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-lpz_b_E-EE.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-E-to-p_lpz_E.tex"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-p_lpz_E-EE.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-E-to-o_E.tex"
plot  "08-syn_conns-lpz_c_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-o_E-EE.txt" using 1:3 with linespoints lw 5  title "From others";

# Total I to E
set output simid."-08-total-conductances-I-to-lpz_c_E.tex"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-lpz_c_E-IE.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-I-to-lpz_b_E.tex"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-lpz_b_E-IE.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-I-to-p_lpz_E.tex"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-p_lpz_E-IE.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-I-to-o_E.tex"
plot  "08-syn_conns-lpz_c_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-o_E-IE.txt" using 1:3 with linespoints lw 5  title "From others";

# Total E to I
set output simid."-08-total-conductances-E-to-lpz_c_I.tex"
plot  "08-syn_conns-lpz_c_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-lpz_c_I-EI.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-E-to-lpz_b_I.tex"
plot  "08-syn_conns-lpz_c_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-lpz_b_I-EI.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-E-to-p_lpz_I.tex"
plot  "08-syn_conns-lpz_c_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-p_lpz_I-EI.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-E-to-o_I.tex"
plot  "08-syn_conns-lpz_c_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_E-to-o_I-EI.txt" using 1:3 with linespoints lw 5  title "From others";

# Total I to I
set output simid."-08-total-conductances-I-to-lpz_c_I.tex"
plot  "08-syn_conns-lpz_c_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-lpz_c_I-II.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-I-to-lpz_b_I.tex"
plot  "08-syn_conns-lpz_c_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-lpz_b_I-II.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-I-to-p_lpz_I.tex"
plot  "08-syn_conns-lpz_c_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-p_lpz_I-II.txt" using 1:3 with linespoints lw 5  title "From others";

set output simid."-08-total-conductances-I-to-o_I.tex"
plot  "08-syn_conns-lpz_c_I-to-o_I-II.txt" using 1:3 with linespoints lw 5  title "From LPZ C", "08-syn_conns-lpz_b_I-to-o_I-II.txt" using 1:3 with linespoints lw 5 lc 8 title "From LPZ B",  "08-syn_conns-p_lpz_I-to-o_I-II.txt" using 1:3 with linespoints lw 5  title "From Peri-LPZ", "08-syn_conns-o_I-to-o_I-II.txt" using 1:3 with linespoints lw 5  title "From others";
