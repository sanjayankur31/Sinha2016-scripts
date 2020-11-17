load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "std firing rate of neurons (Hz)"
set yrange [0:2]
set ytics border 0.5
set xtics border nomirror
set lmargin at screen 0.15

set output "std-firing-rates-I-E.png"
set title "std firing rate for neurons"
plot "std-firing-rates-I.gdf" with lines ls 6 title "I", "std-firing-rates-E.gdf" with lines  ls 1 title "E";

set output "std-firing-rates-I-E-zoomed.png"
set title "std firing rate for neurons"
plot "std-firing-rates-I.gdf" with lines ls 6 title "I", "std-firing-rates-E.gdf" with lines ls 1  title "E";

set output "std-firing-rates-lpz_c_I-E-zoomed.png"
set title "std firing rate for lpz neurons"
plot "std-firing-rates-lpz_c_I.gdf" with lines ls 6 title "lpz center I", "std-firing-rates-lpz_c_E.gdf" with lines ls 1  title "lpz center E";

set output "std-firing-rates-lpz_b_I-E-zoomed.png"
set title "std firing rate for lpz neurons"
plot "std-firing-rates-lpz_b_I.gdf" with lines ls 6 title "lpz border I", "std-firing-rates-lpz_b_E.gdf" with lines ls 1  title "lpz border E";

set output "std-firing-rates-p_lpz_I-E-zoomed.png"
set title "std firing rate for lpz neurons"
plot "std-firing-rates-p_lpz_I.gdf" with lines ls 6 title "peri lpz I", "std-firing-rates-p_lpz_E.gdf" with lines ls 1  title "peri lpz E";

set output "std-firing-rates-o_I-E-zoomed.png"
set title "std firing rate for lpz neurons"
plot "std-firing-rates-o_I.gdf" with lines ls 6 title "non lpz I", "std-firing-rates-o_E.gdf" with lines ls 1  title "non lpz E";

set output "std-firing-rates-all-E-zoomed.png"
set title "std firing rate for neurons in various regions"
plot "std-firing-rates-lpz_c_E.gdf" with lines ls 1  title "lpz center E", "std-firing-rates-lpz_b_E.gdf" with lines ls 3  title "lpz border E", "std-firing-rates-p_lpz_E.gdf" with lines ls 5  title "peri lpz E", "std-firing-rates-o_E.gdf" with lines ls 6  title "non lpz E";

set output "std-firing-rates-all-I-zoomed.png"
set title "std firing rate for neurons in various regions"
plot "std-firing-rates-lpz_c_I.gdf" with lines ls 1  title "lpz center I", "std-firing-rates-lpz_b_I.gdf" with lines ls 3  title "lpz border I", "std-firing-rates-p_lpz_I.gdf" with lines ls 5  title "peri lpz I", "std-firing-rates-o_I.gdf" with lines ls 6 title "non lpz I";

set xrange [3990:4010]
set output "std-firing-rates-I-E-deaff-zoomed.png"
set title "std firing rate for neurons near deaff"
plot "std-firing-rates-I.gdf" with lines ls 6  title "I", "std-firing-rates-E.gdf" with lines ls 1  title "E";
