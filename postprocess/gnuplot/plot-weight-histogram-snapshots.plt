load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Conductance (nS)"
set ylabel "Number of synapses"
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.15
set xrange [0:]
# set format y "%.1tx10^{%T}"
# set format x "%.1tx10^{%T}"

bin_width = 100.
bin_number(x) = floor(x/bin_width)
rounded(x) = bin_width * ( bin_number(x) + 0.5)

#set boxwidth 200 absolute
set style fill solid 1.0 noborder
set title plot_title
set output o_fn
plot i_fn using (rounded($3)):(3) smooth frequency with boxes title ""

