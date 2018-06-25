load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette-snapshot.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term epslatex color size 5, 3
set output "test.tex"

set multiplot layout 1, 2

unset xtics
unset ytics
set size ratio -1
set xrange [0:80]
set yrange [0:100]
set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0

set cbrange [0:20]

inputfile = inputtime.".gdf"
inputfile2 = inputtime2.".gdf"

if (file_exists(inputfile)) {

    set lmargin 1.7
    set rmargin 1.7
    set tmargin 1.7
    set bmargin 1.7
    unset border
    unset colorbox
    set title ""
    set view map
    plot inputfile using 2:3:4 with image title ""

    set lmargin 0
    set rmargin 0
    set tmargin 0
    set bmargin 0
    set colorbox
    unset cbtics
    set cbtics 0, 20
    set cblabel "Firing rate (Hz)"
    plot inputfile2 using 2:3:4 with image title ""

}
