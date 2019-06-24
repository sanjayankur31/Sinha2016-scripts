load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/neuron-locations.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1440, 1920
set size ratio -1
set xrange [0:]
set yrange [0:]
set auto fix
set offsets graph 0.05, graph 0.05, graph 0.05, graph 0.05

set xlabel "Extent (micro meter)"
set ylabel rotate by 90 "Extent (micro meter)"

set key outside bottom horizontal

set output "00-locations-E.png"
set title "Eitatory neurons"
plot "00-locations-lpz_c_E.txt" using 2:3 with points pt 7 title "LPZ C", "00-locations-lpz_b_E.txt" using 2:3 with points pt 5 lc 8 title "LPZ B", "00-locations-p_lpz_E.txt" using 2:3 with points pt 9 title "Peri LPZ", "00-locations-o_E.txt" using 2:3 with points pt 13 lc 7 title "Other";

set output "00-locations-I.png"
set title "Iibitory neurons"
plot "00-locations-lpz_c_I.txt" using 2:3 with points ps 2 pt 7 title "LPZ C", "00-locations-lpz_b_I.txt" using 2:3 with points ps 2 pt 5 lc 8 title "LPZ B", "00-locations-p_lpz_I.txt" using 2:3 with points ps 2 pt 9 title "Peri LPZ", "00-locations-o_I.txt" using 2:3 with points ps 2 pt 13 lc 7 title "Other";
