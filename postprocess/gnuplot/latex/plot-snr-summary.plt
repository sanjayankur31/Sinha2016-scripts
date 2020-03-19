# load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,2.5
set xlabel "Repair progress"
set ylabel "SNR"
set border 3
set ytics border nomirror autofreq 1
set xtics border nomirror
set xtics ("B" 5, "A" 10, "$6500s$" 15, "$10500s$" 20, "$14500s$" 25, "$18500s$" 30, "$22500s$" 35)
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [0:5]
set xrange [0:40]
set key inside center top horizontal

set boxwidth 2.0 absolute
# set style fill pattern

set output "SNR-over-time.tex"
set title ""
plot \
    "snr-over-time-5.txt" using ($2-1.0):3:4 with boxerrorbars fill solid 0.6 title "5\\% Overlap" , \
    "snr-over-time-30.txt" using ($2+1.0):3:4 with boxerrorbars fill pattern 2 title "30\\% Overlap";
