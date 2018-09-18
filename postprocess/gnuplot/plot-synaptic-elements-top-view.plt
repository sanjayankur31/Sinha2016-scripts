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

if (file_exists(i_fn)) {
    set cblabel "Connected axons"
    set output g_fn_ax
    set title "Connected axons for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:6 with image
}

if (file_exists(i_fn)) {
    set cblabel "Connected denE"
    set output g_fn_de
    set title "Connected denE for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:8 with image
}

if (file_exists(i_fn)) {
    set cblabel "Connected denI"
    set output g_fn_di
    set title "Connected denI for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:10 with image
}
