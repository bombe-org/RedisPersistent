set term pdfcairo lw 2 font "Arial,18"
set output "redis_rw.pdf"

set xlabel "Update proportion" font "Arial,20"
set ylabel "Maximum latency[us]" font "Arial,20"
set xtics ("0.1" 0.1,"0.2" 0.2,"0.3" 0.3,"0.4" 0.4,"0.5" 0.5)

set key center top
set grid lw 2
set key maxcols 3
set key maxrows 1
# set border 15 lt -1 lw 0.01

plot [0.1:0.5][0:800] \
"rw.txt" using 1:($2/1000) title "Redis" with linespoints linecolor 8 linewidth 2 pointtype 14 pointsize 1.5,\
"rw.txt" using 1:($3/1000) title "Redis-HG" with linespoints linecolor 12 linewidth 2 pointtype 11 pointsize 1.5,\
"rw.txt" using 1:($4/1000) title "Redis-PB" with linespoints linecolor 11 linewidth 2 pointtype 17 pointsize 1.5