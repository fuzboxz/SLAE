global _start

section .text

HelloWorld:
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg
	mov edx, msglen
	int 0x80
	ret

Exit:
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

_start:
	call HelloWorld
	call Exit

section .data
	msg: db "hello world",$0A,$0D
	msglen equ $-msg
