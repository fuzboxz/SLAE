; nasm -f elf32 -o $1.o $1.nasm
; gcc -m32 -o $1 $1.o
; needs gcc-multilib 
extern printf
extern exit

global main

section .text

main:
    push message
    call printf
    add esp, 0x4 ; adjust stack size by four

    mov eax, 0xa ;
    call exit

section .data
    message: db "Hello World", 0xA, 0x00
    mlen: equ $-message