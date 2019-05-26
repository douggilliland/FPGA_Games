SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $77
        ld  c, $ca
        or a, c
        ;the value expected is $52 with flasgs Z=0
        ;af=$ff00
        push af
