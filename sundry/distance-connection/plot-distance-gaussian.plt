load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920, 1080
# define the functions
f(d,sigma)= (2*exp(-(d**2)/(2*(sigma**2.0)))/(sigma*((2*3.1415)**0.5)))
fbutz(d,maxp,sigma)= (maxp*exp(-(d**2)/((sigma**2.0))))
# cdf(d,sigma)= (erf(d/(sigma * 1.414)))


xmax=2500
# provide mult as input
sig=mult*150
# provide maxp as input too

set lmargin at screen 0.15
set y2tics
set xtics
set ytics nomirror

set xrange[0:xmax]

# set output "connection-gaussian-".sig."-p-E.png"
# set title "Sigma = ".sig
# set xlabel "d (micro meter)"
# set ylabel "p"
# set y2label "N"
# plot [x=0:xmax] f(x, sig) w lines lw 6 title 'p', 'neurons-in-range.txt' with lines lw 6 title "N" axes x1y2

set output "connection-gaussian-butz-".maxp."-".sig."-p-E.png"
set title "Sigma = ".sig
set xlabel "d (micro meter)"
set ylabel "p"
set y2label "N"
plot [x=0:xmax] fbutz(x, maxp, sig) w lines lw 6 title 'p', 'neurons-in-range.txt' with lines lw 6 title "N" axes x1y2
