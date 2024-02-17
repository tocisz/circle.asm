# ASCII-art circle on RC2014 in ASM

I was curious how much faster it will be in assembly than in [BASIC](reference/circle.bas) and [FORTH](reference/circle.f).

* [FORTH](reference/circle.f) is noticably faster than [BASIC](reference/circle.bas).
* [ASM](circle.asm) version is *much* faster than both [FORTH](reference/circle.f) and [BASIC](reference/circle.bas).

Resulting Intel HEX (see releases) has base address `0x8000` and can be run with [SCM](https://smallcomputercentral.com/small-computer-monitor).
