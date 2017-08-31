set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Synaptic elements"
set ytics border nomirror
set xtics border nomirror
set yrange [0:]

set output "03-synaptic-elements-totals-all-E.png"
set title "Total synaptic elements for E neurons"
plot "03-synaptic-elements-totals-E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "03-axonal-elements-totals-E.png"
set title "Axonal synaptic elements for E neurons"
plot "03-synaptic-elements-totals-E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax";

set output "03-dendritic-elements-totals-E.png"
set title "Dendritic synaptic elements for E neurons"
plot "03-synaptic-elements-totals-E-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "03-synaptic-elements-totals-all-I.png"
set title "Total synaptic elements for I neurons"
plot "03-synaptic-elements-totals-I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "03-axonal-elements-totals-I.png"
set title "Axonal synaptic elements for I neurons"
plot "03-synaptic-elements-totals-I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ax", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ax";

set output "03-dendritic-elements-totals-I.png"
set title "Dendritic synaptic elements for I neurons"
plot "03-synaptic-elements-totals-I-all.txt" using ($1/1000):4 with linespoints lw 5 title "Total ex d", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex d", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in d", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in d"; 

set output "03-dendritic-elements-totals-all.png"
set title "Total dendritic elements"
plot "03-synaptic-elements-totals-E-all.txt" using ($1/1000):4 with linespoints lw 5 title "total ex-ex", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected ex-ex", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total ex-in", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected ex-in", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):4 with linespoints lw 5 title "total in-ex", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):5 with linespoints lw 5 title "Connected in-ex", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):6 with linespoints lw 5 title "Total in-in", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):7 with linespoints lw 5 title "Connected in-in"; 

set output "03-axonal-elements-totals-all.png"
set title "Total axonal elements"
plot "03-synaptic-elements-totals-E-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total ex-ax", "03-synaptic-elements-totals-E-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected ex-ax", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):2 with linespoints lw 5 title "Total in-ax", "03-synaptic-elements-totals-I-all.txt" using ($1/1000):3 with linespoints lw 5 title "Connected in-ax";
