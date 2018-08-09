import re

# parse values for n and c
text = open("cipher.txt", "r").read()
n = [int(i) for i in re.findall(r"n\s\=\s([0-9]+)", text)]
c = [int(i) for i in re.findall(r"c\s\=\s([0-9]+)", text)]

e = 7

# execute coppersmith method Hastad attach using assumption that broadcast
# message was the same in all instances