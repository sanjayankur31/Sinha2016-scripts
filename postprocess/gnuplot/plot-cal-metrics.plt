load '/home/asinha/Documents/02_Code/00_repos/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Calcium concentrations"
set ytics border nomirror
set xtics border nomirror
set yrange[0:]
set lmargin at screen 0.15

# to also plot the three values for easier analysis
xmax=system("tail -1 02-calcium-lpz_c_E-all.txt | awk '{print $1}'")
epsilonE=system("grep 'epsilonE' 99-simulation_params.txt | sed 's/^.*: //'")
etaaE=system("grep 'etaaE' 99-simulation_params.txt | sed 's/^.*: //'")
etadEE=system("grep 'etadE' 99-simulation_params.txt | sed 's/^.*: //'")
set arrow from 0,etadE to xmax/1000,etadE nohead lw 1
set arrow from 0,epsilonE to xmax/1000, epsilonE nohead lw 1
set arrow from 0,etaaE to xmax/1000,etaaE nohead lw 1

set output "02-calcium-E.png"
set title "Mean and STD calcium concentration for various E neuron sets"
# plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";


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
set yrange[0:epsilonE+20]
# plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
plot "02-calcium-lpz_c_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_E-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

unset yrange
set yrange [0:]
epsilonI=system("grep 'epsilonI' 99-simulation_params.txt | sed 's/^.*: //'")
etaaI=system("grep 'etaaI' 99-simulation_params.txt | sed 's/^.*: //'")
etadI=system("grep 'etadI' 99-simulation_params.txt | sed 's/^.*: //'")
unset arrow
set arrow from 0,etadI to xmax/1000,etadI nohead lw 1
set arrow from 0,epsilonI to xmax/1000, epsilonI nohead lw 1
set arrow from 0,etaaI to xmax/1000,etaaI nohead lw 1
set output "02-calcium-I.png"
set title "Mean and STD calcium concentration for various I neuron sets"
#plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";

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
set yrange[0:epsilonI+20]
#plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2:($2-$3):($2+$3) with errorbars lw 6 title "", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ"
plot "02-calcium-lpz_c_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ C", "02-calcium-lpz_b_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean LPZ B", "02-calcium-p_lpz_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean P LPZ", "02-calcium-o_I-all.txt" using ($1/1000):2 with linespoints lw 6 title "Mean non LPZ";
