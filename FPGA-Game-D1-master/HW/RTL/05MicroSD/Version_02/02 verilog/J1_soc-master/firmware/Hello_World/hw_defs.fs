( Hardware port assignments )

h# FF00 constant mult_a  \ no cambiar estos tres
h# FF02 constant mult_b  \ hacen parte de otras
h# FF04 constant mult_p \ definiciones

\ memory map multiplier:
h# 6700 constant datainSD	
h# 6702 constant enableSD
h# 6704 constant doneSD
h# 6706 constant dataoutSD

\ memory map uart:
h# 6900 constant uart_busy    \ para lectura de uart (uart_busy)
h# 6902 constant uart_data    \ escritura de datos que van a la uart
h# 6904 constant led \ led-independiente , se lo deja dentro del mapa de memoria de la uart







