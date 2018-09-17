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
    set output o_fn
    set title "Connected axons for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:4 with image
}

if (file_exists(i_fn)) {
    set cblabel "Free axons"
    set output o_fn
    set title "Connected axons for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:5 with image
}

