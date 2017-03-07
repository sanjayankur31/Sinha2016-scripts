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
    set yrange [0:40]
    outfile = sprintf('firing-rate-pattern-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for pattern ".pat." neurons"
        plot infile with lines lw 2 title "P", 3 with lines lw 2 title "T"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-background-%d.png', pat)
    infile = sprintf('firing-rate-background-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for background neurons for pattern ".pat
        plot infile with lines lw 2 title "BG-E", 3 with lines lw 2 title "T"
    }
    set yrange [0:40]
    outfile = sprintf('firing-rate-background-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-background-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for background neurons for pattern ".pat
        plot infile with lines lw 2 title "BG-E", 3 with lines lw 2 title "T"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-pattern-background-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-background-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its background E neurons";
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "BG-E"
    }
    outfile = sprintf('firing-rate-pattern-background-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-background-%d.gdf', pat)
    set yrange [0:40]
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its background E neurons";
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "BG-E"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-deaffed-pattern-%d.png', pat)
    infile = sprintf('firing-rate-deaffed-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for deaffed portion of pattern ".pat." neurons";
        plot infile with lines lw 2 title "Deaffed-P", 3 with lines lw 2 title "T"
    }
    set yrange [0:40]
    outfile = sprintf('firing-rate-deaffed-pattern-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-deaffed-pattern-%d.gdf', pat)
    if (file_exists(infile)) {
        set output outfile
        set title "Firing rate for deaffed portion of pattern ".pat." neurons";
        plot infile with lines lw 2 title "Deaffed-P", 3 with lines lw 2 title "T"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-pattern-deaffed-pattern-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-pattern-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its deaffed neurons"
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "Deaffed-P"
    }
    set yrange [0:40]
    outfile = sprintf('firing-rate-pattern-deaffed-pattern-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-pattern-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-pattern-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for pattern ".pat." and its deaffed neurons"
        plot infile with lines lw 2 title "P", infile1 with lines lw 2 title "Deaffed-P"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-bg-deaffed-bg-E-%d.png', pat)
    infile = sprintf('firing-rate-background-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-E-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for E bg neurons and E deaffed bg neurons for pattern ".pat;
        plot infile with lines lw 2 title "BG-E", infile1 with lines lw 2 title "Deaffed-BG-E"
    }
    set yrange [0:40]
    outfile = sprintf('firing-rate-bg-deaffed-bg-E-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-background-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-E-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile
        set title "Firing rate for E bg neurons and E deaffed bg neurons for pattern ".pat;
        plot infile with lines lw 2 title "BG-E", infile1 with lines lw 2 title "Deaffed-BG-E"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-deaffed-bg-E-deaffed-I-%d.png', pat)
    infile = sprintf('firing-rate-deaffed-bg-E-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-I-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile;
        set title "Firing rate for E deaffed bg neurons and I deaffed neurons for pattern ".pat;
        plot infile1 with lines lw 2 title "Deaffed-I", infile with lines lw 2 title "Deaffed-BG-E"
    }
    set yrange [0:40]
    outfile = sprintf('firing-rate-deaffed-bg-E-deaffed-I-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-deaffed-bg-E-%d.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-I-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile;
        set title "Firing rate for E deaffed bg neurons and I deaffed neurons for pattern ".pat;
        plot infile1 with lines lw 2 title "Deaffed-I", infile with lines lw 2 title "Deaffed-BG-E"
    }
    set yrange [0:200]

    outfile = sprintf('firing-rate-I-deaffed-I-%d.png', pat)
    infile = sprintf('firing-rate-I.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-I-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile;
        set title "Firing rate for I neurons and I deaffed neurons for pattern ".pat;
        plot infile with lines lw 2 title "I", infile1 with lines lw 2 title "Deaffed-I"
    }
    set yrange [0:40]
    outfile = sprintf('firing-rate-I-deaffed-I-zoomed-%d.png', pat)
    infile = sprintf('firing-rate-I.gdf', pat)
    infile1 = sprintf('firing-rate-deaffed-bg-I-%d.gdf', pat)
    if (file_exists(infile)) && (file_exists(infile1)) {
        set output outfile;
        set title "Firing rate for I neurons and I deaffed neurons for pattern ".pat;
        plot infile with lines lw 2 title "I", infile1 with lines lw 2 title "Deaffed-I"
    }
    set yrange [0:200]
}
