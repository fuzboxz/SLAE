
global _start

_start:
	mov eax, 0x5 ; set counter to 5
	push eax ; push register to stack

loop:
	mov eax, 0x4
	mov ebx, 1
	mov ecx, var 
	mov edx, vlen
	int 0x80
	
	pop eax ; pop from stack to eax
	dec eax	; decrement value
	push eax; push it to stack
	jnz loop; if not zero, jump back up too loop

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80 

section .data
	var: db "hello world",$0A,$0D
	vlen equ $-var

