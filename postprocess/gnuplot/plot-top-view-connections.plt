load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
set term pngcairo font "OpenSans, 28" size 1440,1920
set xlabel "extent ({/Symbol m} m)"
set ylabel "extent ({/Symbol m} m)"
set xtics out border nomirror 0,1000
set ytics out border nomirror 0,1000
# set yrange[-3000:18000]
# set xrange[-3000:15000]
set size ratio -1
set key inside horizontal top
set offset 400, 400, 400, 400

set output o_fn;
set title plot_title

# circles to show the regions
set object 10 circle at o_x,o_y size r_p_lpz fc rgb "red" fs transparent solid 0.1 behind
set object 11 circle at o_x,o_y size r_lpz_b fc rgb "green" fs transparent solid 0.1 behind
set object 12 circle at o_x,o_y size r_lpz_c fc rgb "yellow" fs transparent solid 0.3 behind

plot i_fn using 1:2:($3-$1):($4-$2) with vectors nohead title "", i_fn using 1:2 with points pt 7 ps 2 title "Pre-", i_fn using 3:4 with points pt 6 ps 5 title "Post-"
