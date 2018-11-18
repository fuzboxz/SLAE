; Filename: strings.nasm
; Author: Jozsef Ottucsak

global _start

section .text

_start:

    ; copy string from source to destination
    mov ecx, sourceLen
    lea esi, [source]
    lea edi, [destination]

    cld ; clear direction flag = low memory-> high memory copy
    rep movsb  ; repeat movs with one byte at a time ecx (sourceLen) number of times

    ; print using syscall

    mov eax, 0x4 
    mov ebx, 0x1
    mov ecx, destination
    mov edx, sourceLen
    int 0x80

    ; string comparison

    mov ecx, sourceLen
    lea esi, [source] ; load address of source into source index register
    lea edi, [comparison] ; load address of comparison into destination index register
    repe cmpsb ; repeat until ecx is 0. sets ZF 

    jz SetEqual
    mov ecx, result2
    mov edx, result2Len
    jmp Print

SetEqual:
    mov ecx, result1
    mov edx, result1Len

Print:
    mov eax, 0x4
    mov ebx, 0x1
    int 0x80

    mov eax, 1
    mov ebx, 10 ; sys_exit syscall
    int 0x80

section .data

    source: db "Hello World!", 0xA
    sourceLen equ $-source

    comparison: db "Hello"
    
    result1: db "Strings are Equal", 0xA
    result1Len equ $-result1

    result2: db "Strings are not equal", 0xA
    result2Len equ $-result2


section .bss

    destination: resb 100