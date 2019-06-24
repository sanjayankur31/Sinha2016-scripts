load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Conductance (nS)"
set ylabel "Number of synapses"
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.15
# set format y "%.1tx10^{%T}"
# set format x "%.1tx10^{%T}"

bin_number(x) = floor(x/bin_width)
rounded(x) = bin_width * (bin_number(x) + bin_width/2)

set title plot_title
set output o_fn
plot in_fn using (rounded(abs($3))):(abs($3)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($3))):(abs($3)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",
