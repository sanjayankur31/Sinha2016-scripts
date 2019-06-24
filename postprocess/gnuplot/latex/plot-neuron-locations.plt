load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/neuron-locations.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term epslatex color size 4,4.5

set size ratio -1
set xrange [0:]
set yrange [0:]

set auto fix
set offsets graph 0.05, graph 0.05, graph 0.05, graph 0.05

# set lmargin at screen 0.05
set rmargin 0
set tmargin at screen 1
# set bmargin at screen 0.25

set xlabel "Extent (micro meter)"
set ylabel rotate by 90 "Extent (micro meter)"

set key outside bottom horizontal

set output "00-locations-E.tex"
plot "00-locations-lpz_c_E.txt" using 2:3 with points pt 7 ps 0.3 title "LPZ C", "00-locations-lpz_b_E.txt" using 2:3 with points pt 5 lc 8 ps 0.3 title "LPZ B", "00-locations-p_lpz_E.txt" using 2:3 with points pt 9 ps 0.3 title "Peri LPZ", "00-locations-o_E.txt" using 2:3 with points pt 13 lc 7 ps 0.3 title "Other";

set output "00-locations-I.tex"
plot "00-locations-lpz_c_I.txt" using 2:3 with points pt 7 ps 0.5 title "LPZ C", "00-locations-lpz_b_I.txt" using 2:3 with points pt 5 lc 8 ps 0.5 title "LPZ B", "00-locations-p_lpz_I.txt" using 2:3 with points pt 9 ps 0.5 title "Peri LPZ", "00-locations-o_I.txt" using 2:3 with points pt 13 lc 7 ps 0.5 title "Other";
