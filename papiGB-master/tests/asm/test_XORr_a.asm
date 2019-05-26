SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $80
        xor  a, a
        ;the value expected is $00 with flasgs Z=1
        ;af=$0080
        push af
