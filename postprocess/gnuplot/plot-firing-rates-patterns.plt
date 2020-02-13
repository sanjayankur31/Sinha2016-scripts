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
do for [pat=1:numpats+0] {
    set ytics 5
    set yrange [0:40]
    outfile = sprintf('mean-firing-rates-pattern-in-lpz-zoomed-%d.png', pat)
    infile_in_lpz = sprintf('mean-firing-rates-pattern-in-lpz-%d.gdf', pat)
    if (file_exists(infile_in_lpz)) {
        set output outfile
        set title "Mean firing rate for pattern ".pat." neurons"
        plot infile_in_lpz with lines ls 2 title "In"
    }
}
do for [pat=1:numpats+0] {
    set ytics 5
    set yrange [0:40]
    outfile = sprintf('mean-firing-rates-pattern-outside-lpz-zoomed-%d.png', pat)
    infile_out_lpz = sprintf('mean-firing-rates-pattern-outside-lpz-%d.gdf', pat)
    if (file_exists(infile_out_lpz)) {
        set output outfile
        set title "Mean firing rate for pattern ".pat." neurons"
        plot infile_out_lpz with lines ls 2 title "Out"
    }
}
do for [pat=1:numpats+0] {
    set ytics 5
    set yrange [0:40]
    outfile = sprintf('mean-firing-rates-background-zoomed-%d.png', pat)
    infile = sprintf('mean-firing-rates-background-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Mean firing rate for background ".pat." neurons"
        plot infile with lines ls 2 title "B"
    }
}
