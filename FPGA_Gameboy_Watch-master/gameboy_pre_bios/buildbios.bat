..\rgbds\rgbasm -o jbios.o jbios.asm
..\rgbds\rgblink -o jbios.bin jbios.o
..\rgbds\bin2hex jbios.bin jbios.hex

cp jbios.bin ..\roms\
cp jbios.hex ..\roms\