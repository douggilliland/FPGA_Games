código  en verilog de  módulo
// Declaracion de variables de entrada al sistema

module audio

input Bclk // reloj de SHP0645M4H
input ws
input Din // dato de entrada

// Declaracion de variables de salida del sistema

output Bclk // reloj de MAX98357A
output LRclk
output Dout // dato de salida

