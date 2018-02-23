load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "SNR"
set yrange [0:]
set xtics border nomirror 50
set lmargin at screen 0.15

outfile = "SNR-patterns.png"
set output outfile
set title "SNR for various patterns"
plot for [pat=1:numpats+0] '00-SNR-pattern-'.pat.'.txt' with points pointtype pat lw 15 title 'P-'.pat
