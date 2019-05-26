# ******ALMACENAMIENTO SD******
## Integrantes del equipo de trabajo:
### 1 Gabriel Hernán Cano González ghcanog@unal.edu.co
### 2 David Hernando Jiménez Rodríguez dhjimenezr@unal.edu.co
### 3 David Felipe Nieto Arboleda dfnietoa@unal.edu.co
## Descripción general del sistema: (tomado del documento de clase)

La comunicación de la micro SD se basa en la interfaz de 8 pines(**reloj**, línea de comandos/ Master Out Slave In (**MOSI**), líneas 4xData / Master In Slave Out (**MISO**) y **3xPower**). El protocolo de comunicación que admite la tarjeta para la inicialización es el protocolo **SPI** (Serial Peripheral Interface). El funcionamiento del sistema se basa en 5 módulos diferentes: módulo de inicialización de tarjetas (**CINM**), módulo inactivo (**IM**), módulo de lectura de tarjetas (**CRM**), módulo de escritura de tarjetas (**CWM**) y módulo de decisión (**DM**). Junto a los módulos hay una **CU** (unidad de control) para supervisar y controlar las actividades de cada módulo.

## Descripción de la caja Funcional (in/out)
La caja negra del proyecto de almacenamiento en microSD muestra dos bloques funcionales que especifican en protocolo SPI, el bloque "MASTER" muestra 6 señales de entrada, **R/W** describe lo que queremos hacer con la tarjeta, **R/W=1** indica que queremos leer información, con **R/W=0** indica que queremos escribir en ella. **dataIN** es un vector de 16 bits, con el cual indicamos la información a guardar, **EN** inicia los procesos, **RESET** reinicia todos los procesos y se regresa al punto inicial. **CLK** es la señal de reloj interna de la tarjeta la cual debe pasar por un divisor de frecuencia hasta 25MHz donde se tiene la señal de salida **CLKM** la cual es la señal que sincroniza todos los procesos en la tarjeta, por ultimo la señal **address** un vector de 8 bits, indica la dirección de memoria la microSD; el sistema recibe información del esclavo por medio de **DATA0** el cual es el mismo **MISO**.

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/bloques.png)




## Descripción funcional:

A continuación se muestra los diagramas de flujo de inicialización, lectura y escritura de la tarjeta

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/spiflux.png)
El diagrama anterior corresponde al SPI para la lectura y escritura de una tarjeta SD. Se inicia dando un valor inicial a las señales y registros necesarios y posteriormente se activa el proceso de lectura/escritura en la tarjeta cuando la señal **run**=1 activa el divisor de frecuencia y **cs**=0, el divisor genera el reloj **sclk** y en cada  flanco de bajada se envía el dato serializado a través del **mosi** y en el flanco de subida se lee el dato recibido por **miso**. Una vez finalizado el envío/recepción del dato se activa la señal **done**=1, se finaliza la operación del divisor de frecuencia con **run**=0 y **cs** y **countd** vuelven a su estado inicial y se reinicia el proceso por medio de la señal **reset**=1. 


![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/IDLE1.png)

Cuando el reloj **sclk** se encuentra activo se envía el comando **CMD0** esperando obtener la respuesta **R1**, al ser esta correcta se envían los comandos **CMD55** y **ACMD41** para completar el proceso de inicialización. Estos se generan continuamente (**CMD55+ACMD41**) hasta que se inicialice la tarjeta y de una respuesta de **R1**. Luego se envía el comando **CMD58** para identificar el modo de direccionamiento de la tarjeta (direccionamiento de bloques o direccionamiento de byte). Si se genera el direccionamiento de bytes, se emite el comando **CMD16** para fijar la longitud de bloque de datos a 512 bytes. Seguido del proceso de inicialización, la tarjeta pasa al módulo inactivo hasta que se genere el comando para lectura y escritura.


![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/RW.png)

La tarjeta se encontrará inactiva hasta tener una señal de lectura o escritura. La parte izquierda del diagrama describe la operación de lectura y la parte derecha la operación de escritura.El comando **CMD18** se enviará a través  del **MOSI**, y se tendrá una respuesta de la tarjeta a través del **MISO** e iniciará la lectura de los datos de la tarjeta junto con los bits **CRC**. En cuanto a la escritura el controlador genera el comando **CMD25** y empieza a escribir los datos. Al finalizar la escritura de datos los bits **CRC** son enviados a través de la linea **MISO**, indicando si la operación fue exitosa o no, en caso negativo se reinicia la escritura de los datos. Al completar la lectura o escritura el sistema verificará la señal de **RESET** para decidir si inicializar la tarjeta nuevamente o esperar una nueva señal de lectura o escritura 

## Descripción Estructural:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/spiblock.png)

## Diagrama de Estados:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/spistate.png)

## Arquitectura del periférico:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/Arquitectura_del_periferico.PNG)

## Diagrama de bloques del periférico:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_02/03%20document/Diagrama_de_bloques_del_periferico.PNG)

## referencias:
1. https://jes-eurasipjournals.springeropen.com/articles/10.1186/s13639-016-0060-8
2. http://www.dejazzer.com/ee379/lecture_notes/lec12_sd_card.pdf
3. https://learn.sparkfun.com/tutorials/serial-peripheral-interface-spi
4. http://elm-chan.org/docs/mmc/mmc_e.html
5. http://wiki.seabright.co.nz/wiki/SdCardProtocol.html
