load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette-snapshot.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1440, 1920
set size ratio -1
set xrange [0:xmax]
set yrange [0:ymax]
set xtics border nomirror
set ytics border nomirror
set xlabel "Neurons"
set ylabel "Neurons"

# connected
if (file_exists(i_fn)) {
    set cblabel "Connected axons"
    set output "05-se-ax-con-".neuron_set."-".plot_time.".png"
    set title "Connected axons for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:7 with image
}

if (file_exists(i_fn)) {
    set cblabel "Connected denE"
    set output "05-se-denE-con-".neuron_set."-".plot_time.".png"
    set title "Connected denE for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:9 with image
}

if (file_exists(i_fn)) {
    set cblabel "Connected denI"
    set output "05-se-denI-con-".neuron_set."-".plot_time.".png"
    set title "Connected denI for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:11 with image
}

# totals
if (file_exists(i_fn)) {
    set cblabel "Total axons"
    set output "05-se-ax-total-".neuron_set."-".plot_time.".png"
    set title "Total axons for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:6 with image
}

if (file_exists(i_fn)) {
    set cblabel "Total denE"
    set output "05-se-denE-total-".neuron_set."-".plot_time.".png"
    set title "Total denE for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:8 with image
}

if (file_exists(i_fn)) {
    set cblabel "Total denI"
    set output "05-se-denI-total-".neuron_set."-".plot_time.".png"
    set title "Total denI for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:10 with image
}
