# TOUCH

## Integrantes del equipo de trabajo:

### 1 Christian Camilo Cuestas Ibáñez cccuestasi@unal.edu.co

### 2 Daniel Alejandro Rodríguez Chávez daarodriguezch@unal.edu.co


## Descripción general del sistema: (tomado del documento de clase)

El sistema de Touch es un módulo que se encarga de recibir información del usuario a través de toques en la pantalla del dispositivo, como interfaz hombre-máquina. Se encarga de medir la posición bidimensional de los toques y/o movimientos realizados en la pantalla touch. El sistema entrega las coordenadas de la posición del toque o movimiento. Debido a  que el controlador del Touch es el de referencia [ETP-4500UG-x](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/07TOUCH/Version_02/01%20datasheet/ETP-MER4050CEBG-03.pdf), la recepción de los datos es a través del protocolo RS232. El controlador tiene una velocidad de entrega de las coordenadas de máximo 180 puntos cada segundo.

## Descripción de la caja Funcional  (in/out)

El sistema de comunicación del <i>TouchScreen</i> tiene como entrada **Rx**, por donde llega una señal <i>serializada</i> asíncrona proveniente del controlador del dispositivo. Además tiene un reloj de nombre **clk** el cual se usará para medir el tamaño de bit transmitido a través del tiempo. También tiene dos salidas: **data** y **DONE**. la salida **data** es un bus de 8 bits para trasmitir de forma paralela la información de las coordenadas de los puntos enviadas por el controlador del dispositivo. La salida **DONE** es para indicar que los 8 bits ya están listos para ser leídos desde el bus **data**.

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/07TOUCH/Version_02/03%20document/img/TouchDiagramaCajaNegra.jpg)

## Descripción funcional:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/07TOUCH/Version_02/03%20document/img/D.%20Funcional%20Touch.jpg)

## Descripción Estructural:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/07TOUCH/Version_02/03%20document/img/D.%20Estructural%20Touch.jpg)
## Diagrama de Estados:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/07TOUCH/Version_02/03%20document/img/D.%20de%20Estado%20Touch.jpg)

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Referencias:

[Basics of UART Communication](http://www.circuitbasics.com/basics-uart-communication/)
