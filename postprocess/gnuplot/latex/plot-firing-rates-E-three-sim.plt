# Usage: gnuplot plot-firing-rates-IE-tex.plt
load '/home/asinha/Documents/02_Code/00_mine/Sinha2016-scripts/postprocess/gnuplot/firing-rates-palette.pal'
set term epslatex color size 4.0,1.5
set xlabel "Time (\\(\\times 1000 s\\))"
set ylabel "Firing rate (Hz)"
set border 3
set ytics border nomirror autofreq 2
set xtics border nomirror 2000 format "%.0s"
set lmargin at screen 0.01
set rmargin at screen 1.0
set tmargin at screen 0.90
set yrange [0:7]
set xrange [0:20000]
set key inside left top horizontal

# Syn
simulation1="201908151244"
# Both
simulation2="201908061027"
# str p only
simulation3="201908051154"

inputtime1="1500.0"
inputtime2="2001.5"
inputtime3="4000.0"
inputtime4="18000.0"

set arrow nohead from first inputtime1, first -0.5 to first inputtime1, first 5 ls 0 lw 2 dt 2
set arrow nohead from first inputtime2, first -0.5 to first inputtime2, first 5 ls 0 lw 2 dt 2
set arrow nohead from first inputtime3, first -0.5 to first inputtime3, first 5 ls 0 lw 2 dt 2
set arrow nohead from first inputtime4, first -0.5 to first inputtime4, first 5 ls 0 lw 2 dt 2

set output simulation1."-".simulation2."-".simulation3."-mean-firing-rates-lpz_c_E-zoomed.tex"
set title ""
plot simulation1."-mean-firing-rates-lpz_c_E.gdf" every 50 with lines ls 3  title "Syn", simulation2."-mean-firing-rates-lpz_c_E.gdf" every 100 with lines ls 1  title "Both", simulation3."-mean-firing-rates-lpz_c_E.gdf" every 100 with lines ls 5  title "Str",
