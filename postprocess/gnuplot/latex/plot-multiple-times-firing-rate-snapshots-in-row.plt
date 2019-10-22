load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette-snapshot.pal'

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
simulation = "201908151244"
neuron_set = "E"
# Number of images to put in the row
num_images = 4

# Range of cb
cbmax = 6
cbmin = 1

# Usage:
# gnuplot -e 'inputtime1="2000.0"' -e 'inputtime2="3000.0"' ... plot-multiple-firing-rate-snapshots-in-row-tex.plt

inputtime1="1500.0"
inputtime2="2001.5"
inputtime3="4000.0"
inputtime4="18000.0"

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set term epslatex color size 4.60, 1.4
set output simulation."-firing-rate-snapshots-".neuron_set.".tex"

unset xtics
unset ytics
set size ratio -1
set xrange [0:80]
set yrange [0:100]
set bmargin at screen 0.02

set tmargin at screen 0.99
eval(init_margins(0.07, 1.0, 0.001, num_images))
set multiplot layout 1, num_images

unset colorbox
set colorbox vertical user origin screen 0.05, 0.02 size 0.01, 0.975
set cbrange [cbmin:cbmax]
unset cbtics
set cbtics left offset screen -0.05 cbmin, cbmax-1
set cblabel "Firing rate (Hz)" offset screen -0.25

unset border
unset key

# First one, with colorbox
inputtime = value(sprintf('inputtime%d', 1))
inputfile = "firing-rates-".neuron_set."-".inputtime.".gdf"
if (file_exists(inputfile)) {
    set view map
    eval(set_margins(1))
    plot inputfile using 2:3:4 with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}

unset colorbox
do for [i=2:(num_images-0)] {
    inputtime = value(sprintf('inputtime%d', i))
    inputfile = "firing-rates-".neuron_set."-".inputtime.".gdf"
    if (file_exists(inputfile)) {
        eval(set_margins(i))
        set view map
        plot inputfile using 2:3:4 with image title ""
    }
    else {
        print inputfile." not found. Exiting"
        exit
    }
}
