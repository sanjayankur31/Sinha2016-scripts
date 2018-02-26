load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920, 1080

# define the function
dzdt(x, zeta, xi)= (v * ((2.0 * exp(-(((x - xi)/zeta)**2.0))) - 1.0))

nuE=system("grep 'nuE' 99-simulation_params.txt | sed 's/^.*: //'")
epsilonE=system("grep 'epsilonE' 99-simulation_params.txt | sed 's/^.*: //'")
etaaE=system("grep 'etaaE' 99-simulation_params.txt | sed 's/^.*: //'")
etadE=system("grep 'etadE' 99-simulation_params.txt | sed 's/^.*: //'")
nuI=system("grep 'nuI' 99-simulation_params.txt | sed 's/^.*: //'")
epsilonI=system("grep 'epsilonI' 99-simulation_params.txt | sed 's/^.*: //'")
etaaI=system("grep 'etaaI' 99-simulation_params.txt | sed 's/^.*: //'")
etadI=system("grep 'etadI' 99-simulation_params.txt | sed 's/^.*: //'")


xid=(etadE+epsilonE)/2.0
xia=(etaaE+epsilonE)/2.0

zetadE=(etadE-epsilonE)/1.6651092223153954
zetaaE=(etaaE-epsilonE)/1.6651092223153954

set output "growth-curves-E.png"
set title "Growth curves for E neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_d" at (etadE + 0.01), 0.00001
set label "{/Symbol h}_a" at (etaaE + 0.01), 0.00001
set label "{/Symbol e}" at (epsilonE + 0.01), 0.00001
set arrow from etadE, -0.0001 to etadE, 0.0001 nohead
set arrow from etaaE, -0.0001 to etaaE, 0.0001 nohead
set arrow from epsilonE, -0.0001 to epsilonE, 0.0001 nohead
plot [x=0:xmax] dzdt(x, zetadE, xid) w lines lw 2 title 'Dendritic', [x=0:xmax] dzdt(x, zetaaE, xia) w lines lw 2 title 'Axonal', 0 title "";

# Inhibitory neurons
xid=(etadI+epsilonI)/2.0
xia=(etaaI+epsilonI)/2.0

zetadI=(etadI-epsilonI)/1.6651092223153954
zetaaI=(etaaI-epsilonI)/1.6651092223153954

set output "growth-curves-I.png"
set title "Growth curves for I neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_d" at (etadI + 0.01), 0.00001
set label "{/Symbol h}_a" at (etaaI + 0.01), 0.00001
set label "{/Symbol e}" at (epsilonI + 0.01), 0.00001
set arrow from etadI, -0.0001 to etadI, 0.0001 nohead
set arrow from etaaI, -0.0001 to etaaI, 0.0001 nohead
set arrow from epsilonI, -0.0001 to epsilonI, 0.0001 nohead
plot [x=0:xmax] dzdt(x, zetadI, xid) w lines lw 2 title 'Dendritic', [x=0:xmax] dzdt(x, zetaaI, xia) w lines lw 2 title 'Axonal', 0 title "";
