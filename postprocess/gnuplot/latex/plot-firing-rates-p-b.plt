# Usage: gnuplot plot-firing-rates-IE-tex.plt
# load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,1.5
set xlabel "Time (\\(\\times 1000s\\))"
set ylabel "Firing rate (Hz)"
set border 3
set ytics border nomirror autofreq 10
set xtics border nomirror 2000 format "%.0s"
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [0:40]
set key inside center top horizontal

simulation="202002101527"

set output simulation."-mean-firing-rates-pattern-zoomed.tex"
set title ""
plot "mean-firing-rates-pattern-1.gdf" every 10 with lines ls 1  title "";

set yrange [0:40]
set output simulation."-mean-firing-rates-pattern-zoomed-outside-lpz.tex"
set title ""
plot "mean-firing-rates-pattern-outside-lpz-1.gdf" every 10 with lines ls 3  title "";

# The two graphs with lesser values
set yrange [0:10]
set ytics border nomirror autofreq 5

set output simulation."-mean-firing-rates-pattern-zoomed-in-lpz.tex"
set title ""
plot "mean-firing-rates-pattern-in-lpz-1.gdf" every 10 with lines ls 2  title "";

set output simulation."-mean-firing-rates-background-zoomed.tex"
set title ""
plot "mean-firing-rates-background-1.gdf" every 10 with lines ls 4  title "";

#
# Slightly more complicated take with an inset: not needed here, but good to know
# Pattern plot
# set output simulation."-mean-firing-rates-pattern-zoomed-in-lpz.tex"
# set multiplot
#
# # first plot
# set title ""
# plot "mean-firing-rates-pattern-in-lpz-1.gdf" every 10 with lines ls 2  title "";
#
# # zoomed in plot
# unset ylabel
# unset xlabel
# set xtics format ""
# set ytics format ""
# unset lmargin
# unset rmargin
# unset tmargin
# set origin 0.1, 0.5
# set size 0.95, 0.6
# set xrange [6000:]
# set yrange [0:10]
# plot "mean-firing-rates-pattern-in-lpz-1.gdf" with lines ls 2  title "";
# unset multiplot
#
# # Background plot
# reset
#
# # Slightly more complicated
# set output simulation."-mean-firing-rates-background-zoomed.tex"
# set term epslatex color size 4.0,1.5
# set xlabel "Time (\\(\\times 1000s\\))"
# set ylabel "Firing rate (Hz)"
# set border 3
# set ytics border nomirror autofreq 10
# set xtics border nomirror 2000 format "%.0s"
# set lmargin at screen 0.01
# set rmargin at screen 1.0
# set tmargin at screen 0.99
# set yrange [0:40]
# set key inside center top horizontal
# set multiplot
#
# # First plot
# set title ""
# plot "mean-firing-rates-background-1.gdf" every 10 with lines ls 4  title "";
#
# # zoomed in plot
# unset ylabel
# unset xlabel
# set xtics format ""
# set ytics format ""
# unset lmargin
# unset rmargin
# unset tmargin
# set origin 0.1, 0.5
# set size 0.95, 0.6
# set xrange [6000:]
# set yrange [0:10]
# plot "mean-firing-rates-background-1.gdf" with lines ls 4  title "";
# unset multiplot
