import binascii
import random

'''
	Textbook Hastad Attack Method
'''
def hastad(ciphertexts, moduli, e=3):
	if not (len(moduli) == len(ciphertexts) == e):
		raise RuntimeError("Moduli and ciphertext arrays have to be equal in length and contain at least as many elements as e")

	# compute the message using chinese remainder theorem and coppersmith principle
	return crt(ciphertexts, moduli).nth_root(e)
	
'''
	Hastad Attack with linear padding enabled
	(padding via arithmetic addition of const_array)
'''
def linear_padding(ciphertexts, moduli, pad_array, const_array=(), e=3, eps=1/8):
	if not(len(ciphertexts) == len(moduli) == len(pad_array) == len(const_array) == e):
		raise RuntimeError("Moduli and ciphertext arrays have to be equal in length and contain at least as many elements as e")
		
	'''
	Init placeholder values
	ciphertexts: ciphertext arrays
	T_array: CRT coefficients
	moduli: modulus arrays
	pad_array: linear coefficient of padding applied to message during encryption
	const_array: constant pad added to message during encryption (optional)
	'''
	T_array = [Integer(0)]*e
	crt_array = [Integer(0)]*e
	polynomial_array = []
	
	# populate crt and T arrays with appropriate values using CRT
	for i in range(e):
		crt_array = [0]*e
		crt_array[i] = 1
		T_array[i] = Integer(crt(crt_array,moduli))
	
	# computer the product of all the crt polynomials
	G.<x> = PolynomialRing(Zmod(prod(moduli)))
	for i in range(e):
		polynomial_array += [T_array[i]*((pad_array[i]*x+const_array[i])^e - Integer(ciphertexts[i]))] # representation of polynomial f(x) = (A*x + b) ^ e - C where (A*x + b) is padding polynomial
		
	# creates a monic polynomial from the sum of the individual polynomials
	g = sum(polynomial_array).monic()
	
	# solve for the roots of this polynomial (solutions to x, the message m)
	roots = g.small_roots()
	
	# return value if single root found; otherwise, the task has failed
	return roots[0] if len(roots) >= 1 else -1
	
def convert_to_int(message):
	m = 0L
	for i in message:
		m += ord(i)
		m <<= 8
	return m

#print convert_to_int("asdf _qwer")
	
def decode(message):
	m = ""
	message = Integer(message)
	
	if message <= 0:
		print Integer(message)
	
	while message > 0:
		m = chr(message & 0xff) + m
		message >>= 8
	return m

'''
	Test the function of the non padded hastad attack.
	
	Limitation: does not work with input string m containing
	spaces or similar chars such as '_'
'''	
def test_no_padding(m = convert_to_int("hello")):
	e = 3
	bound = 2^1024
	ciphertexts = []
	moduli = []
	
	for i in range(e):
		p = random_prime(bound, proof=false)
		q = random_prime(bound, proof=false)
		n = p*q
		c = Integer(pow(m,e,n))
		moduli += [Integer(n)]
		ciphertexts += [c]
		
	assert hastad(ciphertexts,moduli,e) == m
	print("Success! The recovered message is equal to: " + hex(m)[2:].decode("hex"))
	return 0

'''
	Test the function of the linear padding enabled hastad attack.
	
	Limitation: does not work with input string m containing
	spaces or similar chars such as '_'
'''
def test_linear_padding(m = convert_to_int("solved")):
	moduli = []
	ciphertexts = []
	pad_array = []
	const_array = []
	e = 3
	pad_bound = 2^512
	prime_bound = 2^1024
	
	for i in range(e):
		pad = random.randint(0, pad_bound)
		constant = random.randint(0, pad_bound)
		pad_array += [pad]
		const_array += [constant]
		p = random_prime(prime_bound, proof=false)
		q = random_prime(prime_bound, proof=false)
		n = p*q
		moduli += [n]
		ciphertexts.append(pow(pad*m + constant,e,n))
		
	assert linear_padding(ciphertexts, moduli, pad_array, const_array) == m
	print("Success! The recovered message is equal to: " + hex(m)[2:].decode("hex"))
	return 0
	
#test_no_padding()
#test_linear_padding()