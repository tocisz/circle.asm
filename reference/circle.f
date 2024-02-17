( pallete for drawing )
VARIABLE PAL
HEX 2320 DECIMAL PAL ! ( " #" )

( return 1 when coordinates in the elipse )
( of radius [20;40] )
: CI ( n n -- tf )
  DUP *
  SWAP
  2 /
  DUP *
  +
  400 > NOT
;

( draw circle using pallete )
: DRAW ( -- )
  CR
  21 -20 DO 
    41 -40 DO
      I J CI
      PAL + C@
      EMIT
    LOOP CR
  LOOP
;

DRAW
