import re
import hashlib
load("hastad.sage")


# parse values for n and c
text = open("cipher.txt", "r").read()
moduli = [int(i) for i in re.findall(r"n\s\=\s([0-9]+)", text)]
ciphertexts = [int(i) for i in re.findall(r"c\s\=\s([0-9]+)", text)]
#hashable = re.findall(r"n\s\=\s[0-9]+", text)

# execute coppersmith method Hastad attach using assumption that broadcast
# message was the same with linear padding adding sha1(n) in all instances
consts = [int(hashlib.sha1(str(i)).hexdigest(), 16) for i in moduli]
#print hashlib.sha1(str(moduli[0])).hexdigest()

m = linear_padding(ciphertexts, moduli, [1]*7, consts, e=7)
print m
print decode(m)


'''
e = 7

#message = "tjctf{test}"
message = "tjctf{h0rs3s_h4v3_lonG_l3gS}"
moduli = [random_prime(2^1024, proof=false) * random_prime(2^1024, proof=false) for i in range(e)]
hashes = [int(hashlib.sha1(str(moduli[i])).hexdigest(), 16) for i in range(e)]
ciphertexts = [pow(convert_to_int(message)+hashes[i], e, moduli[i]) for i in range(e)]

m = linear_padding(ciphertexts, moduli, [1]*e, hashes, e)
print decode(m)
'''
