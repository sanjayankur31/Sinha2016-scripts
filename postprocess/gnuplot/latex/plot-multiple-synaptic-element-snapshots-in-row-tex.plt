load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette-snapshot.pal'

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
simulation = "201811221433"
neuron_set = "E"
syn_element_set = "denE-con"
# 7 for denE
# 9 for denI
# 11 for ax
data_col = 7
# Number of images to put in the row
num_images = 3

# Range of cb
cbmax = 100
cbmin = 350

# Usage:
# gnuplot -e "inputtime1=2000.0" -e "inputtime2=3000.0" ... plot-multiple-firing-rate-snapshots-in-row-tex.plt

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set term epslatex color size 14cm, 4.5cm
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"

unset xtics
unset ytics
set size ratio -1
set xrange [0:80]
set yrange [0:100]
set bmargin at screen 0.02

eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
unset colorbox
unset border
unset key

do for [i=1:(num_images-1)] {
    inputtime = value(sprintf('inputtime%d', i))
    inputfile = "05-se-".neuron_set."-".inputtime.".txt"
    if (file_exists(inputfile)) {
        eval(set_margins(i))
        set view map
        plot inputfile using 2:3:data_col with image title ""
    }
    else {
        print inputfile." not found. Exiting"
        exit
    }
}

# Last one
inputtime = value(sprintf('inputtime%d', num_images))
inputfile = "05-se-".neuron_set."-".inputtime.".txt"
if (file_exists(inputfile)) {
    eval(set_margins(num_images))
    set colorbox
    unset cbtics
    # set cbtics cbmin, cbmax-1
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
