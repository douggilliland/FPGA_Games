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
