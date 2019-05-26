# memoria FIFO ciclica

## Integrantes del equipo de trabajo:

### FERNEY ALBERTO BELTRAN MOLINA  fabeltranm@unal.edu.co

## Descripción general del sistema: 

un buffer FIFO (First In/First Out) es una de banco de memoria que permite escribir y leer datos de él. A diferencia de un memoria de RAM, en la memoria FIFO no se especifican direccionen, solo se tiene dos señales de control para leer o escribir. El orden en que se ingresan los los datos, determina el orden en que se lee los mismos.

Un buffer FIFO asincrónico, es aquel en que los ciclos de de escritura y lectura pueden ocurrir desde dos relojes diferentes.

Para garantizar que no se llene el buffer FIFO y se pierdan datos, se debe garantizar que la velocidad de lectura  sea igual o mayor a la velocidad de escritura. De igual manera, el tamaño del buffer debe garantizar el almacenamiento  completo de datos de escritura.

El buffer FIFO circular, para escribir/leer los datos, trabaja con dos apuntadores  que se incremententan a medida que se escribe o leer. Cada dato que se almacene en el buffer FIFO, es guardado en la posición donde apunta wr_ptr. Wr_ptr se incrementa de manera circular. Cada vez que se leer un dato del buffer FIFO el apuntador rd_ptr se incrementa de manera ciclica.

## Descripción de la caja Funcional  (in/out)

Señales de control:

wr -> permite que un dato sea escrito en la FIFO

rd -> permite leer el dato que esta en la cabeza de la pila FIFO  y luego elimina el dato. (siempre se lee el dato que esta en la cabecera de la pila)

Señales de estado:

full -> se activa cuando el buffer esta lleno.
empty -> se activa cuando el buffer FIFO esta vacio.

para ello se cuenta con dos registros que apuntan al inicio  y al final de los datos,  wr_ptr y rd_ptr

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/03FIFO/img/imagen.png)


## Descripción funcional:


## Descripción Estructural:

## Diagrama de Estados:


## Arquitectura del periférico:


## Diagrama de bloques del periférico:


## referencias:

