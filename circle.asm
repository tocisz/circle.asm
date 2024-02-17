LF    = 0x0a

.section .text

Main:
    ld  d, -20
L1:
    ld  e, -40
L2:
    ; d goes -20 .. 20 (outer loop)
    ; e goes -40 .. 40 (inner loop)
    push de

    ld  b,d
    ld  c,e
    call Circ     ; HL = Circ(d,e)
    ld  hl, PAL
    add hl, bc
    ld  a, (hl)
    rst 8

    pop de

    inc e
    ld  a,e
    cp  41
    jr  NZ, L2

    ld  a, LF
    rst 8

    inc d
    ld  a,d
    cp  21
    jr  nz, L1

    ret

; Calculate: B*B*4 + C*C <= 1600
; Result in BC
;
; Changes: bc, de, hl
Circ:
    ld  a,b
    sla a
    call AbsA
    ld  h,a ; h,l := 0,b
    ld  e,a
    call Mult8 ; hl := B*B
    push hl

    ld  a,c
    call AbsA
    ld  h,a
    ld  e,a
    call Mult8

    pop bc
    add hl, bc

    ld  de, 1600
    ex  de, hl  ; de = Circ(d,e), HL = 1600
    xor a       ; clear C flag
    ld  b,a
    ld  c,a     ; bc := 0
    sbc hl, de  ; hl := 1600 - Circ(d,e)
    jp  m, NoFill ; jump if Circ(d,e) > 1600
Fill:
    inc c
NoFill:
    ret

AbsA:
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

.section .data

PAL:
    .ascii " #"
