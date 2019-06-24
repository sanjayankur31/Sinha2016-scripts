load '/home/asinha/Documents/02_Code/00_mine/gnuplot-palettes/paired.pal'
set term pngcairo font "OpenSans, 28" size 1920, 1080
set ylabel "Neurons"
set xlabel "Number of synaptic elements"
set ytics border nomirror
set xtics border nomirror
set lmargin at screen 0.15
# set format y "%.1tx10^{%T}"
# set format x "%.1tx10^{%T}"

bin_width = 1.
bin_number(x) = floor(x/bin_width)
rounded(x) = bin_width * (bin_number(x) + (bin_width/2))

set title "connected ax for ".neuron_set." at time ".plot_time
set output "05-se-ax-hist-con-".neuron_set."-".plot_time.".png"
plot in_fn using (rounded(abs($7))):(abs($7)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($7))):(abs($7)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",

set title "connected denE for ".neuron_set." at time ".plot_time
set output "05-se-denE-hist-con-".neuron_set."-".plot_time.".png"
plot in_fn using (rounded(abs($9))):(abs($9)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($9))):(abs($9)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",

set title "connected denI for ".neuron_set." at time ".plot_time
set output "05-se-denI-hist-con-".neuron_set."-".plot_time.".png"
plot in_fn using (rounded(abs($11))):(abs($11)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($11))):(abs($11)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",

set title "total ax for ".neuron_set." at time ".plot_time
set output "05-se-ax-hist-all-".neuron_set."-".plot_time.".png"
plot in_fn using (rounded(abs($6))):(abs($6)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($6))):(abs($6)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",

set title "total denE for ".neuron_set." at time ".plot_time
set output "05-se-denE-hist-all-".neuron_set."-".plot_time.".png"
plot in_fn using (rounded(abs($8))):(abs($8)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($8))):(abs($8)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",

set title "total denI for ".neuron_set." at time ".plot_time
set output "05-se-denI-hist-all-".neuron_set."-".plot_time.".png"
plot in_fn using (rounded(abs($10))):(abs($10)) smooth frequency with boxes lc black fill pattern 4 border title "Initial", i_fn using (rounded(abs($10))):(abs($10)) smooth frequency with boxes lc 6 fill transparent pattern 5 border title "Now",
