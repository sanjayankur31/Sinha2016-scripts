# Stacked histograms showing incoming connections
# https://stackoverflow.com/questions/10881747/how-to-plot-specific-rows-in-gnuplot
# http://psy.swansea.ac.uk/staff/carter/gnuplot/gnuplot_histograms.htm
# http://gnuplot.sourceforge.net/demo/histograms.8.gnu (8th example)
load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
# set xlabel offset character 0, -1 "Time (seconds)"
set ylabel "Number of incoming synapses"
set ytics border nomirror
set xtics border nomirror
set border 3
set auto x
set yrange[0:]
set xtics rotate out
set lmargin at screen 0.15

# rowstacked histograms
set style histogram rowstacked
set style data histograms
set style fill solid 0.75 noborder
set boxwidth 0.6 relative
# bmargin center horizontal is for placement of the key in the graph
# Left reverse is for the placement of the text for each entry
set key bmargin center horizontal Left reverse noenhanced autotitle columnhead nobox height 1.25 maxcols 3

## LPZ C
set output "081-connection-rowstacked-histograms-lpz_c_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in LPZ C at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-rowstacked-histograms-lpz_c_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in LPZ C at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

## LPZ B
set output "081-connection-rowstacked-histograms-lpz_b_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in LPZ B at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-rowstacked-histograms-lpz_b_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in LPZ B at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

## P LPZ
set output "081-connection-rowstacked-histograms-p_lpz_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in P LPZ at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-rowstacked-histograms-p_lpz_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in P LPZ at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

## O LPZ
set output "081-connection-rowstacked-histograms-o_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in O LPZ at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-rowstacked-histograms-o_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in O LPZ at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

# clustered histograms
set style histogram clustered
set style data histograms
set style fill solid 0.75 noborder
set boxwidth 0.6 relative
# bmargin center horizontal is for placement of the key in the graph
# Left reverse is for the placement of the text for each entry
set key bmargin center horizontal Left reverse noenhanced autotitle columnhead nobox height 1.25 maxcols 3

## LPZ C
set output "081-connection-clustered-histograms-lpz_c_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in LPZ C at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-clustered-histograms-lpz_c_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in LPZ C at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_c_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

## LPZ B
set output "081-connection-clustered-histograms-lpz_b_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in LPZ B at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-clustered-histograms-lpz_b_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in LPZ B at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-lpz_b_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

## P LPZ
set output "081-connection-clustered-histograms-p_lpz_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in P LPZ at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-clustered-histograms-p_lpz_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in P LPZ at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-p_lpz_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot

## O LPZ
set output "081-connection-clustered-histograms-o_I.png"
set multiplot layout 2, 1 title "Incoming connections to I neurons in O LPZ at different times"

set title "II"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_I-II.txt' using COL:xtic(1) title columnheader

set title "EI"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_I-EI.txt' using COL:xtic(1) title columnheader
unset multiplot

set output "081-connection-clustered-histograms-o_E.png"
set multiplot layout 2, 1 title "Incoming connections to E neurons in O LPZ at different times"

set title "IE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_E-IE.txt' using COL:xtic(1) title columnheader

set title "EE"
plot for [COL=2:5] '081-syn_conns-incoming-hist-o_E-EE.txt' using COL:xtic(1) title columnheader
unset multiplot
