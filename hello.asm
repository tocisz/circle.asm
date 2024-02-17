.section .text

MAIN:
    LD HL, TEXT
    CALL PRINT
    RET

PRINT:
    LD A,(HL)                   ; get character
    OR A                        ; is it $00 ?
    RET Z                       ; then RETurn on terminator
    RST 0x08                    ; output character in A
    INC HL                      ; next Character
    JP PRINT                    ; continue until $00

.section .data

TEXT:
    .asciz "Hello RC2014!\n"

