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

set output "Mean-cumulative-multi-prints.tex"
set title ""
plot \
"00-mean-std-Mean-k-w-5.txt" using 1:($2-$3):($2+$3) with filledcurve ls 1 title "", \
"00-mean-std-Mean-k-w-5.txt" using 1:2 with lines ls 1 lw 5 title "\\(\\chi = 5\\)", \
"00-mean-std-Mean-k-w-6.txt" using 1:($2-$3):($2+$3) with filledcurve ls 2 title "", \
"00-mean-std-Mean-k-w-6.txt" using 1:2 with lines ls 2 lw 5 title "\\(\\chi = 6\\)";

set xlabel "Number of patterns stored"
set ytics border nomirror autofreq 10
set yrange [0:30]
set ylabel "Firing rate (Hz)"
set output "MeanNoise-cumulative-multi-prints.tex"
set title ""
plot \
"00-mean-std-Mean-noise-k-w-5.txt" using 1:($2-$3):($2+$3) with filledcurve ls 1 title "", \
"00-mean-std-Mean-noise-k-w-5.txt" using 1:2 with lines ls 1 lw 5 title "\\(\\chi = 5\\)", \
"00-mean-std-Mean-noise-k-w-6.txt" using 1:($2-$3):($2+$3) with filledcurve ls 2 title "", \
"00-mean-std-Mean-noise-k-w-6.txt" using 1:2 with lines ls 2 lw 5 title "\\(\\chi = 6\\)";

set yrange [0:10]
set ytics border nomirror autofreq 2
set xlabel "Number of patterns stored"
set ylabel "SNR"
set output "SNR-cumulative-multi-prints.tex"
set title ""
plot \
"00-mean-std-SNR-k-w-5.txt" using 1:($2-$3):($2+$3) with filledcurve ls 1 title "", \
"00-mean-std-SNR-k-w-5.txt" using 1:2 with lines ls 1 lw 5 title "\\(\\chi = 5\\)", \
"00-mean-std-SNR-k-w-6.txt" using 1:($2-$3):($2+$3) with filledcurve ls 2 title "", \
"00-mean-std-SNR-k-w-6.txt" using 1:2 with lines ls 2 lw 5 title "\\(\\chi = 6\\)";
