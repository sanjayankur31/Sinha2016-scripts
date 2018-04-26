# Stacked histograms showing incoming connections
# https://stackoverflow.com/questions/10881747/how-to-plot-specific-rows-in-gnuplot
# http://psy.swansea.ac.uk/staff/carter/gnuplot/gnuplot_histograms.htm
load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set lmargin at screen 0.15
set xlabel "Time (seconds)"
set ylabel "Number of incoming synapses"
set ytics border nomirror
set xtics border nomirror
set auto x
set yrange[0:]
set style data histogram
set style histogram rowstacked
set style fill solid border -1
set boxwidth 0.75
set xtic rotate by -90 scale 0

set macro
line_number='int($0)'

set output "081-connection-histograms.png"

plot "08-syn_conns-lpz_b_E-to-lpz_b_E-EE.txt" u 2: ( (@line_number == 1500) ? $1:1/0), \
"08-syn_conns-lpz_c_E-to-lpz_b_E-EE.txt"  u 2: ( (@line_number == 1500) ? $1:1/0), \
"08-syn_conns-o_E-to-lpz_b_E-EE.txt"  u 2: ( (@line_number == 1500) ? $1:1/0), \
"08-syn_conns-p_lpz_E-to-lpz_b_E-EE.txt"  u 2: ( (@line_number == 1500) ? $1:1/0);
