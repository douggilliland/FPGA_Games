# Bluetooth

## Integrantes del equipo de trabajo:

### 1 Cristian Camilo Ortiz Aranda ccortiza@unal.edu.co

### 2 Carlos Andrés Martínez Riveros caramartinezriv@unal.edu.co

### 3 Robinson Steven Cárdenas Ariza rscardenasa@unal.edu.co


## Descripción general del sistema:
Sistema de comunicacion usando el modulo de bluetooth HC-05 y el protocolo de comunicacion UART. el objetivo es intercambiar informacion entre el modulo bluetooth y la FPGA. La forma de hacerlo es atraves del transmisor, receptor asincrono universal (UART).
 

COMUNICACIÓN SERIAL

![imagen2](https://user-images.githubusercontent.com/14295760/30022943-2b31ea60-9133-11e7-8ebd-f5efb8de9b40.png)

Las interfaces serie transmiten sus datos, un solo bit a la vez. Estas interfaces pueden funcionar en tan poco como un cable, normalmente nunca más de cuatro.


COMUNICACIÓN SERIAL ASINCRONA

Una interfaz en serie sincrónica siempre empareja su línea de datos con una señal de reloj, por lo que todos los dispositivos de un bus serie síncrono comparten un reloj común.
Asíncrono significa que los datos se transfieren sin soporte de una señal de reloj externa. Este método de transmisión es perfecto para minimizar los cables requeridos y los pines de E / S, pero significa que necesitamos poner un esfuerzo extra para transferir y recibir datos de forma fiable.

9600 8N1 - 9600 baudios, 8 bits de datos, sin paridad y 1 bit de parada - es uno de los protocolos en serie más utilizados.
Un dispositivo que transmita los caracteres ASCII 'O' y 'K' tendría que crear dos paquetes de datos. El valor ASCII de O (que es mayúscula) es 79, que se descompone en un valor binario de 8 bits de 01001111, mientras que el valor binario de K es 01001011. Todo lo que queda es añadir bits de sincronización.

![imagen4](https://user-images.githubusercontent.com/14295760/30022955-375db3e6-9133-11e7-824d-50842eccaeec.png)





## Descripción de la caja Funcional  (in/out)
![yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy](https://user-images.githubusercontent.com/14295760/31620529-19aba786-b25d-11e7-927d-4d0d9ad21b59.png)


## Descripción funcional:

![funcional rx](https://user-images.githubusercontent.com/14295760/32111242-924083f6-baff-11e7-9ca5-edc5d76862e8.jpg)


![funcionaltx](https://user-images.githubusercontent.com/14295760/32112168-255c212a-bb02-11e7-9a4c-50fe7fd12b05.jpg)





## Descripción Estructural:
![laij](https://user-images.githubusercontent.com/14295760/32114130-291602ee-bb08-11e7-926a-23bd06dbbc02.jpg)


## Diagrama de Estados:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

