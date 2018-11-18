#!/bin/bash

echo '[-] Assembling with nasm...'
nasm -f elf32 -o $1.o $1.nasm

echo '[-] Linking object...'
ld -m elf_i386 -o $1 $1.o

echo '[-] Cleaning up object file...'
rm $1.o

echo '[-] Done!'
