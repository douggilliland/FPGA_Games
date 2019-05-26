# Bluetooth

## Integrantes del equipo de trabajo:

### 1 Maria Camila Teresa Abril Buitrago mtabrilb@unal.edu.co

### 2 Duvan Andrés Agudelo Amado daagudeloa@unal.edu.co

### 3 Johan David Muñoz Olarte jodmunozol@unal.edu.co


## Descripción general del sistema: (tomado del documento de clase)

Bluetooth es una teconología que permite el intercambio de información de manera inalambrica entre dispositivos.
Opera en una frecuencia de banda abierta a cualquier sistema que se encuentra en un rango de 2.400MHz - 2.500MHz
## Descripción de la caja Funcional  (in/out)
La caja funcional posee las señales Done, Busy y Enable las cuales se encargan de suministrar información sobre el estado del proceso de transferencia de datos, la señal de entrada d in es de 8 bits al igual que la de salida d out, estas señales corresponden a la información de entrada y salida del dispositivo, la salida TXD se refiere a los datos trasmitidos y la señal RXD a los datos recibidos.

![inOut](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/CN.png)


## Descripción funcional:

![fun](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/FRX.png)
![fun](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/FTX.png)

## Descripción Estructural:

![estructural](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/ERX.png)
![estructural](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/ETX.png)

## Diagrama de Estados:
![Estados](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/EstadosRx.png)
![Estados](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/01BLUETOOTH/Version_02/03%20document/img/EstadosTx.png)

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:

www.unipamplona.edu.co/unipamplona/portalIG/home_40/recursos/05_v25_30/revista_27/17052016/13.pdf

