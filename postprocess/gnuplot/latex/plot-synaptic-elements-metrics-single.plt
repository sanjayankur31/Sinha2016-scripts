load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term epslatex color size 25cm, 14cm font 30
set xlabel "Time (s)"
set xtics border nomirror
unset bmargin
unset lmargin
unset rmargin
unset tmargin
set border 3

unset grid
unset ytics
set ytics border nomirror 50
set xtics border nomirror 3000
set xrange [:10500]

set output "test.tex"
set arrow from first 3500, -60 to first 3500, 150 nohead
set label "A" at first 3300, 165
set arrow from first 5000, -60 to first 5000, 150 nohead
set label "B" at first 4800, 165
set arrow from first 7500, -60 to first 7500, 150 nohead
set label "C" at first 7300, 165
set key inside samplen 1
set ylabel "(nS)"
set title ""
plot "05-se-all-lpz_c_E.txt" using ($1/1000):($5*0.5) with lines lw 10 lc 6 title "E", "05-se-all-lpz_c_E.txt" using ($1/1000):($7*3) with lines lw 10 lc 7 title "I", "05-se-all-lpz_c_E.txt" using ($1/1000):(($5*0.5)-($7*3)) with lines lw 10 lc 2 title "Net";
