# ALMACENAMIENTO SD

## Integrantes del equipo de trabajo:

### 1 Sergio Ariel Urian Niño sauriann@unal.edu.co

### 2 Jorge Eduardo Rondón Ruiz jerondonr@unal.edu.co


## Descripción general del sistema: (tomado del documento de clase)

Este sistema permite la comunicación con un dispositivo de almacenamiento llamado "micro SD card". Dicha comunicación puede realizar funciones de lectura y almacenamiento de datos. Para establecer dicha comunicación, se utiliza un protoolo serial llamado SPI (Serial Peripheral Interface). Este protocolo maneja la arquitectura Maestro-Esclavo, que permite la transferencia de datos entre un dispositivo maestro y varios esclavos. Para este caso solo existira un esclavo (tarjeta micro SD).

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_01/03%20document/ProtocoloSPI.png)

Imagen tomada de [1].

El protocolo SPI se compone de un bus de cuatro lineas las cuales son:

1. Reloj (CLK).
2. Master-Out, Slave-In (MOSI). 
3. Master-In, Slave-Out (MISO).
4. Chip Select (CS).

La linea de reloj **CLK** es generada por el dispositivo maestro para sincronizar el intercambio de datos. La linea marcada como **MOSI** es la linea por medio de la cual el dipositivo maestro le envia datos al esclavo. La linea marcada como **MISO** permite el envio de datos desde el esclavo hacia el maestro. **CS** suspende o permite la comunicación entre el Maestro y el Esclavo.

El elemento para almacenar e implementar la interfaz anteriormente expuesta es una tarjeta micro SD la cual opera por medio de  8 entradas (pines).

Internamente la tarjeta **SD** comienza con una **Interfaz de Manejo** la cual construye el **Bus** o paquete de información que va a ingresar. Luego, la **Interfaz del Controlador de la Tarjeta** ejecuta protocolos según la información que contenga el paquete o bus de datos que se ingrese (todo esto se sincroniza con un reloj **CLK** el cual es la herramienta que permite caracterizar y separar los grupos de datos o bus), como penúltimo paso el **Controlador de Interfaz de Tarjeta** envía el paquete o bus de datos con las instrucciones precisas al **Núcleo de interfaz de Memoria** donde finalmente el bus ingresa al Núcleo de Memoria donde se almacenará, modificará o se copiará según la instrucción que tenga.

La prioridad o esencia del sistema es la **Solicitud de Control** y la **Solicitud de Datos**; la **Solicitud de Control** es la encargada de acceder a la memoria **SD** de forma ordenada y a ubicaciones puntuales, mientras , la **Solicitud de Datos** se encarga de guardar, sobrescribir o consultar los datos en dicha ubicación para posteriormente informar su estado y retomar una nueva orden.
## Descripción de la caja Funcional  (in/out)
La caja negra o caja funcional posee una entrada de relog (clk) al dispositivo maestro, una entrada de datos (Data(IN)) por medio de la cual se envian los datos a guardar en el dispositivo de almacenamiento desde el procesador central, una entrada de habilitacion (enable) que permite indicarle al dispositivo maestro que se quiere almacenar o leer datos, una entrada de direccion (addr) que permite indicar la direccion de memoria dela micro SD en la cual se almacenara o de la cual se leeran los datos, una entrada (R/W) que indica si se esta requieriendo un proceso de lectura de datos o uno de almacenamiento, una salida (done) que indica si el sistema esta disponible para leer o almacenar datos, una salida de datos (data(out)) por medio de la cual se entregan los datos en caso de una solicitud de lectura de datos y las cuatro lineas (clk, MOSI, MISO, CS) del protocolo SPI entre el dispositivo maestro (FPGA) y el esclavo (tarjeta micro SD).


![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_01/03%20document/Cajafuncional3.png).


## Descripción funcional:

El diagrama funcional inicia con la lectura de los valores de las entrada de reloj y Enable. Adicionalmente se asume que Done esta en 1, es decir, que el driver esta listo para recibir ordenes. En el momento en el que Enable sea igual a 1, se procede a cargar los valores de R/W y addr. Despues de ello, se verifica el valor que posee la entrada R/W y apartir de el se procede dos formas:

  1. El proceso de almacenamiento de datos posee un protocolo que serializa los datos ingresados paralelamente en cada uno de los pines del arreglo Data(in) y posteriormente se hace uso del protocolo SPI para transferencia de datos con la micro SD.
  2. El proceso de lectura de datos toma la información deseada por medio del protocolo SPI (almacenada en la micro SD) y posteriormente se realiza un proceso de conversion de tipo serial a paralelo el cual se entrega por el bus de salida Data(out)[15:0]
  
 
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_01/03%20document/diagrama_funcional(2).PNG)

Protocolo SPI

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_01/03%20document/funcional.png)

## Descripción Estructural:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_01/03%20document/DiagramaEstructural.png)

## Diagrama de Estados:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/05MicroSD/Version_01/03%20document/DiagramadeEstados.png)

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:

[1] https://es.wikipedia.org/wiki/Serial_Peripheral_Interface#/media/File:SPI_single_slave.svg

