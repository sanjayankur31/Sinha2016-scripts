load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'

# Helper functions
# https://stackoverflow.com/a/21087936/375067
init_margins(left, right, gap, cols) = \
  sprintf('left_margin = %f; right_margin = %f;', left, right) . \
  sprintf('col_count = %d; gap_size = %f;', cols, gap)
set_margins(col) = sprintf('set lmargin at screen %f;', get_lmargin(col)) . \
  sprintf('set rmargin at screen %f;', get_rmargin(col));
get_lmargin(col) = (left_margin + (col - 1) * (gap_size + ((right_margin - left_margin)-(col_count - 1) * gap_size)/col_count))
get_rmargin(col) = (left_margin + (col - 1) * gap_size + col * ((right_margin - left_margin)-(col_count - 1) * gap_size)/col_count)

# Variables
# Simulation
simulation = "201905131224"
# Number of images to put in the row
num_images = 4

# Usage:
# gnuplot -e 'inputtime1="2000.0"' -e 'inputtime2="3000.0"' ... plot-multiple-firing-rate-snapshots-in-row-tex.plt

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set term epslatex color size 5.55, 1.6
set output simulation."-raster-snapshots.tex"

# linestyle for points
set linestyle 1 lc rgb 'black' lw 0.25 pt 7 ps 0.2

unset xlabel
unset ylabel
# set border 3
set ytics border nomirror
set xtics border nomirror

set bmargin at screen 0.02
set tmargin at screen 0.99
eval(init_margins(0.01, 1.0, 0.001, num_images))
set multiplot layout 1, num_images

# unset border
unset key
set yrange[0:1000]

inputtime1="1500.0"
inputtime2="2000.0"
inputtime3="4000.0"
inputtime4="6000.0"

do for [i=1:(num_images-0)] {
    inputtime = value(sprintf('inputtime%d', i))
    inputfile = "raster-E-I-".inputtime.".txt"
    if (file_exists(inputfile)) {
        eval(set_margins(i))
        plot inputfile using 2:($1/10) with points ls 1
        unset xtics
        unset ytics
    }
    else {
        print inputfile." not found. Exiting"
        exit
    }
}
