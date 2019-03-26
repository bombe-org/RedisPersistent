set term pdfcairo lw 2 font "Arial,18"
set output "redis_mem.pdf"

set xlabel "Record count[M], logscale" font "Arial,20"
set ylabel "Maximum page, logscale" font "Arial,20"
set xtics ("1" 1,"2" 2,"4" 4,"8" 8,"16" 16)
set ytics ("2^{18}" 18,"2^{19}" 19,"2^{20}" 20,"2^{21}" 21,"2^{22}" 22,"2^{23}" 23,"2^{24}" 24)

set logscale x
set logscale y
set key left top
set grid lw 2
set key maxcols 1
set key maxrows 3
# set border 15 lt -1 lw 0.01

plot [1:16][18.5:24.5] \
"mem.txt" using 1:2 title "Redis" with linespoints linecolor 8 linewidth 2 pointtype 14 pointsize 1.5,\
"mem.txt" using 1:4 title "Redis-HG" with linespoints linecolor 12 linewidth 2 pointtype 11 pointsize 1.5,\
"mem.txt" using 1:5 title "Redis-PB" with linespoints linecolor 11 linewidth 2 pointtype 17 pointsize 1.5
