# Multiplicaci�n de n�meros binarios (ejemplo para los  otros grupos)

## Integrantes del equipo de trabajo:

### FERNEY ALBERTO BELTRAN MOLINA  fabeltranm@unal.edu.co

## Descripci�n general del sistema: (tomado del documento de clase)

El algoritmo de multiplicaci�n que se implementa se basa en productos parciales (PP). Se realiza la multiplicaci�n iniciando con el bit menos significativo del multiplicador, el resultado de la multiplicaci�n se suma al primer producto parcial y se obtiene  el segundo producto parcial; si el bit del multiplicador es �0� no se afecta el contenido de PP, por lo que no se realiza la suma. 
A continuaci�n se realiza la multiplicaci�n del siguiente bit (a la izquierda del LSB) y el resultado se suma al producto parcial pero corrido un bit a la izquierda.
Este proceso continua hasta completar todos los bits del multiplicador y el �ltimo producto parcial es el resultado final. 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen1.png)


## Descripci�n de la caja Funcional  (in/out)
la caja funcional o caja negra   tiene como entradas multiplicando y el multiplicador **(A y B)**, se�ales de **m** bits cada una. la salida es el resultado de la multiplicaci�n **PP** (Bus de 2m Bits). Ademas, la se�al de reloj (**CLOCK**), entrada. Las se�ales **INIT** y **DONE**, entrada y salida, se utilizan para iniciar el proceso de multiplicaci�n e indicar que el resultado esta a disponible respectivamente

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen2.png)


## Descripci�n funcional:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen3.png)


## Descripci�n Estructural:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen4.png)

## Diagrama de Estados:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen4_1.png)


## Arquitectura del perif�rico:

Se muestra el diagrama de caja funcional para el multiplicador; este m�dulo tiene como  entradas los operandos de 16 bits A y B y la se�al init y como salida el resultado de 32 bits PP y la se�al que indica que ya se realiz� la operaci�n done.

La asignaci�n (puede variar a criterio del dise�ador) dada a estas se�ales; el 
primer operando se encuentra asignado a la direcci�n BASE + 00, donde BASE es  la direcci�n de memoria asignada al perif�rico.

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen5.png)

## Diagrama de bloques del perif�rico:

Una vez definida la direcci�n de memoria para la informaci�n de entrada y salida del perif�rico
se debe adaptar el dise�o para que permita el intercambio de informaci�n con la CPU. 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/00EJEMPLOS/00MULTIPLICADOR%20(ejemplo)/Version_01/03%20document/img/imagen6.png)


## referencias:

Doc de la asignatura
