
global _start

section .text

_start:
    xor eax, eax ; null out eax register to avoid null characters
    mov al, 0x4 ; set eax to 0x4 - write syscall

    xor ebx, ebx  ; null out ebx register to avoid null characters
    mov bl, 0x1 ; set ebx to 0x1 - file descriptor - 0x1 stout

    ; 0x00\nhello world in reverse order - hex encoded
    xor edx, edx ; set null
    push edx ; push null byte as a string separator
    push 0x0a646c72 ; \nrld
    push 0x6f57206f ; oW o
    push 0x6c6c6548 ; lleH

    mov ecx, esp ; address of Hello World\n0x00 that we will write to stdout
    mov dl, 12 ; length of bytes to output
    int 0x80 ; call syscall
    
    xor eax, eax ; null out eax register
    inc eax ; 0x1 exit syscall

    xor ebx, ebx ; return code
    int 0x80 ; call syscall