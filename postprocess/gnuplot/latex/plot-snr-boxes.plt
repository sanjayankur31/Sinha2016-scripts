load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,2.5
set xlabel "\\% Overlap"
set ylabel "SNR"
set border 3
set ytics border nomirror autofreq 5
set xtics border nomirror
set xtics ("$5$" 5, "$10$" 10, "$20$" 20, "$30$" 30)
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [0:5]
set xrange [0:35]
set key inside center top horizontal

set boxwidth 3 absolute
set style fill solid 0.6

set output "SNR-vs-overlap-no-deaff.tex"
set title ""
plot \
    "snr-vs-overlap-no-deaff.txt" using 1:2:3 with boxerrorbars title "";
