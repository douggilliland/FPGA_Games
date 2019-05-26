SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  b, $0F
        ld  c, $00
        srl  b
        ld a, b
        ;the value expected is bc=$0710
        push af
