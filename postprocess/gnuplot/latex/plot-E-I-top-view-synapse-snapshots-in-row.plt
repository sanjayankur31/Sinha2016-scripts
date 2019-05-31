load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'

###
# Change:
# region, neuron connection type, time of snapshot, in or out connections.
###

# Helper functions
# https://stackoverflow.com/a/21087936/375067
init_margins(left, right, gap, cols) = \
  sprintf('left_margin = %f; right_margin = %f;', left, right) . \
  sprintf('col_count = %d; gap_size = %f;', cols, gap)
set_margins(col) = sprintf('set lmargin at screen %f;', get_lmargin(col)) . \
  sprintf('set rmargin at screen %f;', get_rmargin(col));
get_lmargin(col) = (left_margin + (col - 1) * (gap_size + ((right_margin - left_margin)-(col_count - 1) * gap_size)/col_count))
get_rmargin(col) = (left_margin + (col - 1) * gap_size + col * ((right_margin - left_margin)-(col_count - 1) * gap_size)/col_count)

set term epslatex color size 9.3cm, 4.5cm
unset xtics
unset ytics
set size ratio -1
set bmargin at screen 0.01
set tmargin at screen 1.0
unset border

# No key
unset key
unset cbrange
unset colorbox


# Need to calculate these from data
o_x = 5960
o_y = 7467
r_lpz_c = 1141
r_lpz_b = 1594
r_p_lpz = 2352

set xrange[o_x-1.5*r_p_lpz:o_x+1.5*r_p_lpz]
set yrange[o_y-1.5*r_p_lpz:o_y+1.5*r_p_lpz]

# Circles denoting areas
# set offset 400, 400, 400, 400
set object 10 rectangle fc rgb "black" fs transparent solid 0.1 noborder from graph 0, graph 0 to graph 1, graph 1 behind
set object 11 circle at o_x,o_y size r_p_lpz fc rgb "red" fs transparent solid 0.1 behind
set object 12 circle at o_x,o_y size r_lpz_b fc rgb "green" fs transparent solid 0.1 behind
set object 13 circle at o_x,o_y size r_lpz_c fc rgb "yellow" fs transparent solid 0.3 behind

# Variables
# Simulation
simulation = "201905131224"
# Number of images to put in the row
num_images = 2
# Incoming or outgoing
conn_type = "out"
# Input time
inputtime = "2000.0"


file_exists(fname) = system("[ -f '".fname."' ] && echo '1' || echo '0'") + 0

# type of synapse 1
set output simulation."-75-conns-top-lpz_c-E-I-".conn_type."-".inputtime.".tex"
eval(init_margins(0.01, 0.99, 0.001, num_images))
set multiplot layout 1, num_images

inputfile = "75-conns-top-EE-lpz_c_E-".inputtime."-".conn_type.".txt"
if (file_exists(inputfile)) {
    eval(set_margins(1))
    plot inputfile using 1:2:($3-$1):($4-$2) with vectors lw 0.25 nohead title "", inputfile using 1:2 with points pt 7 lc 6 ps 0.75 lw 0.25 title "", inputfile using 3:4 with points pt 6 lc 6 ps 0.75 lw 0.25 title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}
inputfile = "75-conns-top-IE-lpz_c_I-".inputtime."-".conn_type.".txt"
if (file_exists(inputfile)) {
    eval(set_margins(2))
    plot inputfile using 1:2:($3-$1):($4-$2) with vectors lw 0.25 nohead title "", inputfile using 1:2 with points pt 7 lc 6 ps 0.75 lw 0.25 title "", inputfile using 3:4 with points pt 6 lc 6 ps 0.75 lw 0.25 title ""
}
else {
    print inputfile." not found. Exiting"
    exit
}

unset multiplot
