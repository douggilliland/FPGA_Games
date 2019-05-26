# PWM ULTRASONIDO

## Integrantes del equipo de trabajo:

### 1 Christian Camilo Cuestas Ibáñez cccuestasi@unal.edu.co
### 2 Daniel Alejandro Rodríguez Chávez daarodriguezch@unal.edu.co
## Descripción general del sistema: (tomado del documento de clase)

El sistema de ultrasonido se encarga de medir la distancia con el uso de módulos de oscilación ultrasónica HC-SR04. El sistema se encarga de controlar el sensor, contar el tiempo de regreso de la onda y calcular la distancia en función del tiempo. El módulo HC-SR04 recibe un pulso de un ancho mayor a 10&mu;S como requerimiento exigido para éste, a través del pin **trigg**, iniciando el envío de la onda. Al rebotar la onda en un objeto y regresar, se envía a un módulo de conteo un pulso similar al recibido por el sensor, el cual, entre pulso recibido y pulso enviado, también tiene el requerimiento de no excederse la medición total de la distancia de interés menor a 1.026 cm. El sistema cuenta el tiempo desde el envío del pulso (por la salida **trigg**) de 10&mu;s, según dice la hoja de cálculo hasta la recepción del eco (por la entrada **ECHO**). Luego, calcula la distancia con la fórmula: (<i>tiempo contado</i>)*(342/2) = <i>distancia</i>. Para contar en centímetros (cm), la unidad de tiempo la cual resulta siendo un ciclo de reloj y que será base unitaria para el módulo que haga conteo, será el periodo de una frecuencia de 34.2kHz. Finalmente, envía por la salida **d** el dato de 8-bits de la distancia.

## Descripción de la caja Funcional  (in/out)

La caja negra del sistema de ultrasonido tiene como salida **d**, que es un dato de 8-bits con la distancia calculada. También, tiene como salida hacia el sensor de ultrasonido un <i>trigger</i> (**trigg**) para que empiece el conteo. La entrada **ECHO** recibirá un pulso del sensor al momento de recibir el eco.

La señal **ENABLE**(de entrada) se utiliza para dar inicio al proceso de medición. La señal **DONE**(de salida) para indicar que el resultado de la medición ya está disponible en la salida **d**.

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/08ULTRASONIDO/Version_02/03_document/img/UltrasonidoDiagramaCajaNegra.jpg)


## Descripción funcional:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/08ULTRASONIDO/Version_02/03_document/img/D.%20Funcional%20Ultrasonido.jpg)



## Descripción Estructural:

El sistema consta de 3 bloques: dos <i>Divisores de frecuencia</i>, un <i>Contador</i>, un generador de pulsos y un módulo donde se calcula una <i>División</i> por 2. los divisores de frecuencia transforma la señal de 100MHz (**clk**) en una señal de 34.2kHz y una de 100kHz, y entregan al bloque Contador una señal **CLKOUT** de 34.2kHz, y al Generador de Pulsos la de 100kHz, necesarios para el conteo del tiempo específico para medir de 1 cm en 1 cm y para suministrar el pulso de 10 &mu;s, respectivamente. El Contador se encarga de contar el tiempo cada ciclo de reloj, y comunicarse con el Generador de Pulsos, para que este mande una señal **trigg** al inicio de la medición y contar el tiempo que demora la señal de **ECHO** al momento de ser uno (1), en volver a ser cero (0). Cuando **ECHO** se hace 0 lógico, se detiene el conteo y se hace saber  que se realizó la medición(**DONE**=1) y el dato del tiempo está listo en **COUNT** para transformarlo en distancia por el módulo llamado Divisor. Este módulo obtiene el valor de **COUNT** y lo divide por dos (2) de forma binaria, entrega el resultado por la salida **d** y establece que la salida **DONE** es 1, para hacer saber que la medición de la distancia se ha completado.


![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/08ULTRASONIDO/Version_02/03_document/img/D.%20Estructural%20Ultrasonido.jpg)


## Diagrama de Estados:

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/08ULTRASONIDO/Version_02/03_document/img/D.%20De%20Estados%20Principal%20Ultrasonido.jpg)

![](https://github.com/Fabeltranm/FPGA-Game-D1/blob/master/HW/RTL/08ULTRASONIDO/Version_02/03_document/img/D.%20De%20Estados%20Ultrasonido.jpg)

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:
<!--
<ul> 
<li><b>Raúl Alvarez.</b> <i>Cómo Medir Distancias con el Sensor Ultrasónico PING</i>
<p>URL: <a href="url">http://tecbolivia.com/index.php/articulos-y-tutoriales-microcontroladores/17-como-medir-distancias-con-el-sensor-ultrasonico-ping</a></p></li> 
</ul> 
-->

