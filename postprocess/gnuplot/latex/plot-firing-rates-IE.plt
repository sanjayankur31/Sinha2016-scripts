# Usage: gnuplot plot-firing-rates-IE-tex.plt
load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 5,1.5
set xlabel "Time (\\(s\\))"
set ylabel "Mean firing rate (Hz)"
set border 3
set ytics border nomirror autofreq 2
set xtics border nomirror
set lmargin at screen 0.01
set yrange [0:6]

simulation="201811221433"

set arrow nohead from first 1500, first -0.5 to first 1500, first 7 ls 0 lw 2 dt 2
set arrow nohead from first 2000, first -0.5 to first 2000, first 7 ls 0 lw 2 dt 2
set arrow nohead from first 4000, first -0.5 to first 4000, first 7 ls 0 lw 2 dt 2
set arrow nohead from first 6000, first -0.5 to first 6000, first 7 ls 0 lw 2 dt 2

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

