set term pngcairo font "OpenSans, 28" size 1920,1028

v=0.0001
etad=0.1
etaa=0.4
epsilon=0.7

xid=(etad+epsilon)/2.0
xia=(etaa+epsilon)/2.0

zetad=(etad-epsilon)/1.6651092223153954
zetaa=(etaa-epsilon)/1.6651092223153954
dzdt(x, zeta, xi)= (v * ((2.0 * exp(-(((x - xi)/zeta)**2.0))) - 1.0))

set output 'Butz-growth-curves.png'
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "eta_d" at 0.1, -0.000018
set label "eta_a" at 0.4, -0.000018
set label "epsilon" at 0.7, -0.000018
set arrow from 0.1, -0.0001 to 0.1, 0.0001 nohead
set arrow from 0.4, -0.0001 to 0.4, 0.0001 nohead
set arrow from 0.7, -0.0001 to 0.7, 0.0001 nohead
set xtics 0.1
plot [x=0:1] dzdt(x, zetad, xid) w lines lw 2 title 'Dendritic', [x=0:1] dzdt(x, zetaa, xia) w lines lw 2 title 'Axonal', 0 title "";
