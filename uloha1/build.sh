#!/bin/sh
nasm src/nasmboot.asm -i"$(pwd)/src/" -o bin/boot.bin
qemu-system-i386 -fda bin/boot.bin
