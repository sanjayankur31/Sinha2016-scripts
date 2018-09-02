load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920, 1080
# define the function
f(d,sigma)= (2*exp(-(d**2)/(2*(sigma**2.0)))/(sigma*((2*3.1415)**0.5)))
fbutz(d,sigma)= (exp(-(d**2)/((sigma**2.0))))
cdf(d,sigma)= (erf(d/(sigma * 1.414)))
n(d)= (3.1415*(d/150)**2)

xmax=1500
sig=5*150

set ytics nomirror
set y2tics
set xtics 0, 300

set output "connection-gaussian-p-E.png"
set title ""
set xlabel "d (micro meter)"
set ylabel "p"
set y2label "N"
plot [x=0:xmax] f(x, sig) w lines lw 6 title 'p', [x=0:xmax] n(x) w lines lw 6 title 'Neurons' axes x1y2, 0.02 title "";

set output "connection-gaussian-cdf-E.png"
set title ""
set xlabel "d (micro meter)"
set ylabel "p"
set y2label "N"
plot [x=0:xmax] cdf(x, sig) w lines lw 6 title 'cdf', [x=0:xmax] n(x) w lines lw 6 title 'Neurons' axes x1y2, 0.02 title "";

set output "connection-gaussian-butz-p-E.png"
set title ""
set xlabel "d (micro meter)"
set ylabel "p"
set y2label "N"
plot [x=0:xmax] fbutz(x, sig) w lines lw 6 title 'p', [x=0:xmax] n(x) w lines lw 6 title 'Neurons' axes x1y2, 0.02 title "";
