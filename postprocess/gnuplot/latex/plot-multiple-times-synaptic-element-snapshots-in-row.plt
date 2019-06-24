load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette-snapshot.pal'

# Usage:
# gnuplot -e "inputtime1=2000.0" -e "inputtime2=3000.0" ... plot-multiple-times-synaptic-element-snapshots-in-row-tex.plt

# Helper functions
# https://stackoverflow.com/a/21087936/375067
init_margins(left, right, gap, cols) = \
  sprintf('left_margin = %f; right_margin = %f;', left, right) . \
  sprintf('col_count = %d; gap_size = %f;', cols, gap)
set_margins(col) = sprintf('set lmargin at screen %f;', get_lmargin(col)) . \
  sprintf('set rmargin at screen %f;', get_rmargin(col));
get_lmargin(col) = (left_margin + (col - 1) * (gap_size + ((right_margin - left_margin)-(col_count - 1) * gap_size)/col_count))
get_rmargin(col) = (left_margin + (col - 1) * gap_size + col * ((right_margin - left_margin)-(col_count - 1) * gap_size)/col_count)

set term epslatex color size 11cm, 5cm
unset xtics
unset ytics
set size ratio -1
set xrange [0:80]
set yrange [0:100]
set bmargin at screen 0.02

# Variables
# Simulation
simulation = "201811221433"
# Number of images to put in the row
num_images = 3
# neuron set
neuron_set = "E"

syn_element_set = "denE-con"
# 9 for denE
data_col = 9
# Range of cb
cbmin = 100
cbmax = 300

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"

eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
set cbtics 100
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
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
unset multiplot

#####
syn_element_set = "denI-con"
# 11 for denI
data_col = 11

# Range of cb
cbmin = 0
cbmax = 800

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"

eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
set cbtics 200
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
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
unset multiplot

#####
syn_element_set = "ax-con"
# 7 for ax
data_col = 7

# Range of cb
cbmin = 100
cbmax = 300

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"
eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
set cbtics 100
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
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
unset multiplot

# Inhibitory neurons
set xrange [0:40]
set yrange [0:50]
neuron_set = "I"

syn_element_set = "denE-con"
# 9 for denE
data_col = 9
# Range of cb
cbmin = 175
cbmax = 200

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"

eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
set cbtics 25
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
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
unset multiplot

#####
syn_element_set = "denI-con"
# 11 for denI
data_col = 11

# Range of cb
cbmin = 0
cbmax = 50

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"

eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
set cbtics 50
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
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
unset multiplot

#####
syn_element_set = "ax-con"
# 7 for ax
data_col = 7

# Range of cb
cbmin = 200
cbmax = 2000

file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0
set output simulation."-se-".syn_element_set."-".neuron_set.".tex"
eval(init_margins(0.01, 0.92, 0.001, num_images))
set multiplot layout 1, num_images

set cbrange [cbmin:cbmax]
set cbtics 500
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
    set cblabel "Connected elements"
    set view map
    plot inputfile using 2:3:data_col with image title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
unset multiplot
