LF = 0x0a

.section .text

Main:
    ld  d,  -20
L1:
    ld  e,  -40
L2:
    ; d goes -20 .. 20 (outer loop)
    ; e goes -40 .. 40 (inner loop)
    push de

    ld  b,  d
    ld  c,  e
    call Circ   ; bc = Circ(d,e)
    ld  hl, PAL
    add hl, bc
    ld  a,  (hl)
    rst 8

    pop de

    inc e
    ld  a,  e
    cp  41
    jr  nz, L2

    ld  a,  LF
    rst 8

    inc d
    ld  a,  d
    cp  21
    jr  nz, L1

    ret

; Calculate: B*B*4 + C*C <= 1600
; Result in BC
;
; Changes: bc, de, hl
Circ:
    ld  a,  b
    sla a       ; a = 2*B
    call SquareA ; hl = B*B*4
    push hl

    ld  a,  c
    call SquareA ; hl = C*C

    pop bc
    add hl, bc  ; hl = B*B*4 + C*C

    ld  de, 1600
    ex  de, hl  ; de = B*B*4 + C*C; hl = 1600
    xor a       ; clear C flag
    ld  b,  a
    ld  c,  a   ; bc = 0
    sbc hl, de  ; hl = 1600 - B*B*4 + C*C
    jp  m,  NoFill ; jump if B*B*4 + C*C > 1600
Fill:
    inc c
NoFill:
    ret

; HL = A*A
SquareA:
    or  a
    jp  p,  SquarePositiveA
    neg
SquarePositiveA:
    ld  h,  a
    ld  e,  a   ; h = e = |c|
; Multiply 8-bit values
; In:  Multiply H with E
; Out: HL = result
;
; Changes: b, d, hl
Mult8:
    ld  d,  0
    ld  l,  d
    ld  b,  8
Mult8_Loop:
    add hl, hl
    jr  nc, Mult8_NoAdd
    add hl, de
Mult8_NoAdd:
    djnz Mult8_Loop
    ret

.section .data

PAL:
    .ascii " #"
