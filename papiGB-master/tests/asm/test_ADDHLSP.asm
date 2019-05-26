SECTION "sec", ROM0
DS $100
       jp  $200
DS $100
       ld sp, $FFFE
       ld a, $1
       or a, a
       ld a, $0
       nop
       ld hl, $0001
       add hl,sp
       or a,l
       ;the value expected is $FF00
       push af
