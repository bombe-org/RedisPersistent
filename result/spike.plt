set term pdfcairo lw 2 font "Arial,18"
set output "redis_spike.pdf"

set xlabel "Record count[M], logscale" font "Arial,20"
set ylabel "Maximum latency[ms], logscale" font "Arial,20"
set xtics ("1" 1,"2" 2,"4" 4,"8" 8,"16" 16)
set logscale x
set logscale y

set key left top
set grid lw 2
set key maxcols 1
set key maxrows 3
# set border 15 lt -1 lw 0.01

plot [1:16][5:] \
"spike.txt" using 1:($2/1000) title "Redis" with linespoints linecolor 8 linewidth 2 pointtype 14 pointsize 1.5,\
"spike.txt" using 1:($3/1000) title "Redis-HG" with linespoints linecolor 12 linewidth 2 pointtype 11 pointsize 1.5,\
"spike.txt" using 1:($4/1000) title "Redis-PB" with linespoints linecolor 11 linewidth 2 pointtype 17 pointsize 1.5
