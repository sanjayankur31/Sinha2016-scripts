load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920, 1080

# define the function
dzdt(x, nu, zeta, xi)= (nu * ((2.0 * exp(-(((x - xi)/zeta)**2.0))) - 1.0))

eps_E=system("grep 'eps_E' 99-simulation_params.txt | sed 's/^.*: //'")
nu_ax_E=system("grep 'nu_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
nu_d_E_e=system("grep 'nu_d_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
nu_d_E_i=system("grep 'nu_d_E_i' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_E=system("grep 'eta_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_E_e=system("grep 'eta_d_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_E_i=system("grep 'eta_d_E_i' 99-simulation_params.txt | sed 's/^.*: //'")

eps_I=system("grep 'eps_I' 99-simulation_params.txt | sed 's/^.*: //'")
nu_ax_I=system("grep 'nu_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
nu_d_I_e=system("grep 'nu_d_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
nu_d_I_i=system("grep 'nu_d_I_i' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_I=system("grep 'eta_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_I_e=system("grep 'eta_d_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_I_i=system("grep 'eta_d_I_i' 99-simulation_params.txt | sed 's/^.*: //'")

xi_d_e=(eta_d_E_e+eps_E)/2.0
xi_d_i=(eta_d_E_i+eps_E)/2.0
xi_a=(eta_ax_E+eps_E)/2.0

zeta_d_E_e=(eta_d_E_e-eps_E)/1.6651092223153954
zeta_d_E_i=(eta_d_E_i-eps_E)/1.6651092223153954
zeta_ax_E=(eta_ax_E-eps_E)/1.6651092223153954

set output "growth-curves-E.png"
set title "Growth curves for E neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_de" at (eta_d_E_e + 0.01), 0.00001
set label "{/Symbol h}_di" at (eta_d_E_i + 0.01), 0.00001
set label "{/Symbol h}_a" at (eta_ax_E + 0.01), 0.00001
set label "{/Symbol e}" at (eps_E + 0.01), 0.00001
set arrow from eta_d_E_e, -0.0001 to eta_d_E_e, 0.0001 nohead
set arrow from eta_d_E_i, -0.0001 to eta_d_E_i, 0.0001 nohead
set arrow from eta_ax_E, -0.0001 to eta_ax_E, 0.0001 nohead
set arrow from eps_E, -0.0001 to eps_E, 0.0001 nohead
plot [x=0:xmax] dzdt(x, nu_d_E_e, zeta_d_E_e, xi_d_e) w lines lw 2 title 'Dendritic E', [x=0:xmax] dzdt(x, nu_d_E_i, zeta_d_E_i, xi_d_i) w lines lw 2 title 'Dendritic I', [x=0:xmax] dzdt(x, nu_ax_E, zeta_ax_E, xi_a) w lines lw 2 title 'Axonal', 0 title "";

# Inhibitory
xi_d_e=(eta_d_I_e+eps_I)/2.0
xi_d_i=(eta_d_I_i+eps_I)/2.0
xi_a=(eta_ax_I+eps_I)/2.0

zeta_d_I_e=(eta_d_I_e-eps_I)/1.6651092223153954
zeta_d_I_i=(eta_d_I_i-eps_I)/1.6651092223153954
zeta_ax_I=(eta_ax_I-eps_I)/1.6651092223153954

set output "growth-curves-I.png"
set title "Growth curves for I neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_de" at (etad_I_e + 0.01), 0.00001
set label "{/Symbol h}_di" at (etad_I_i + 0.01), 0.00001
set label "{/Symbol h}_a" at (eta_ax_I + 0.01), 0.00001
set label "{/Symbol e}" at (eps_I + 0.01), 0.00001
set arrow from eta_d_I_e, -0.0001 to eta_d_I_e, 0.0001 nohead
set arrow from eta_d_I_i, -0.0001 to eta_d_I_i, 0.0001 nohead
set arrow from eta_ax_I, -0.0001 to eta_ax_I, 0.0001 nohead
set arrow from eps_I, -0.0001 to eps_I, 0.0001 nohead
plot [x=0:xmax] dzdt(x, nu_d_I_e, zeta_d_I_e, xi_d_e) w lines lw 2 title 'Dendritic E', [x=0:xmax] dzdt(x, nu_d_I_i, zeta_d_I_i, xi_d_i) w lines lw 2 title 'Dendritic I', [x=0:xmax] dzdt(x, nu_ax_I, zeta_ax_I, xi_a) w lines lw 2 title 'Axonal', 0 title "";
