#!/bin/sh
cd src; #this is a NASM hack
nasm nasmboot.asm -o ../bin/boot.bin
qemu-system-i386 -fda ../bin/boot.bin
