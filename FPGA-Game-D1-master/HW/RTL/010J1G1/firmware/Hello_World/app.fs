: usar_dpRAM \ envia los 6 primeros terminos de la serie de Fibonnacci a la dpRAM, el periferico invierte su orden, luego son leidos de vuelta

d# 1 h# 7000 !  \ escribe 1 en el registro h# 7000
d# 2 h# 7002 !  \ escribe 2 en el registro h# 7002
d# 3 h# 7004 !  \ escribe 3 en el registro h# 7004
d# 5 h# 7006 !  \ escribe 4 en el registro h# 7006
d# 8 h# 7008 !  \ escribe 8 en el registro h# 7008
d# 13 h# 700A !  \ escribe 13 en el registro h# 700A

begin h# 7008 @ d# 2 = until \ espera hasta que el registro 7008 sea 2, o sea hasta que el periferico reorganize la secuencia

h# 7000 @ \ lee lo que hay en el registro h# 7000, queda almacenado en la pila
h# 7002 @ \ lee lo que hay en el registro h# 7002, queda almacenado en la pila
h# 7004 @ \ lee lo que hay en el registro h# 7004, queda almacenado en la pila
h# 7006 @ \ lee lo que hay en el registro h# 7006, queda almacenado en la pila
h# 7008 @ \ lee lo que hay en el registro h# 7008, queda almacenado en la pila
h# 700A @ \ lee lo que hay en el registro h# 700A, queda almacenado en la pila

;
: multiplicar		 \ utiliza peripheral_mult.v
swap multi_a !
multi_b !
d# 1 multi_init !
begin multi_done @ d# 1 = until \ espera hasta que la señal done del multiplicador este en 1
multi_pp_high @
multi_pp_low @
\ d# 2 + multi_a !
;

: dividir		 \ utiliza peripheral_div.v
swap div_a !
div_b !
d# 1 div_init !
begin div_done @ d# 1 = until \ espera hasta que la señal done del divisor este en 1
div_c @
\ d# 3 + div_a !
;

: spi		 \ utiliza peripheral_.v
swap datainspi !
enablespi !
h# 1 enablespi !
begin donespi @ h# 1 = until \ 		espera hasta que la señal done del multiplicador este en 1
dataoutspi @
;


: main
h# 40 h# 0
spi
h# 00 h# 0
spi
h# 00 h# 0
spi
h# 00 h# 0
spi
h# 00 h# 0
spi
h# 95 h# 0
spi
h# FF h# 0
spi

begin dataoutspi @ h# 00  = 
h# 2A h# 0
spi
until
;







