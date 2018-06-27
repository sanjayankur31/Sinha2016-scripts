load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term epslatex color size 20cm, 10cm font 30
set xlabel "Time (s)"
set xtics border nomirror
unset bmargin
unset lmargin
unset rmargin
set border 3

unset grid
unset ytics
set ytics border nomirror 40
set xtics border nomirror 3000

set output "test.tex"
set ylabel "(nS)"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):($5*0.5) with linespoints lw 5 title "E", "05-se-all-lpz_c_E.txt" using ($1/1000):($7*3) with linespoints lw 5 title "I", "05-se-all-lpz_c_E.txt" using ($1/1000):(($5*0.5)-($7*3)) with linespoints lw 5 title "Net";
