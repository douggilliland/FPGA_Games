## Integrantes del equipo de trabajo:

### 1 Nelly Alexandra Rodriguez Villa   nelarodriguezvil@unal.edu.co

### 2 Yilmar Fernando Penalosa Herrera  yfpenalosah@unal.edu.co

### 3 David Stevent Avila Vela          dsavilav@unal.edu.co


## Descripción general del sistema:

En el modulo de audio del proyecto se necesita hacer tres funciones básicas: grabar, guardar y reproducir. 
Como micrófono se implementara los dos SPH0645LM4H-B del cual saldrá datos de a 1 bit (forma serial) para hasta completar 18 bits,posteriormente los datos deben ser leídos del almacenamiento o memoria de donde se toman los 16 bit mas signigficativos(MSB) y no se toman los dos menos significativos(LSB), por ultimo se llevara estos datos de a 1 bit al MAX98357A y de alli a los parlantes parlante.

* CAJA NEGRA DRIVER MICROFONO.
 ![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/CAJA%20NEGRA%20MICROFONO.jpeg)
* CAJA NEGRA DRIVER MAX98357A.
 ![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/CAJA%20NEGRA%20MAX.jpeg)
 

## Descripción funcional:

* Diagrama funcional driver microfono mems SPH0645LM4H-B:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIAGRAMA%20FUNCIONAL%20MICROFONO.jpeg)

* Diagrama funcional del divisor de frecuencia:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIAGRAMA%20FUNCIONAL%20DIVISOR%20DE%20FRECUENCIA.jpeg)

* Diagrama funcional driver para MAX98357A:
![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIAGRAMA%20DE%20FLUJO%20MAX.jpeg)

## Descripción Estructural:

* Diagrama estructural controlador del micrófono:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIAGRAMA%20FUNCIONA%20MICROFONO.jpeg)

* Diagrama estructural controlador del MAX98357A:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIAGRAMA%20DE%20BLOQUES%20MAX.M.jpeg)


## Diagrama de Estados:

DIAGRAMA DE ESTADO(MICRÓFONO):


![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIGRAMA%20DE%20ESTADOS%20MICROFONO.png)


DIAGRAMA DE ESTADOS(MAX98357A): 

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/06PCM-AUDIO-MICROFONO/Version_02/03%20document/DIGRAMA%20DE%20ESTADOS%20MAX.png)


## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:

### https://www.maximintegrated.com/en/products/analog/audio/MAX98357A.html/tb_tab0
### https://cdn-shop.adafruit.com/product-files/3421/i2S+Datasheet.PDF

