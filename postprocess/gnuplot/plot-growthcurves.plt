load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920,1028

v=0.0001
#etad=0.1
#etaa=0.4
#epsilon=0.7
#o_fn

xid=(etad+epsilon)/2.0
xia=(etaa+epsilon)/2.0

zetad=(etad-epsilon)/1.6651092223153954
zetaa=(etaa-epsilon)/1.6651092223153954
dzdt(x, zeta, xi)= (v * ((2.0 * exp(-(((x - xi)/zeta)**2.0))) - 1.0))

set output o_fn
set title plot_title
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_d" at (etad + 0.01), 0.00001
set label "{/Symbol h}_a" at (etaa + 0.01), 0.00001
set label "{/Symbol e}" at (epsilon + 0.01), 0.00001
set arrow from etad, -0.0001 to etad, 0.0001 nohead
set arrow from etaa, -0.0001 to etaa, 0.0001 nohead
set arrow from epsilon, -0.0001 to epsilon, 0.0001 nohead
plot [x=0:xmax] dzdt(x, zetad, xid) w lines lw 2 title 'Dendritic', [x=0:xmax] dzdt(x, zetaa, xia) w lines lw 2 title 'Axonal', 0 title "";
