load '/home/asinha/Documents/02_Code/00_repos/01_others/gnuplot-palettes/sand.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term epslatex color size 8, 10 font "Helvetica,35"
set size ratio -1
set xrange [0:80]
set yrange [0:100]
unset xtics
unset ytics
set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0
#set xtics nomirror
#set ytics nomirror
unset border
unset colorbox
#set cblabel "Firing rate (Hz)"
set cbrange [0:20]
#set xlabel "Neurons"
#set ylabel "Neurons"
inputfile = inputtime.".gdf"

if (file_exists(inputfile)) {
    set title ""
    set output inputtime.".tex"
    set view map
    plot inputfile using 1:2:3 with image title ""
}

