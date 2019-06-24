load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette-snapshot.pal'
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
    set cblabel "Ca"
    set cbrange [cal_min: cal_max]
    set output "02-calcium-".neuron_set."-".plot_time.".png"
    set title "Ca for ".neuron_set." at t=".plot_time
    # row is y, not x
    set view map
    plot i_fn using 2:3:6 with image
}

