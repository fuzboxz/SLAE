; HelloWorld.asm
; Author: fuzboxz

global _start

section .text

_start:

	; print hello world on the screen
	
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, message ; puts the ADDRESS of message into ecx
	mov edx, mlen
	int 0x80

	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

 
section .data ;

	message: db "Hello World!" ; label: define byte <value>
	mlen	equ $-message


