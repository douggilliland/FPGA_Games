SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $77
        ld  c, $ca
        xor a, c
        ;the value expected is $bd with flasgs Z=0
        ;af=$bd00
        push af
