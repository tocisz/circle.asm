CR = 0x0d
LF = 0x0a

.section .text

MAIN:
    ld  d, -20
L1_RET:
    ld  e, -40
L2_RET:
    ; d goes -20 .. 20 (outer loop)
    ; e goes -40 .. 40 (inner loop)
    ld  a, '#'
    rst 8

    inc e
    ld  a,e
    cp  40
    jr  NZ, L2_RET

    ld  a, LF
    rst 8

    inc d
    ld  a,d
    cp  20
    jr  nz, L1_RET

    ret


