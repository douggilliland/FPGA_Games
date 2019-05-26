SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $11
        ld  e, $10
        xor a, e
        ;the value expected is $01 with flasgs $0000
        ;af=$0100
        push af
