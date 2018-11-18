global _start

_start:
	mov ecx, 0xff
	
loop:
	push ecx
	
	mov eax, 0x4
	mov ebx, 0x1	
	mov ecx, esp 
	mov edx, 0x8
	int 0x80

	pop ecx
	loop loop

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80
