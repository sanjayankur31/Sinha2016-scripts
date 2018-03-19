load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo enhanced font "OpenSans, 28" size 1920, 1080

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

xi_den_e=(eta_den_E_e+eps_den_E_e)/2.0
xi_den_i=(eta_den_E_i+eps_den_E_i)/2.0
xi_a=(eta_ax_E+eps_ax_E)/2.0

zeta_den_E_e=(eta_den_E_e-eps_den_E_e)/1.6651092223153954
zeta_den_E_i=(eta_den_E_i-eps_den_E_i)/1.6651092223153954
zeta_ax_E=(eta_ax_E-eps_ax_E)/1.6651092223153954

set output "growth-curves-E.png"
set title "Growth curves for E neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_{de}" at (eta_den_E_e + 0.2), nu_ax_E
set label "{/Symbol h}_{di}" at (eta_den_E_i + 0.2), nu_ax_E
set label "{/Symbol e}_{de}" at (eps_den_E_e - 1.5), nu_ax_E
set label "{/Symbol e}_{di}" at (eps_den_E_i + 0.2), nu_ax_E
set label "{/Symbol h}_a" at (eta_ax_E + 0.2), -nu_ax_E
set label "{/Symbol e}_a" at (eps_ax_E + 0.2), -nu_ax_E
set arrow from eta_den_E_e, (-1 * nu_ax_E) to eta_den_E_e, nu_ax_E nohead
set arrow from eta_den_E_i, (-1 * nu_ax_E) to eta_den_E_i, nu_ax_E nohead
set arrow from eta_ax_E, (-1 * nu_ax_E) to eta_ax_E, nu_ax_E nohead
set arrow from eps_den_E_e, (-1 * nu_ax_E) to eps_den_E_e, nu_ax_E nohead
set arrow from eps_den_E_i, (-1 * nu_ax_E) to eps_den_E_i, nu_ax_E nohead
set arrow from eps_ax_E, (-1 * nu_ax_E) to eps_ax_E, nu_ax_E nohead
plot [x=0:xmax_E] dzdt(x, nu_den_E_e, zeta_den_E_e, xi_den_e) w lines lw 2 title 'Dendritic E', [x=0:xmax_E] dzdt(x, nu_den_E_i, zeta_den_E_i, xi_den_i) w lines lw 2 title 'Dendritic I', [x=0:xmax_E] dzdt(x, nu_ax_E, zeta_ax_E, xi_a) w lines lw 2 title 'Axonal', 0 title "";

# Inhibitory
unset arrow
unset label
xi_den_e=(eta_den_I_e+eps_den_I_e)/2.0
xi_den_i=(eta_den_I_i+eps_den_I_i)/2.0
xi_a=(eta_ax_I+eps_ax_I)/2.0

zeta_den_I_e=(eta_den_I_e-eps_den_I_e)/1.6651092223153954
zeta_den_I_i=(eta_den_I_i-eps_den_I_i)/1.6651092223153954
zeta_ax_I=(eta_ax_I-eps_ax_I)/1.6651092223153954

set output "growth-curves-I.png"
set title "Growth curves for I neurons"
set xlabel "Calcium concentration"
set ylabel "dz/dt"
set label "{/Symbol h}_{de}" at (eta_den_I_e + 0.2), nu_ax_I
set label "{/Symbol h}_{di}" at (eta_den_I_i + 0.2), nu_ax_I
set label "{/Symbol e}_{de}" at (eps_den_I_e - 1.5), nu_ax_I
set label "{/Symbol e}_{di}" at (eps_den_I_i + 0.2), nu_ax_I
set label "{/Symbol h}_a" at (eta_ax_I + 0.2), -nu_ax_I
set label "{/Symbol e}_a" at (eps_ax_I + 0.2), -nu_ax_I
set arrow from eta_den_I_e, (-1 * nu_ax_I) to eta_den_I_e, nu_ax_I nohead
set arrow from eta_den_I_i, (-1 * nu_ax_I) to eta_den_I_i, nu_ax_I nohead
set arrow from eta_ax_I, (-1 * nu_ax_I) to eta_ax_I, nu_ax_I nohead
set arrow from eps_den_I_e, (-1 * nu_ax_I) to eps_den_I_e, nu_ax_I nohead
set arrow from eps_den_I_i, (-1 * nu_ax_I) to eps_den_I_i, nu_ax_I nohead
set arrow from eps_ax_I, (-1 * nu_ax_I) to eps_ax_I, nu_ax_I nohead
plot [x=0:xmax_I] dzdt(x, nu_den_I_e, zeta_den_I_e, xi_den_e) w lines lw 2 title 'Dendritic E', [x=0:xmax_I] dzdt(x, nu_den_I_i, zeta_den_I_i, xi_den_i) w lines lw 2 title 'Dendritic I', [x=0:xmax_I] dzdt(x, nu_ax_I, zeta_ax_I, xi_a) w lines lw 2 title 'Axonal', 0 title "";
