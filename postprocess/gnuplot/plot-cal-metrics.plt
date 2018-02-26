load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Calcium concentrations"
set ytics border nomirror
set xtics border nomirror
set yrange[0:]
set lmargin at screen 0.15

# to also plot the three values for easier analysis
# xmax is the length of the simulation
xmax=system("tail -1 02-calcium-lpz_c_E-all.txt | awk '{print $1}'")
eps_E=system("grep 'eps_E' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_E=system("grep 'eta_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_E_e=system("grep 'eta_d_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_E_i=system("grep 'eta_d_E_i' 99-simulation_params.txt | sed 's/^.*: //'")
set arrow from 0,eta_d_E_e to xmax/1000,eta_d_E_e nohead lw 1
set arrow from 0,eta_d_E_i to xmax/1000,eta_d_E_i nohead lw 1
set arrow from 0,eps_E to xmax/1000, eps_E nohead lw 1
set arrow from 0,eta_ax_E to xmax/1000,eta_ax_E nohead lw 1

set output "02-calcium-E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
# plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

set yrange[0:eps_E+20]
set output "02-calcium-lpz_c_E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C",

set output "02-calcium-lpz_b_E.png"
plot "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B",

set output "02-calcium-p_lpz_E.png"
plot "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-o_E.png"
plot "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ"

set output "02-calcium-E-zoomed.png"
set title "Zoomed mean calcium concentration for various E neuron sets"
# plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

unset yrange
unset arrow
set yrange [0:]
eps_I=system("grep 'eps_I' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_I=system("grep 'eta_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_I_e=system("grep 'eta_d_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_d_I_i=system("grep 'eta_d_I_i' 99-simulation_params.txt | sed 's/^.*: //'")
set arrow from 0,eta_d_I_e to xmax/1000,eta_d_I_e nohead lw 1
set arrow from 0,eta_d_I_i to xmax/1000,eta_d_I_i nohead lw 1
set arrow from 0,eps_I to xmax/1000, eps_I nohead lw 1
set arrow from 0,eta_ax_I to xmax/1000,eta_ax_I nohead lw 1
set output "02-calcium-I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
#plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

set yrange[0:eps_I+20]
set output "02-calcium-lpz_c_I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C",

set output "02-calcium-lpz_b_I.png"
plot "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B",

set output "02-calcium-p_lpz_I.png"
plot "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"

set output "02-calcium-o_I.png"
plot "02-calcium-o_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ"

set output "02-calcium-I-zoomed.png"
set title "Zoomed mean calcium concentration for various I neuron sets"
#plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
