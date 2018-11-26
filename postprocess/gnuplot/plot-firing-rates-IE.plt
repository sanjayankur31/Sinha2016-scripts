load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Mean firing rate of neurons (Hz)"
set yrange [0:200]
set ytics border 20
set xtics border nomirror
set lmargin at screen 0.15

set output "mean-firing-rates-I-E.png"
set title "Mean firing rate for neurons"
plot "mean-firing-rates-I.gdf" with lines ls 6 title "I", "mean-firing-rates-E.gdf" with lines  ls 1 title "E";

set ytics 5
set yrange [0:10]
set output "mean-firing-rates-I-E-zoomed.png"
set title "Mean firing rate for neurons"
plot "mean-firing-rates-I.gdf" with lines ls 6 title "I", "mean-firing-rates-E.gdf" with lines ls 1  title "E";

set output "mean-firing-rates-lpz_c_I-E-zoomed.png"
set title "Mean firing rate for lpz neurons"
plot "mean-firing-rates-lpz_c_I.gdf" with lines ls 6 title "lpz center I", "mean-firing-rates-lpz_c_E.gdf" with lines ls 1  title "lpz center E";

set output "mean-firing-rates-lpz_b_I-E-zoomed.png"
set title "Mean firing rate for lpz neurons"
plot "mean-firing-rates-lpz_b_I.gdf" with lines ls 6 title "lpz border I", "mean-firing-rates-lpz_b_E.gdf" with lines ls 1  title "lpz border E";

set output "mean-firing-rates-p_lpz_I-E-zoomed.png"
set title "Mean firing rate for lpz neurons"
plot "mean-firing-rates-p_lpz_I.gdf" with lines ls 6 title "peri lpz I", "mean-firing-rates-p_lpz_E.gdf" with lines ls 1  title "peri lpz E";

set output "mean-firing-rates-o_I-E-zoomed.png"
set title "Mean firing rate for lpz neurons"
plot "mean-firing-rates-o_I.gdf" with lines ls 6 title "non lpz I", "mean-firing-rates-o_E.gdf" with lines ls 1  title "non lpz E";

set output "mean-firing-rates-all-E-zoomed.png"
set title "Mean firing rate for neurons in various regions"
plot "mean-firing-rates-lpz_c_E.gdf" with lines ls 1  title "lpz center E", "mean-firing-rates-lpz_b_E.gdf" with lines ls 3  title "lpz border E", "mean-firing-rates-p_lpz_E.gdf" with lines ls 5  title "peri lpz E", "mean-firing-rates-o_E.gdf" with lines ls 6  title "non lpz E";

set output "mean-firing-rates-all-I-zoomed.png"
set title "Mean firing rate for neurons in various regions"
plot "mean-firing-rates-lpz_c_I.gdf" with lines ls 1  title "lpz center I", "mean-firing-rates-lpz_b_I.gdf" with lines ls 3  title "lpz border I", "mean-firing-rates-p_lpz_I.gdf" with lines ls 5  title "peri lpz I", "mean-firing-rates-o_I.gdf" with lines ls 6 title "non lpz I";

set xrange [3990:4010]
set output "mean-firing-rates-I-E-deaff-zoomed.png"
set title "Mean firing rate for neurons near deaff"
plot "mean-firing-rates-I.gdf" with lines ls 6  title "I", "mean-firing-rates-E.gdf" with lines ls 1  title "E";
set ytics 20
