#!/bin/sh

if [ $# -eq 0 ]; then
	echo "Sytnax: $0 <program>";
	return 1;
fi

if [ ! -d "$(pwd)/$1" ]; then
	echo "\"$1\" is not a directory";
	return 2;
fi

if [ ! -d "$(pwd)/$1/src/" ]; then
	echo "\"$1\" does not contain \"src\" directory";
	return 2;
fi

echo "Building program $1 ...";
cd "$1/src"
nasm boot.asm -o ../bin/boot.bin

if [ ! $? -eq 0 ]; then
	echo "Unable to compile, exiting";
	return 3;
fi

echo "Program compiled, running QEMU"
qemu-system-i386 -fda ../bin/boot.bin
