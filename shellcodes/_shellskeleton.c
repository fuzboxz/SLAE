// compile with
// gcc -fno-stack-protector -z execstack _shellskeleton.c shellskeleton

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"SHELLCODE";

main()
{
    printf("Shellcode Lenth: %d\n", strlen(code));
    int (*ret)() = (int(*)())code;
    ret();
}