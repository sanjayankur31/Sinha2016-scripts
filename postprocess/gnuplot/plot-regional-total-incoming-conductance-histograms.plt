# Stacked histograms showing incoming connections
# https://stackoverflow.com/questions/10881747/how-to-plot-specific-rows-in-gnuplot
# http://psy.swansea.ac.uk/staff/carter/gnuplot/gnuplot_histograms.htm
# http://gnuplot.sourceforge.net/demo/histograms.8.gnu (8th example)


# Note that I iterate the columns in reverse so that the connections are
# plotted from the outside inwards. This is simply because there are usually
# more connections in the non LPZ regions where there are more neurons.


load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
# set xlabel offset character 0, -1 "Time (seconds)"
set ylabel "Incoming conductances"
set ytics border nomirror
set xtics border nomirror
set border 3
set auto x
# set yrange[0:]
# set format y "%.1tx10^{%T}"
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

## Note that the conductances must be absolute values in the files already. We cannot convert them here.
## LPZ C
set output "081-conductance-rowstacked-histograms-I-to-lpz_c_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-lpz_c_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-I-to-lpz_c_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-lpz_c_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## LPZ B
set output "081-conductance-rowstacked-histograms-I-to-lpz_b_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-lpz_b_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-I-to-lpz_b_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-lpz_b_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## P LPZ
set output "081-conductance-rowstacked-histograms-I-to-p_lpz_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-p_lpz_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-I-to-p_lpz_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-p_lpz_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## O LPZ
set output "081-conductance-rowstacked-histograms-I-to-o_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-o_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-I-to-o_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-rowstacked-histograms-E-to-o_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

# clustered histograms
set style histogram clustered
set style data histograms
set style fill solid 0.75 noborder
set boxwidth 0.6 relative
# bmargin center horizontal is for placement of the key in the graph
# Left reverse is for the placement of the text for each entry
set key bmargin center horizontal Left reverse noenhanced autotitle columnhead nobox height 1.25 maxcols 3

## LPZ C
set output "081-conductance-clustered-histograms-I-to-lpz_c_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-lpz_c_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-I-to-lpz_c_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-lpz_c_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_c_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## LPZ B
set output "081-conductance-clustered-histograms-I-to-lpz_b_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-lpz_b_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-I-to-lpz_b_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-lpz_b_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-lpz_b_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## P LPZ
set output "081-conductance-clustered-histograms-I-to-p_lpz_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-p_lpz_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-I-to-p_lpz_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-p_lpz_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-p_lpz_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## O LPZ
set output "081-conductance-clustered-histograms-I-to-o_I.png"
set title "II"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-o_I.png"
set title "EI"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-I-to-o_E.png"
set title "IE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output "081-conductance-clustered-histograms-E-to-o_E.png"
set title "EE"
plot for [COL=5:2:-1] '081-conductance-incoming-totals-o_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader
