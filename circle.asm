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
    call Circ   ; a = Circ(d,e)

    ld  hl, PAL
    ld  b,  0
    ld  c,  a
    add hl, bc  ; hl = PAL+a

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

; Calculate: Index i in Borders table for which: B*B*4 + C*C <= i
; Result in A
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
    ex  de, hl  ; de = B*B*4 + C*C

    ld  (TEMP), sp
    ld  sp, Borders
    ld  b,  BordersCnt
    or  a       ; clear C flag
Loop:
    pop hl      ; pop border
    sbc hl, de  ; hl = border - B*B*4 + C*C
    jp  m,  LoopEnd ; jump if B*B*4 + C*C > border
    djnz Loop
LoopEnd:
    ld  sp, (TEMP)
    ld  a, BordersCnt
    sub b       ; a = BordersCnt - b
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
    .ascii " .:-=+*%#@"
Borders:
    .word 1600
    .word 1225
    .word 900
    .word 625
    .word 400
    .word 225
    .word 100
    .word 25
    .word 4
BordersCnt = (. - Borders)/2

.section .bbs

TEMP:
    .word 0
