set term epslatex color size 4.0,2.5
set border 3
set ytics border nomirror autofreq 50
set xtics border nomirror autofreq 10
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.99
set yrange [0:200]
set key inside center top horizontal
set colorsequence podo

# Set the fill to be transparent
set style fill transparent solid 0.4

set ytics border nomirror autofreq 2
set yrange [0:5]
set xlabel "Number of patterns stored"
set ylabel "SNR"
set output "SNR-multi-clipped-cumulative-kval-5.tex"
set title ""
plot \
"00-mean-std-SNR-k-w-5-clipped.txt" using 1:($2-$3):($2+$3) with filledcurve ls 1 title "", \
"00-mean-std-SNR-k-w-5-clipped.txt" using 1:2 with lines ls 1 lw 5 title "Clipped", \
"00-mean-std-SNR-k-w-5-cumulative.txt" using 1:($2-$3):($2+$3) with filledcurve ls 2 title "", \
"00-mean-std-SNR-k-w-5-cumulative.txt" using 1:2 with lines ls 2 lw 5 title "Cumulative", \
