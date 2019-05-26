SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  b, $FF
        srl  b
        ld a, b
        ;the value expected is bc=$7f10
        push af
