set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "NeuronID"
set ylabel "Synaptic elements"
set ytics border nomirror
set xtics border nomirror
set yrange [0:]

set output plotname
set title plottitle
plot inputfile using 1:2 with points lw 2 title "Ax", inputfile using 1:3 with points lw 2 title "Connected Ax", inputfile using 1:4 with points lw 2 title "Total Ex D", inputfile using 1:5 with points lw 2 title "Connected Ex D", inputfile using 1:6 with points lw 2 title "Total In d", inputfile using 1:7 with points lw 2 title "Connected In d";
