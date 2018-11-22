global _start

section .text

_start:
	; register based adition
	mov eax, 0
	add al, 0x22
	add al, 0x11
	
	mov ax, 0x1122
	mov ax, 0x3344

	; overflow
	mov eax, 0xffffffff
	add eax, 0x2

	mov eax, 0
	add byte [var1], 0x22
	add byte [var1], 0x11

	add word [var2], 0x1122
	add word [var2], 0x3344

	mov dword [var3], 0xffffffff
	add dword [var3], 0x10

	; set / clear / complement (invert) carry flag
	clc
	stc	
	cmc

	; add with carry
	
	mov eax, 0
	stc
	adc al, 0x22
	stc
	adc al, 0x11	

	mov ax, 0x1122
	stc
	adc ax, 0x3344

	mov eax, 0xffffffff
	stc
	adc ax, 0x3344

	; substract
	mov eax, 10
	sub eax, 5
	stc
	sbb eax, 4

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

section .data
	var1: db 0x00
	var2: dw 0x0000
	var3: dd 0x00000000
