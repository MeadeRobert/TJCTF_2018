It's just AM modulated audio with a 10kHz carrier frequency.

[https://forum.audacityteam.org/viewtopic.php?t=95331](https://forum.audacityteam.org/viewtopic.php?t=95331)
Demodulate it via the following nyquist code:
`(lowpass8 (mult *track* (hzosc 10000)) 10000)`

Injecting the code into the nyquist prompt effect:
[https://wiki.audacityteam.org/wiki/Nyquist_Basics:_The_Audacity_Nyquist_Prompt](https://wiki.audacityteam.org/wiki/Nyquist_Basics:_The_Audacity_Nyquist_Prompt)

Transcribe the flag:
`tjctf{y0uthought4ud10f0r3ns1c5w4s34sy}`