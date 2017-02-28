set term pngcairo font "OpenSans, 28" size 1920,1028
set xlabel "Time (seconds)"
set ylabel "Mean firing rate of neurons (Hz)"
set yrange [0:200]
set xrange [0:]
set ytics border nomirror 20
set xtics border nomirror

do for [pat=1:numpats+0] {
    outfile = sprintf('firing-rate-pattern-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for pattern ".pat." neurons"
        plot infile with lines lw 2 title "P", 3 with lines lw 2 title "T"
    }

    outfile = sprintf('firing-rate-background-%d.png', pat)
    infile = sprintf('firing-rate-background-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for background neurons for pattern ".pat
        plot infile with lines lw 2 title "BGE", 3 with lines lw 2 title "T"
    }

    outfile = sprintf('firing-rate-pattern-background-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-background-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its background E neurons"; 
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "BGE"
    }

    outfile = sprintf('firing-rate-pattern-background-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-background-%d.gdf', pat)
    set yrange [0:40]
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its background E neurons"; 
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "BGE"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-deaffed-pattern-%d.png', pat)
    infile = sprintf('firing-rate-deaffed-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for deaffed portion of pattern ".pat." neurons"; 
        plot infile with lines lw 2 title "DP", 3 with lines lw 2 title "T"
    }

    outfile = sprintf('firing-rate-pattern-deaffed-pattern-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-pattern-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its deaffed neurons"
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "DP"
    }

    outfile = sprintf('firing-rate-bg-deaffed-bg-E-%d.png', pat)
    infile = sprintf('firing-rate-background-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-E-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for E bg neurons and E deaffed bg neurons for pattern ".pat; 
        plot infile with lines lw 2 title "BGE", infile1 with lines lw 2 title "DBGE"
    }

    outfile = sprintf('firing-rate-bg-deaffed-bg-I-%d.png', pat)
    infile = sprintf('firing-rate-I.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-I-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile; 
        set title "Firing rate for I bg neurons and I deaffed bg neurons for pattern ".pat; 
        plot infile with lines lw 2 title "BGI", infile1 with lines lw 2 title "DBGI"
    }
}
