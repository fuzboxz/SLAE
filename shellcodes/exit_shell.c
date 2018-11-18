#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xc0\x40\x31\xdb\xcd\x80";

main()
{
    printf("Shellcode Lenth: %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}