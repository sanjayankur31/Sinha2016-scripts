# load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,2.5
set xlabel "\\% Overlap"
set ylabel "SNR"
set border 3
set ytics border nomirror autofreq 1
set xtics border nomirror
set xtics ("$5$" 5, "$10$" 10, "$20$" 15, "$30$" 20)
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [0:5]
set xrange [0:25]
set key inside center top horizontal

set boxwidth 2.0 absolute

set output "SNR-vs-overlap-deaff-no-repair.tex"
set title ""
plot \
    "snr-vs-overlap-no-deaff.txt" using ($2-1.0):3:4 with boxerrorbars fill solid 0.6 title "Before", \
    "snr-vs-overlap-deaff-no-repair.txt" using ($2+1.0):3:4 with boxerrorbars fill pattern 2 title "After";


set output "SNR-vs-overlap-no-deaff.tex"
set title ""
plot \
    "snr-vs-overlap-no-deaff.txt" using 2:3:4 with boxerrorbars fill solid 0.6 title "";

set boxwidth 2.0 absolute
set ylabel "Firing rate (Hz)"
set ytics border nomirror autofreq 20
set xtics ("$5$" 10, "$10$" 20, "$20$" 30, "$30$" 40)
set yrange [0:70]
set xrange [0:50]
set output "firing-rates-p-b-in-out-lpz-vs-overlap-no-deaff.tex"
set title ""
plot \
    "hz-vs-overlap-no-deaff.txt" using ($2-3.0):3:4 with boxerrorbars fill solid 0.6 title "Pattern", \
    "hz-vs-overlap-no-deaff.txt" using ($2-1.0):7:8 with boxerrorbars fill pattern 2 title "Pattern in LPZ", \
    "hz-vs-overlap-no-deaff.txt" using ($2+1.0):9:10 with boxerrorbars fill pattern 4 title "Pattern outside LPZ", \
    "hz-vs-overlap-no-deaff.txt" using ($2+3.0):5:6 with boxerrorbars fill pattern 5 title "Background";
