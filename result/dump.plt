set term pdfcairo lw 2 font "Arial,18"
set output "redis_dump.pdf"

set xlabel "Record count[M]" font "Arial,20"
set ylabel "Dump overhead[s]" font "Arial,20"
set xtics ("1" 1,"2" 2,"4" 4,"8" 8,"16" 16)
#set ytics ("2" 2000000,"4" 4000000,"6" 6000000,"8" 8000000,"10" 10000000,"12" 12000000)
#set logscale xy
set key left top
set grid lw 2
set key maxcols 1
set key maxrows 3
# set border 15 lt -1 lw 0.01

plot [1:16][10:800] \
"dump.txt" using 1:2 title "Redis" with linespoints linecolor 8 linewidth 2 pointtype 14 pointsize 1.5,\
"dump.txt" using 1:3 title "Redis-HG" with linespoints linecolor 12 linewidth 2 pointtype 11 pointsize 1.5,\
"dump.txt" using 1:4 title "Redis-PB" with linespoints linecolor 11 linewidth 2 pointtype 17 pointsize 1.5
