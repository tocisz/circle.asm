LF    = 0x0a

.section .text

MAIN:
    ld  d, -20
L1_RET:
    ld  e, -40
L2_RET:
    ; d goes -20 .. 20 (outer loop)
    ; e goes -40 .. 40 (inner loop)
    push de

    ld  b,d
    ld  c,e
    call CI     ; HL = CI(d,e)
    
    ld  de, 1600
    ex  de, hl  ; de = CI(d,e), HL = 1600
    or  a       ; clear C flag
    sbc hl, de  ; hl := 1600 - CI(d,e)
    jp  m, NoFill ; jump if CI(d,e) > 1600
Fill:
    ld  a,'#'
    rst 8
    jr  IfEnd
NoFill:
    ld  a,' '
    rst 8
IfEnd:

    pop de

    inc e
    ld  a,e
    cp  41
    jr  NZ, L2_RET

    ld  a, LF
    rst 8

    inc d
    ld  a,d
    cp  21
    jr  nz, L1_RET

    ret

; Calculate: B*B*4 + C*C
; Result in HL
;
; Changes: bc, de, hl
CI:
    ld  a,b
    sla a
    call absA
    ld  h,a ; h,l := 0,b
    ld  e,a
    call Mult8 ; hl := B*B
    push hl

    ld  a,c
    call absA
    ld  h,a
    ld  e,a
    call Mult8

    pop bc
    add hl, bc
    ret

absA:
    or  a
    ret p
    neg
    ret

;
; Multiply 8-bit values
; In:  Multiply H with E
; Out: HL = result
;
; Changes: b, d, hl
Mult8:
    ld  d,0
    ld  l,d
    ld  b,8
Mult8_Loop:
    add hl,hl
    jr  nc,Mult8_NoAdd
    add hl,de
Mult8_NoAdd:
    djnz Mult8_Loop
    ret