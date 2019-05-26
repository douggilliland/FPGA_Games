Camara ov7670.

Para poder visualizar la cámara en una pantalla con entrada VGA es necesario el diseño y comprensión de 6 módulos que son:
1.	Reloj. Es necesario realizar un divisor de frecuencia de 100Mhz a 50 y 25 Mhz.
2.	Reinicio.
3.	Captura de datos de cámara.
4.	Control de cámara.
  a.	Comunicación, puede ser “I2C” o module “sccb”.
  b.	Registros, indica al módulo de comunicación cuales son los datos que deben ser registrados.
5.	Modulo VGA, es el encargado de tomar todos los datos recibidos y poder enviarlos para observarlos en el proyector.
6.	Frame_buffer, encontramos un módulo adicional, es bastante importante.
  a.	Nos mantiene los datos de la imagen hasta que se adquiera toda.
  b.	Sincroniza la velocidad de pixel de la cámara y el monitor.
“es un IP, debe descargarse y anexarse”
