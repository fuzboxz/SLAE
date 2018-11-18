#!/bin/bash

echo '[-] Assembling with nasm...'
nasm -f elf32 -o $1.o $1.nasm

echo '[-] Linking object...'
gcc -m32 -o $1 $1.o

echo '[-] Done!'