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

file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo color size 42cm, 13cm
set output "test.png"

unset xtics
unset ytics
set size ratio -1
set xrange [0:80]
set yrange [0:100]
set bmargin at screen 0.02

eval(init_margins(0.01, 0.92, 0.001, 4))
set multiplot layout 1, 4

set cbrange [0:5]
unset colorbox
unset border
unset key

inputfile = inputtime.".gdf"
inputfile2 = inputtime2.".gdf"
inputfile3 = inputtime3.".gdf"
inputfile4 = inputtime4.".gdf"

if (file_exists(inputfile)) {

    eval(set_margins(1))
    set view map
    plot inputfile using 2:3:4 with image title ""

    eval(set_margins(2))
    set view map
    plot inputfile2 using 2:3:4 with image title ""

    eval(set_margins(3))
    set view map
    plot inputfile3 using 2:3:4 with image title ""

    eval(set_margins(4))
    set colorbox
    unset cbtics
    set cbtics 0, 5
    set cblabel "Firing rate (Hz)"
    plot inputfile4 using 2:3:4 with image title ""

}
