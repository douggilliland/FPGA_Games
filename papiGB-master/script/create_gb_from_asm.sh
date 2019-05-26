#! /bin/bash

rgbasm -o ${1}.obj ../tests/asm/${1}.asm 
rgblink -m ${1}.map -n ${1}.sym -o ${1}.gb ${1}.obj 
