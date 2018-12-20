global _start

section .text

_start:
	xor eax, eax 
	mov edx, eax
	mov ecx, eax
	mov al, 0xb
	push edx
	push 0x683f2f2f
	push 0x6e3ff2f
	mov ebx, esp
	int 0x80

	
	
