load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/pattern-palette.pal'
file_exists(file) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0
set term pngcairo font "OpenSans, 28" size 1920, 1080
set xlabel "Time (seconds)"
set ylabel "Mean firing rate of neurons (Hz)"
set xrange [0:]
set ytics border 20
set xtics border nomirror
set lmargin at screen 0.15

do for [pat=1:numpats+0] {
    set ytics 5
    set yrange [0:40]
    outfile = sprintf('mean-firing-rates-pattern-zoomed-%d.png', pat)
    infile = sprintf('mean-firing-rates-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Mean firing rate for pattern ".pat." neurons"
        plot infile with lines ls 2 title "P"
    }
}
