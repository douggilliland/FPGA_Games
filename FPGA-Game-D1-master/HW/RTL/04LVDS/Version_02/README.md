# VISUALIZACIÓN lvds

## Integrantes del equipo de trabajo:

###  Juan David González Muñoz judgonzalezmu@unal.edu.co
###  Carlos Alberto Pérez Rodríguez caaperezro@unal.edu.co

## Descripción general del sistema:

El sistema de señal diferencial de bajo voltaje o LVDS, es un sistema de transmisión de señales a alta velocidad sobre medios de transmisión baratos, como el par trenzado.Es un sistema de señal diferencial, lo que significa que la señal es transmitida por duplicado por el emisor pero con diferente voltaje, una señal transmitida con signo positivo, mientras que la otra es transmitida con signo negativo. Para ello se requieren dos cables diferenciados. Una vez la señal llega al receptor, éste se encarga de comparar ambas señales, y comprobar cuál de las dos tiene mayor potencial y asignar el valor lógico que corresponda.

La transmisión de los datos de los sistemas que utilizan este tipo de transmisión de señal se realiza en serie (bit a bit), pues es necesario doblar el número de cables usados en la transmisión, lo que en sistemas de transmisión en paralelo sería inviable. El objetivo de la transmisión diferencial es poder recuperar más fácilmente la señal en el receptor, gracias a que es más fácil comprobar qué señal es más positiva que otra, que obtener el potencial de la señal.

## Descripción de la caja Funcional  (in/out)

![Caja Negra](https://user-images.githubusercontent.com/31424774/30376139-d9a95820-9850-11e7-9a39-f545244f76ff.jpg)

## Descripción funcional:

![diagrama](https://user-images.githubusercontent.com/31424774/30913324-634817b0-a355-11e7-8e12-1b2ab39180be.jpeg)

## Descripción Estructural:
![diagrama estructural](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/04LVDS/Version_02/03%20document/estructural.png)
  


## Diagrama de Estados:


## Arquitectura del periférico:


## Diagrama de bloques del periférico:


## referencias:
