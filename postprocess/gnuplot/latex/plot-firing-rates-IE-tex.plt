# Usage: gnuplot -e 'simulation="...."' plot-firing-rates-IE-tex.plt
load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 5,3
set xlabel "Time (\\(s\\))"
set ylabel "Mean population firing rate (Hz)"
set yrange [0:7]
set border 3
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.15

set output simulation."-mean-firing-rates-lpz_c_I-E-zoomed.tex"
set title ""
plot "mean-firing-rates-lpz_c_I.gdf" every 500 with lines ls 6 title "I", "mean-firing-rates-lpz_c_E.gdf" every 500 with lines ls 1  title "E";

set output simulation."-mean-firing-rates-lpz_b_I-E-zoomed.tex"
set title ""
plot "mean-firing-rates-lpz_b_I.gdf" every 500 with lines ls 6 title "I", "mean-firing-rates-lpz_b_E.gdf" every 500 with lines ls 1  title "E";

set output simulation."-mean-firing-rates-p_lpz_I-E-zoomed.tex"
set title ""
plot "mean-firing-rates-p_lpz_I.gdf" every 500 with lines ls 6 title "I", "mean-firing-rates-p_lpz_E.gdf" every 500 with lines ls 1  title "E";

set output simulation."-mean-firing-rates-o_I-E-zoomed.tex"
set title ""
plot "mean-firing-rates-o_I.gdf" every 500 with lines ls 6 title "I", "mean-firing-rates-o_E.gdf" every 500 with lines ls 1  title "E";

