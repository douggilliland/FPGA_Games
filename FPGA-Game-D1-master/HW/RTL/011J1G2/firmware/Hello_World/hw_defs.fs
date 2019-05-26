( Hardware port assignments )

h# FF00 constant mult_a  \ no cambiar estos tres
h# FF02 constant mult_b  \ hacen parte de otras
h# FF04 constant mult_p  \ definiciones

\ memory map pwm
h# 6400 constant enablepwm	
h# 6402 constant fullpwm
h# 6404 constant emptypwm
h# 6408 constant doutmic


\ memory map ultra
h# 6400 constant ultra_enable	
h# 6402 constant ultra_done
h# 6404 constant ultra_data

\ memory map audio:
h# 6500 constant enable
h# 6502 constant full
h# 6504 constant empty
h# 6508 constant dout


\ memory map bt:
h# 6600 constant bt_tx	
h# 6602 constant bt_done
h# 6604 constant bt_avail
h# 6606 constant bt_busy
h# 6608 constant bt_rx

\ memory map multiplier:
h# 6700 constant multi_a	
h# 6702 constant multi_b
h# 6704 constant multi_init
h# 6706 constant multi_done
h# 6708 constant multi_pp_high
h# 670A constant multi_pp_low


\ memory map divider:
h# 6800 constant div_a		
h# 6802 constant div_b
h# 6804 constant div_init
h# 6806 constant div_done
h# 6808 constant div_c


\ memory map uart:
h# 6900 constant uart_busy    \ para lectura de uart (uart_busy)
h# 6902 constant uart_data    \ escritura de datos que van a la uart
h# 6904 constant led     \ led-independiente , se lo deja dentro del mapa de memoria de la uart



