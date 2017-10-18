set term pngcairo enhanced
set output "testoutput.png"
plot "nonexistent-file.gdf" with lines title "Fail";
