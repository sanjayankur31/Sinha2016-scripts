set term pngcairo font "OpenSans, 28" size 1920,1028
unset yrange
set ytics border nomirror 5
set xlabel "Time (seconds)"
set ylabel "STD(firing rates) (Hz)"
set output "std-firng-rates-E.png"
set title "STD of firing rates for E neurons"
plot "std-firing-rates-E.gdf" with linespoints lw 2 title "E", 5 with lines lw 2 title "5Hz"

set output "std-firing-rates-I.png"
set title "STD of firing rates for I neurons"
plot "std-firing-rates-I.gdf" with linespoints lw 2 title "I", 5 with lines lw 2 title "5Hz"
