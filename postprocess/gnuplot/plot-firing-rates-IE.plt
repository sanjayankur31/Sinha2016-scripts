load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rate-palette.pal'
set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Mean firing rate of neurons (Hz)"
set yrange [0:200]
set ytics border 20
set xtics border nomirror

set output "firing-rate-E.png"
set title "Firing rate for E neurons"
plot "firing-rate-E.gdf" with lines ls 1 title "E", 3 with lines ls 9 title "T";

set output "firing-rate-I.png"
set title "Firing rate for I neurons"
plot "firing-rate-I.gdf" with lines ls 6 title "I", 3 with lines ls 9 title "T";

set output "firing-rate-I-E.png"
set title "Firing rate for neurons"
plot "firing-rate-I.gdf" with lines ls 6 title "I", "firing-rate-E.gdf" with lines  ls 1 title "E", 3 with lines ls 9 title "T";

set ytics 5
set yrange [0:40]
set output "firing-rate-I-E-zoomed.png"
set title "Firing rate for neurons"
plot "firing-rate-I.gdf" with lines ls 6 title "I", "firing-rate-E.gdf" with lines ls 1  title "E", 3 with lines ls 9 title "T";

set yrange [0:40]
set xrange [3990:4010]
set output "firing-rate-I-E-deaff-zoomed.png"
set title "Firing rate for neurons near deaff"
plot "firing-rate-I.gdf" with lines ls 6  title "I", "firing-rate-E.gdf" with lines ls 1  title "E", 3 with lines ls 9 title "T";
set ytics 20
