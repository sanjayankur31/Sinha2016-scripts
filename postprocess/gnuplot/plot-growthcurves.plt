load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920, 1080
set format y "%.1tx10^{%T}"

# define the function
dzdt(x, nu, zeta, xi)= (nu * ((2.0 * exp(-(((x - xi)/zeta)**2.0))) - 1.0))

eps_ax_E=system("grep 'eps_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_E_e=system("grep 'eps_den_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_E_i=system("grep 'eps_den_E_i' 99-simulation_params.txt | sed 's/^.*: //'")
xmax_E=(eps_den_E_i+5.)
nu_ax_E=system("grep 'nu_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
nu_den_E_e=system("grep 'nu_den_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
nu_den_E_i=system("grep 'nu_den_E_i' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_E=system("grep 'eta_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_E_e=system("grep 'eta_den_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_E_i=system("grep 'eta_den_E_i' 99-simulation_params.txt | sed 's/^.*: //'")

eps_ax_I=system("grep 'eps_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_I_e=system("grep 'eps_den_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_I_i=system("grep 'eps_den_I_i' 99-simulation_params.txt | sed 's/^.*: //'")
xmax_I=(eps_den_I_i+5.)
nu_ax_I=system("grep 'nu_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
nu_den_I_e=system("grep 'nu_den_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
nu_den_I_i=system("grep 'nu_den_I_i' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_I=system("grep 'eta_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_I_e=system("grep 'eta_den_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_I_i=system("grep 'eta_den_I_i' 99-simulation_params.txt | sed 's/^.*: //'")

xi_den_E_e=(eta_den_E_e+eps_den_E_e)/2.0
xi_den_E_i=(eta_den_E_i+eps_den_E_i)/2.0
xi_ax_E=(eta_ax_E+eps_ax_E)/2.0

zeta_den_E_e=(eta_den_E_e-eps_den_E_e)/1.6651092223153954
zeta_den_E_i=(eta_den_E_i-eps_den_E_i)/1.6651092223153954
zeta_ax_E=(eta_ax_E-eps_ax_E)/1.6651092223153954

set output "growth-curves-E.png"
set title "Growth curves for E neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_{de}" at eta_den_E_e , graph 0.85 left front
set label "{/Symbol h}_{di}" at eta_den_E_i, graph 0.20 left front
set label "{/Symbol h}_a" at eta_ax_E, graph 0.50 left front
set label "{/Symbol e}_{de}" at eps_den_E_e, graph 0.85 left front
set label "{/Symbol e}_{di}" at eps_den_E_i, graph 0.20 left front
set label "{/Symbol e}_a" at eps_ax_E, graph 0.50 left front

set object 1 rectangle from graph 0, graph 0 to eta_den_E_e, graph 1 fc rgb "red" fs transparent solid 0.1 behind
set object 2 rectangle from eta_den_E_e, graph 0 to eta_den_E_i, graph 1 fc rgb "green" fs transparent solid 0.1 behind
set object 3 rectangle from eta_den_E_i, graph 0 to eps_ax_E, graph 1 fc rgb "yellow" fs transparent solid 0.1 behind
set object 4 rectangle from eps_ax_E, graph 0 to eps_den_E_i, graph 1 fc rgb "blue" fs transparent solid 0.1 behind
set object 5 rectangle from eps_den_E_i, graph 0 to graph 1, graph 1 fc rgb "red" fs transparent solid 0.1 behind

plot [x=0:xmax_E] dzdt(x, nu_den_E_e, zeta_den_E_e, xi_den_E_e) w lines lw 2 lc 3 title 'Dendritic E', [x=0:xmax_E] dzdt(x, nu_den_E_i, zeta_den_E_i, xi_den_E_i) w lines lw 2 lc 7 title 'Dendritic I', [x=0:xmax_E] dzdt(x, nu_ax_E, zeta_ax_E, xi_ax_E) w lines lw 2 lc 1 title 'Axonal', 0 title "";

# Inhibitory
unset arrow
unset label
xi_den_I_e=(eta_den_I_e+eps_den_I_e)/2.0
xi_den_I_i=(eta_den_I_i+eps_den_I_i)/2.0
xi_ax_I=(eta_ax_I+eps_ax_I)/2.0

zeta_den_I_e=(eta_den_I_e-eps_den_I_e)/1.6651092223153954
zeta_den_I_i=(eta_den_I_i-eps_den_I_i)/1.6651092223153954
zeta_ax_I=(eta_ax_I-eps_ax_I)/1.6651092223153954

set output "growth-curves-I.png"
set title "Growth curves for I neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_{de}" at eta_den_I_e , graph 0.85 left front
set label "{/Symbol h}_{di}" at eta_den_I_i, graph 0.20 left front
set label "{/Symbol h}_a" at eta_ax_I, graph 0.50 left front
set label "{/Symbol e}_{de}" at eps_den_I_e, graph 0.85 left front
set label "{/Symbol e}_{di}" at eps_den_I_i, graph 0.20 left front
set label "{/Symbol e}_a" at eps_ax_I, graph 0.50 left front

set object 1 rectangle from graph 0, graph 0 to eta_ax_I, graph 1 fc rgb "red" fs transparent solid 0.1 behind
set object 2 rectangle from eta_ax_I, graph 0 to eta_den_I_e, graph 1 fc rgb "blue" fs transparent solid 0.1 behind
set object 3 rectangle from eta_den_I_e, graph 0 to eta_den_I_i, graph 1 fc rgb "green" fs transparent solid 0.1 behind
set object 4 rectangle from eta_den_I_i, graph 0 to eps_den_I_i, graph 1 fc rgb "yellow" fs transparent solid 0.1 behind
set object 5 rectangle from eps_den_I_i, graph 0 to graph 1, graph 1 fc rgb "red" fs transparent solid 0.1 behind

plot [x=0:xmax_I] dzdt(x, nu_den_I_e, zeta_den_I_e, xi_den_I_e) w lines lw 2 lc 3 title 'Dendritic E', [x=0:xmax_I] dzdt(x, nu_den_I_i, zeta_den_I_i, xi_den_I_i) w lines lw 2 lc 7 title 'Dendritic I', [x=0:xmax_I] dzdt(x, nu_ax_I, zeta_ax_I, xi_ax_I) w lines lw 2 lc 1 title 'Axonal', 0 title "";

# Elements
# All excitatory elements
unset object
unset arrow
unset label
set label "{/Symbol e}_{E}" at (eps_den_E_e - 1.5), nu_ax_E
set label "{/Symbol e}_{I}" at (eps_den_I_e - 1.5), nu_ax_I
set arrow from eps_den_E_e, (-1 * nu_ax_E) to eps_den_E_e, nu_ax_E nohead
set arrow from eps_den_I_e, (-1 * nu_ax_I) to eps_den_I_e, nu_ax_I nohead
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set output "growth-curves-elements-E.png"
set title "Growth curves for excitatory synaptic elements"
plot [x=0:xmax_I] dzdt(x, nu_den_E_e, zeta_den_E_e, xi_den_E_e) w lines lw 2 title 'den E neurons', [x=0:xmax_I] dzdt(x, nu_den_I_e, zeta_den_I_e, xi_den_I_e) w lines lw 2 title 'den I neurons', [x=0:xmax_I] dzdt(x, nu_ax_E, zeta_ax_E, xi_ax_E) w lines lw 2 title 'ax E neurons', 0 title "";

# All inhibitory elements
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set output "growth-curves-elements-I.png"
set title "Growth curves for inhibitory synaptic elements"
plot [x=0:xmax_I] dzdt(x, nu_den_E_i, zeta_den_E_i, xi_den_E_i) w lines lw 2 title 'den E neurons', [x=0:xmax_I] dzdt(x, nu_den_I_i, zeta_den_I_i, xi_den_I_i) w lines lw 2 title 'den I neurons', [x=0:xmax_I] dzdt(x, nu_ax_I, zeta_ax_I, xi_ax_I) w lines lw 2 title 'ax I neurons', 0 title "";
