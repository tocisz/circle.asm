LF  = 10
ESC = 27

INT_TX = 8

.section .text

Main:
    ld  hl, Cls
    call Print
    ld  hl, CursorHide
    call Print
    call InitSquares
    call Draw
    ld  hl, CursorShow
    call Print
    ret

Draw:
    ld  d,  -20
L1:
    ld  e,  -40
L2:
    ; d goes -20 .. 20 (outer loop)
    ; e goes -40 .. 40 (inner loop)
    push de
;
    ld  b,  d
    ld  c,  e
    call Circ   ; a = Circ(d,e)
;
    ld  hl, PAL
    ld  b,  0
    ld  c,  a
    add hl, bc  ; hl = PAL+a
;
    ld  a,  (hl)
    rst INT_TX
;
    pop de
;
    inc e
    ld  a,  e
    cp  41
    jr  nz, L2

    ld  a,  LF
    rst INT_TX
;
    inc d
    ld  a,  d
    cp  21
    jr  nz, L1
;
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
;
    ld  a,  c
    call SquareA ; hl = C*C
;
    pop bc
    add hl, bc  ; hl = B*B*4 + C*C
    ex  de, hl  ; de = B*B*4 + C*C
;
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
    cp  MAX_SQUARE
    jp  p, SquareOOR
    ld  hl, Squares
    sla a
    ld  d,  0
    ld  e,  a
    add hl, de
    ld  e,  (hl)
    inc hl
    ld  d,  (hl)
    ex  de, hl
    ret
SquareOOR:
    ld  hl, MAX_SQUARE*MAX_SQUARE
    ret

Print:
    ld  a,  (hl)    ; get character
    or  a           ; is it $00 ?
    ret z           ; then return on terminator
    rst INT_TX      ; output character in a
    inc hl          ; next character
    jp  Print       ; continue until $00

; memorize squares, because multiplication is expensive
InitSquares:
    ld  hl, Squares ; hl is write pointer
    ld  d, 0
    ld  e, d ; de is cumulative sum
    ld  b, d
    ld  c, d ; bc is double index
    ld  a, MAX_SQUARE+1 ; a is loop counter
InitSquaresL:
    ld  (hl), e
    inc hl
    ld  (hl), d ; *(hl++) = de
    dec a
    ret z       ; break if --a == 0
    inc hl
    ex  de, hl
    add hl, bc
    inc hl
    ex  de, hl ; de = *hl + c + 1
    inc c
    inc c       ; c += 2
    jr  InitSquaresL


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

Cls:
    .byte  ESC
    .ascii "[2J"
    .byte  ESC
    .asciz "[H"
CursorHide:
    .byte  ESC
    .asciz "[?25l"
CursorShow:
    .byte  ESC
    .asciz "[?25h"

.section .bbs

TEMP:
    .word 0
MAX_SQUARE = 40
SquaresCnt = MAX_SQUARE
Squares:
    .skip 2*(MAX_SQUARE+1)  ; lookup table for squares
