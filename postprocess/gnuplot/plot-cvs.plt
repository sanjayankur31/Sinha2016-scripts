set term pngcairo font "OpenSans, 28" size 1920,1028

set xlabel "Time (seconds)"
set ylabel "CV(ISIs)"
set ytics border nomirror 1
set xtics border nomirror
set yrange[0:5]
set output "ISI-cv-E.png"
set title "CV of ISIs for E neurons"
plot "ISI-cv-E.gdf" with linespoints lw 2 title "E", 1 with lines lw 2 title "1";

set output "ISI-cv-I.png"
set title "CV of ISIs for I neurons"
plot "ISI-cv-I.gdf" with linespoints lw 2 title "I", 1 with lines lw 2 title "1";

