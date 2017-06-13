load '/home/asinha/Documents/02_Code/00_repos/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Mean firing rate of neurons (Hz)"
set yrange [0:200]
set xrange [0:]
set ytics border 20
set xtics border nomirror

do for [pat=1:numpats+0] {
    set ytics 5
    set yrange [0:40]
    outfile = sprintf('firing-rate-pattern-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for pattern ".pat." neurons"
        plot infile with lines ls 2 title "P", 3 with lines lw 2 title "T"
    }
}
