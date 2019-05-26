# PS/2 KEYBOARD

## Integrantes del equipo de trabajo:

### 1 Gilbert Andres Angulo Saucedo gaangulosa@unal.edu.co

### 2 Heriberto Forero Correa hforeroc@unal.edu.co

### 3 Daniel Alejandro Rodriguez Chavez daarodriguezch@unal.edu.co


## Descripción general del sistema: 

Un teclado PS/2 de 104 teclas para PC es un dispositivo razonablemente inteligente. Esto quiere decir que él mismo se encarga de la parte hardware del rastreo de teclas, de evitar los insufribles rebotes y de transmitirnos, mediante una trama perfectamente establecida, de los resultados de nuestras manipulaciones sobre sus teclas.

El teclado PS/2 tiene un mapa de teclas a las que asigna un código, de uno o dos bytes, para cada una de ellas y que son los códigos que nos va a transmitir para indicarnos que se está pulsando una tecla determinada. A estos códigos les vamos a llamar códigos de rastreo de teclado. Más abajo os muestro una imagen de un teclado estándar donde se muestran los códigos de rastreo de todas y cada una de las teclas:

![prj_ps2_scancode_01](https://user-images.githubusercontent.com/14281085/33488857-14863356-d680-11e7-9987-8d5c18ca8be4.gif)

El teclado PS/2 se conecta mediante cuatro hilos. Dos de ellos son para alimentación Vcc a 5V y GND, y otros dos para las señales Data y Clock. El pinout de los conectores Mini-DIN PS/2 tanto hembra, los del PC, como machos, los del Teclado, es tal como se muestra en la imagen inferior:

![prj_ps2_connector](https://user-images.githubusercontent.com/14281085/33489787-e5cb0a0c-d682-11e7-960b-7bf9cd5dea29.gif)
 
En el Teclado PS/2 las señales Data y Clock con de "colector abierto". Esto quiere decir que para establecer un comunicación eléctricamente correcta debemos nosotros suministrar voltaje para el nivel lógico alto, y es él el encargado de dar los correspondiente niveles lógicos bajos, tirando nuestra señal a GND cuando así sea necesario. Este tema se soluciona conectando dos resistencias de 10K entre dichas líneas y Vcc por lo que siempre tendrán nivel lógico alto, salvo cuando el teclado disponga lo contrario y lo tire a GND para dar lo correspondientes niveles lógicos bajos. Esto es lo que se llama conectar unas resistencias Pull-Up.


## Descripción de la caja Funcional  (in/out)

El diagrama de caja Funcional nos ayuda a identificar claramente las entradas y salidas y estudiar las relaciones que existen entre ellas, permitiendo así maximizar la eficiencia de los sistemas sin tener que introducirnos en los procesos de la pantalla Touch.

si deseamos saber cómo funciona el dispositivo entonces nos vemos obligados a destapar “la Caja Negra” y estudiar ese subsistema en forma más precisa. Con los subsiguientes diagramas

![electronica - diagrama blackbox](https://user-images.githubusercontent.com/14281085/33049993-9bc17e1e-ce30-11e7-8a28-c5743c0a8214.png)

tiene como entradas los datos serializados por el TOUCHSCREEN-CONTROLLER ETP-4500UG-B, llamada Rx, con señales de 1 bits cada una. la salida es el resultado de la posición de los datos sobre una grilla planteada sobre la pantalla, en la que los paquetes funcionan a la frecuencia del reloj del controlador (6.25*10^-3 s). Ademas, la señal de reloj. La señal DONE de salida, se utiliza para indicar que se envió un resultado, debido a una puslion hecha sobre el screen



## Descripción funcional:
Representación simbólica de las acciones en un sistema por medio de bloques funcionales enlazados por líneas de acción.Las líneas de acción no representan necesariamente conexiones físicas.En el contexto del control automático, un diagrama funcional es a veces denominado simplemente diagrama de bloques.

![df](https://user-images.githubusercontent.com/14281085/30354033-aee00e7e-97ef-11e7-8f62-cc3cc24b4cc6.png)

## Descripción Estructural:

es la representación gráfica de los diferentes procesos de un sistema y el flujo de señales donde cada proceso tiene un bloque asignado y éstos se unen por flechas que representan el flujo de señales que interaccionan entre los diferentes procesos.

![de](https://user-images.githubusercontent.com/14281085/30379659-dd92b3b2-985c-11e7-9805-4e012169c63e.png)

## Diagrama de Estados:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Arquitectura del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## Diagrama de bloques del periférico:

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

## referencias:

- http://www.wikilengua.org/index.php/Terminesp:diagrama_funcional

- https://es.wikipedia.org/wiki/Diagrama_de_bloques_funcional

- https://carolbr.wordpress.com/caja-negra/

- PS2 Device Datasheet PS2D V1.2.pdf

- Harris, Brohters. Digital Design and Computer Architecture
