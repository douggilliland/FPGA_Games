SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ;f = 70
        ld a, $fe
        ld sp, $FFFE
        rr  a
        ;the value expected is af=$ff40
        push af
