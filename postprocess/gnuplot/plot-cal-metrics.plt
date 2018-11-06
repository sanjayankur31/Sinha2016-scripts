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
# Excitatory neurons
eps_ax_E=system("grep 'eps_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_E_e=system("grep 'eps_den_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_E_i=system("grep 'eps_den_E_i' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_E=system("grep 'eta_ax_E' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_E_e=system("grep 'eta_den_E_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_E_i=system("grep 'eta_den_E_i' 99-simulation_params.txt | sed 's/^.*: //'")

set object 1 rectangle from graph 0, graph 0 to graph 1, first eta_den_E_e fc rgb "red" fs transparent solid 0.1 behind
set object 2 rectangle from graph 0, first eta_den_E_e to graph 1, first eta_ax_E fc rgb "green" fs transparent solid 0.1 behind
set object 3 rectangle from graph 0, first eta_ax_E to graph 1, first eps_ax_E fc rgb "yellow" fs transparent solid 0.1 behind
set object 4 rectangle from graph 0, first eps_ax_E to graph 1, first eps_den_E_i fc rgb "blue" fs transparent solid 0.1 behind
set object 5 rectangle from graph 0, first eps_den_E_i to graph 1, graph 1 fc rgb "red" fs transparent solid 0.1 behind

set output "02-calcium-E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

set yrange[0:eps_den_E_i+5]
set title "Mean and STD calcium concentration for various E neuron sets"
set output "02-calcium-lpz_c_E.png"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;

set output "02-calcium-lpz_b_E.png"
plot "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;


set output "02-calcium-p_lpz_E.png"
plot "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;


set output "02-calcium-o_E.png"
plot "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean O LPZ", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;


set output "02-calcium-E-zoomed.png"
set title "Zoomed mean calcium concentration for various E neuron sets"
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

# Inhibitory
unset arrow
unset object
eps_ax_I=system("grep 'eps_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_I_e=system("grep 'eps_den_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
eps_den_I_i=system("grep 'eps_den_I_i' 99-simulation_params.txt | sed 's/^.*: //'")
eta_ax_I=system("grep 'eta_ax_I' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_I_e=system("grep 'eta_den_I_e' 99-simulation_params.txt | sed 's/^.*: //'")
eta_den_I_i=system("grep 'eta_den_I_i' 99-simulation_params.txt | sed 's/^.*: //'")

set object 1 rectangle from graph 0, graph 0 to graph 1, first eta_ax_I fc rgb "red" fs transparent solid 0.1 behind
set object 2 rectangle from graph 0, first eta_ax_I to graph 1, first eta_den_I_e fc rgb "blue" fs transparent solid 0.1 behind
set object 3 rectangle from graph 0, first eta_den_I_e to graph 1, first eps_den_I_e fc rgb "green" fs transparent solid 0.1 behind
set object 4 rectangle from graph 0, first eta_den_I_i to graph 1, first eps_den_I_i fc rgb "yellow" fs transparent solid 0.1 behind
set object 5 rectangle from graph 0, first eps_den_I_i to graph 1, graph 1 fc rgb "red" fs transparent solid 0.1 behind

unset yrange
set yrange[0:]
set output "02-calcium-I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
# plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

set yrange[0:eps_den_I_i+5]
set title "Mean and STD calcium concentration for various I neuron sets"
set output "02-calcium-lpz_c_I.png"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;

set output "02-calcium-lpz_b_I.png"
plot "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;


set output "02-calcium-p_lpz_I.png"
plot "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;


set output "02-calcium-o_I.png"
plot "02-calcium-o_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", '' using ($1/1000):2 with linespoints lw 6 title "Mean O LPZ", '' using ($1/1000):4:5 with filledcurves fs transparent solid 0.2 title "", '' using ($1/1000):4 with lines lw 2 notitle, '' using ($1/1000):5 with lines lw 2 notitle;


set output "02-calcium-I-zoomed.png"
set title "Zoomed mean calcium concentration for various I neuron sets"
# plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

