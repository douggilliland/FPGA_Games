SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ;f = 70
        ld a, $88
        ld sp, $FFFE
        rlca
        ;the value expected is af=$1110
        push af
