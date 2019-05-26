# CAMARA

## Integrantes del equipo de trabajo:

### 1 Oscar Ivan Medina Rojas oimedinar@unal.edu.co

### 2 Fray Alexander Riscanevo Tellez fariscanevot@unal.edu.co


## Descripción general del sistema: 

La cámara digital es uno de los dispositivos electrónicos más populares no funcionan sobre la base de una película fílmica como las cámaras fotográfica tradicionales, sino sobre la base de un sensor electrónico interno que hace las veces de la película fílmica donde se graba o imprime la imagen captada luego se almacena en una memoria interna para que el usuario pueda disponer de ellas cuándo y cómo quiera. Los sensores para cámara pueden ser de cualquiera de los siguientes tipos: 

Por interpolación de colores: CCD y super CCD, CCD RBGE y CMOS. 

El OV7670, el modulo que vamos a usar, es un “system on a chip (SoC)” basado en tecnología CMOS con una capacidad de procesado de señal que ofrece distintas funciones de control de imagen, tales  como  control  de  exposición  automática,  control  del  balance  de  blancos, cancelación de ruido, además del control automático o manual de brillo, saturación, gamma y otros. Además cuenta con la posibilidad de trabajar a distintas resoluciones: VGA, QVGA, CIF, QCIF y resolución de imagen de 640 x 480 píxeles a 30 imágenes 
por segundo, y diferentes espacios de color : RGB555, RGB565 y YUV.  

El siguiente diagrama esquemático muestra un sistema básico basado en cámaras. El módulo de la cámara se alimenta de una sola fuente de alimentación de + 3.3V. Un oscilador externo proporciona la fuente de reloj para el módulo XCLK de la cámara. Con la configuración adecuada a los registros internos de la cámara a través del bus I2C, el reloj de píxeles de la fuente de la cámara (PCLK) y los datos de la cámara (datos [7: 0]) regresan al host con señal de sincronización como HREF y VSYNC.

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/03CAMARA/Version_01/03%20document/caja%20funcional.png?raw=true)

Se realiza la etapa de adquisición de la imagen. Requiriendose una intefaz de VGA, una etapa con memoria RAM, un módulo de captura de imagen, un módulo de control de cámara y un programa principal para reunir todos estos. En el datasheet del sistema omnivisión OV7670, se indica que la camara inicia entregando señal en formato YCbCr 4:2:2, en un tamaño de 640x480 pixeles.


## Descripción de la caja Funcional  (in/out)

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/03CAMARA/Version_01/03%20document/caja%20negra%204.png)

## Descripción Diagrama funcional:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/03CAMARA/Version_01/03%20document/DIAGRAMA%20FUNCIONAL%206.png)


## Descripción Estructural:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/03CAMARA/Version_01/03%20document/Diagrama%20estructural.png)

## Diagrama de Estados:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

