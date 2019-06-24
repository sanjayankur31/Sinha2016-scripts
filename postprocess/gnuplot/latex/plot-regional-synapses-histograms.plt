# Stacked histograms showing incoming connections
# https://stackoverflow.com/questions/10881747/how-to-plot-specific-rows-in-gnuplot
# http://psy.swansea.ac.uk/staff/carter/gnuplot/gnuplot_histograms.htm
# http://gnuplot.sourceforge.net/demo/histograms.8.gnu (8th example)


# Note that I iterate the columns in reverse so that the connections are
# plotted from the outside inwards. This is simply because there are usually
# more connections in the non LPZ regions where there are more neurons.

# For the LaTeX output, one needs to fix the labels, since they have double subscripts and so on. These are read from the data files.

load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 5,3
set lmargin at screen 0.15
set xlabel "Time (\\(s\\))"
set ylabel "Number of incoming synapses"
set ytics border nomirror
set xtics border nomirror
set border 3
set auto x
# set yrange[0:]
set format y "\\(%.1tx10^{%T}\\)"
set xtics rotate out

# rowstacked histograms
set style histogram rowstacked
set style data histograms
set style fill solid 0.75 noborder
set boxwidth 0.6 relative
# bmargin center horizontal is for placement of the key in the graph
# Left reverse is for the placement of the text for each entry
set key bmargin center horizontal Left reverse noenhanced autotitle columnhead nobox height 1.25 maxcols 3

## LPZ C
set output simid."-081-connection-rowstacked-histograms-I-to-lpz_c_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-lpz_c_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-I-to-lpz_c_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-lpz_c_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## LPZ B
set output simid."-081-connection-rowstacked-histograms-I-to-lpz_b_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-lpz_b_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-I-to-lpz_b_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-lpz_b_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## P LPZ
set output simid."-081-connection-rowstacked-histograms-I-to-p_lpz_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-p_lpz_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-I-to-p_lpz_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-p_lpz_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## O LPZ
set output simid."-081-connection-rowstacked-histograms-I-to-o_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-o_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-I-to-o_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-rowstacked-histograms-E-to-o_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

# clustered histograms
set style histogram clustered
set style data histograms
set style fill solid 0.75 noborder
set boxwidth 0.6 relative
# bmargin center horizontal is for placement of the key in the graph
# Left reverse is for the placement of the text for each entry
set key bmargin center horizontal Left reverse noenhanced autotitle columnhead nobox height 1.25 maxcols 3

## LPZ C
set output simid."-081-connection-clustered-histograms-I-to-lpz_c_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-lpz_c_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-I-to-lpz_c_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-lpz_c_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_c_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## LPZ B
set output simid."-081-connection-clustered-histograms-I-to-lpz_b_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-lpz_b_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-I-to-lpz_b_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-lpz_b_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-lpz_b_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## P LPZ
set output simid."-081-connection-clustered-histograms-I-to-p_lpz_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-p_lpz_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-I-to-p_lpz_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-p_lpz_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-p_lpz_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

## O LPZ
set output simid."-081-connection-clustered-histograms-I-to-o_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_I-II.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-o_I.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_I-EI.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-I-to-o_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_E-IE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader

set output simid."-081-connection-clustered-histograms-E-to-o_E.tex"
plot for [COL=5:2:-1] '081-syn_conns-incoming-totals-o_E-EE.txt' every 4 using COL:xtic(1) lc COL-1 title columnheader
