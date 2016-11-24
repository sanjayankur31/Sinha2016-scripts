set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Synaptic elements"
set ytics border nomirror
set xtics border nomirror
set yrange [0:]

set output "02-synaptic-elements-totals-all-E.png"
set title "Total synaptic elements for E neurons"
plot "02-synaptic-elements-totals-E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "02-axonal-elements-totals-E.png"
set title "Axonal synaptic elements for E neurons"
plot "02-synaptic-elements-totals-E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax";

set output "02-dendritic-elements-totals-E.png"
set title "Dendritic synaptic elements for E neurons"
plot "02-synaptic-elements-totals-E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "02-synaptic-elements-totals-all-I.png"
set title "Total synaptic elements for I neurons"
plot "02-synaptic-elements-totals-I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "02-axonal-elements-totals-I.png"
set title "Axonal synaptic elements for I neurons"
plot "02-synaptic-elements-totals-I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax";

set output "02-dendritic-elements-totals-I.png"
set title "Dendritic synaptic elements for I neurons"
plot "02-synaptic-elements-totals-I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "02-dendritic-elements-totals-all.png"
set title "Total dendritic elements"
plot "02-synaptic-elements-totals-E-all.txt" using ($1/1000):4 with linespoints lw 5 title "total ex-ex", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex-ex", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total ex-in", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected ex-in", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):4 with linespoints lw 5 title "total in-ex", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected in-ex", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in-in", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in-in"; 

set output "02-axonal-elements-totals-all.png"
set title "Total axonal elements"
plot "02-synaptic-elements-totals-E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ex-ax", "02-synaptic-elements-totals-E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ex-ax", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total in-ax", "02-synaptic-elements-totals-I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected in-ax";
