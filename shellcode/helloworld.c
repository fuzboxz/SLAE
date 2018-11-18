// compile with
// gcc -fno-stack-protector -z execstack _shellskeleton.c shellskeleton

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\xeb\x15\x31\xc0\xb0\x04\x31\xdb\x43\x59\x31\xd2\xb2\x13\xcd\x80\x31\xc0\x40\x31\xdb\xcd\x80\xe8\xe6\xff\xff\xff\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x72\x6c\x64\x21\x0a";

main()
{
    printf("Shellcode Lenth: %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}