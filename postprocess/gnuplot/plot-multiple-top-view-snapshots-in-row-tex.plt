load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'

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
set term epslatex color size 24cm, 10cm
set output "test.tex"

# set xlabel "extent ({/Symbol m} m)"
# set ylabel "extent ({/Symbol m} m)"
# set xtics out border nomirror 0,2000
# set ytics out border nomirror 0,2000
unset xtics
unset ytics

set yrange[0:15000]
set xrange[0:12000]
set size ratio -1

# set format y "%.1tx10^{%T}"
# set format x "%.1tx10^{%T}"

unset key
# set key inside horizontal top

# set offset 400, 400, 400, 400
# set object 10 circle at o_x,o_y size r_p_lpz fc rgb "red" fs transparent solid 0.1 behind
# set object 11 circle at o_x,o_y size r_lpz_b fc rgb "green" fs transparent solid 0.1 behind
# set object 12 circle at o_x,o_y size r_lpz_c fc rgb "yellow" fs transparent solid 0.3 behind


eval(init_margins(0.01, 1.00, 0.002, 3))
set multiplot layout 1, 3


inputfile = inputtime
inputfile2 = inputtime2
inputfile3 = inputtime3

if (file_exists(inputfile)) {

    eval(set_margins(1))
    set title ""
    plot inputfile using 1:2:($3-$1):($4-$2) with vectors lw 1 nohead title "", inputfile using 1:2 with points pt 7 ps 1 lw 1 title "", inputfile using 3:4 with points pt 6 ps 2 lw 1 title ""

    eval(set_margins(2))
    set title ""
    plot inputfile2 using 1:2:($3-$1):($4-$2) with vectors lw 1 nohead title "", inputfile2 using 1:2 with points pt 7 ps 1 lw 1 title "", inputfile2 using 3:4 with points pt 6 ps 2 lw 1 title ""

    eval(set_margins(3))
    set title ""
    plot inputfile3 using 1:2:($3-$1):($4-$2) with vectors lw 1 nohead title "", inputfile3 using 1:2 with points pt 7 ps 1 lw 1 title "", inputfile3 using 3:4 with points pt 6 ps 2 lw 1 title ""

}
