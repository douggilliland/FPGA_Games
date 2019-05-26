SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  c, $ff
        rr  c
        ld a, c
        ;the value expected is bc=$ff10
        push af
