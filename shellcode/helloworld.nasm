; HelloWorld.asm
; Author: fuzboxz
; uses JMP-CALL-POP

global _start

section .text

_start:
	jmp short call_shellcode ; jump to call_shellcode to set up Hello World


shellcode:
	; print hello world on the screen
	xor eax, eax  ; zero out eax register
	mov al, 0x4 ; set al 4
	
	xor ebx, ebx ; zero out ebx
	inc ebx ; increment ebx

	pop ecx ; puts the ADDRESS of message into ecx
	
	xor edx, edx ; zero out edx register
	mov dl, 0x13 ; set dlregister to 13
	int 0x80 ; initiate WRITE syscall

	xor eax, eax ;zero out eax register
	inc eax ; increment eax
	xor ebx, ebx ; set return code as 0
	int 0x80 ; initiate syscall

 
call_shellcode:;
	call shellcode
	message: db "Hello World!", 0xa ; stores the address of Hello world string on stack

