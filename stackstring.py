#!/usr/bin/python3

import sys
import binascii

if len(sys.argv) != 2:
    print("Usage: stackstring.py <string to convert>")
else:
    print("Length: " + str(len(sys.argv[1])))
    string = sys.argv[1][::-1]
    lst = [string[i:i+4] for i in range(0, len(string), 4)]
    for i in lst:
        print('push 0x' + binascii.hexlify(bytes(i,'ascii')).decode('ascii') + ' ; ' + i)

