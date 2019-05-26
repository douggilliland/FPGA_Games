# SISTEMA DE AUDIO

## Integrantes del equipo de trabajo:

### 1 Lisseth Tatiana Herrera Rosero ltherreraro@unal.edu.co

### 2 Santiago Esteban Guevara Rozo seguevarar@unal.edu.co

### 3 Michael Fabian Sierra Tarazona mfsierrat@unal.edu.co


## Descripción general del sistema: 

En el módulo de audio se pretende garantizar la grabación de una voz por un lapso aproximado de 2 segundos,  digitalizar, guardar y reproducir esta señal, se utilizaran dos grandes modulos en el cual se tienen microfono y altavoz
En el módulo del micrófono se tendrá una señal análoga con frecuencia de 1 a 5 kHz, la cual entrará a un convertidor A/D, acontinuación se procesará en un filtro pasabajos logrando una salida de 18 bits; Esta entrará a nuestra FPGA nexys4 donde se guardará por módulos en un proceso FIFO sincrónico, el sincronismo de los clocks es necesario para acoplar todas las fases de dicho proceso.
En la segunda etapa (altavoz), entra dicha informacion a un convertidor D/A (PCM) el cual también logra amplificar esta señal para poder ser reproducida.


## Descripción de la caja funcional (Modulo Microfono):
En este módulo depende del modulo divisor de frecuencia. El divisor de frecuencia es necesario para obtener los clocks de sincranización de el módulo de micrófono y de altavoz.

Este modulo tiene entradas: 
* **Data** datos provenientes del micrófono (conformado por 32 bits) de los cuales solo 18 se van a usar para la salida 
* **Enable** para inicializar (conformado por 1 bit)

Este módulo tiene salidas:
* **Clk** El clock que necesita el micrófono para modular la señal y enviarla (conformado por 1 bit)
* **ws** necesario más adelante para seleccionar derecho o izquierdo (conformado por 1 bit)
* **Dataout** datos de salida serializado (conformado por 1 bit)
* **done** para indicar que finalizó la acción (conformado por 1 bit)

Y finalmente tiene un parametro
* **Count** para contar las interacciones 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/ESmicrofono1.jpg) 

### Descripción funcional (Módulo Micrófono MEMS):
Para que el modulo de microfono este activo la frecuencia del clk debe estar ser mayor a 1MHz y tener el voltaje VDD activo, pero esto se garantiza en el divisor de frecuencia.
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Mic.1.png) 

## Descripción de la caja funcional (Modulo Altavoz):
En este módulo tambien depende de el modulo divisor de frecuencia. 

Este modulo tiene entradas: 
* **Data** datos provenientes del micrófono ya serializados (conformado por 1 bit) 
* **Enable** para inicializar (conformado por 1 bit)

Este módulo tiene salidas:
* **Bclk** El clock que necesita el altavoz para recuperar los datos(conformado por 1 bit)
* **LRclk** necesario para seleccionar derecho o izquierdo (conformado por 1 bit)
* **Data_R** datos de salida canal derecho (conformado por 16 bit)
* **Data_L** datos de salida canal izquierdo (conformado por 16 bit)
* **done** para indicar que finalizó la acción (conformado por 1 bit)

Y finalmente tiene un parametro
* **Count** para contar las interacciones 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Esaltavoz.jpg) 

### Descripción funcional (Módulo Altavoz):
El LRclk tiene un delay de 1 ciclo de Bclk por lo tanto solo soporta frecuencias de 8KHz, 16KHz, 32KHz, 44.1KHz, 48KHz, 88.2KHz y 96KHz, pero esto se garantiza en el divisor de frecuencia.

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Altavoz1.png)

## Descripción de la caja funcional (Módulo Divisor de frecuencia):
Este modulo tiene entradas: 
* **Clk** El clock que necesita realizar la divison de señal (conformado por 1 bit)
* **Reset** para reiniciar el sistema (conformado por 1 bit)

Este módulo tiene salidas:
* **Clkout** El clock que se deseaba (conformado por 1 bit)
Y finalmente tiene como parametros
* **fi** Frecuencia de entrada
* **fo** Frecuencia de salida (la que se desea obtener)
* **Count** para contar las interacciones 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Imagenes%20sin%20usar/Div_freq.jpg) 

### Descripción funcional (Divisor de frecuencia):

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Divfreq.png) 


## Descripción Estructural: 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/estructural.jpg) 

## Diagrama de Estados:

### Diagrama de estado del MEMS:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Diagrama%20de%20estados%20MEMS.jpg)

### Diagrama de estado del altavoz:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_01/03%20document/Imagenes/Diagrama%20de%20estados%20altavoz.jpg)




## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:
-Datasheet Microfono mems SPH0645LM4H-B,[online] knowls, Disponible en: https://www.digikey.com/product-detail/es/knowles/SPH0645LM4H-B/423-1405-1-ND/5332432
-Datasheet Nexys 4TM FPGA Board Reference Manual,[online], Digilent Disponible en: http://store.digilentinc.com/nexys-4-artix-7-fpga-trainer-board-limited-time-see-nexys4-ddr/
-Datasheet PCM Audio MAX98357A,[online] Maxim integrated, Disponible en:http://www.alldatasheet.com/view.jsp?Searchword=Max98357a

