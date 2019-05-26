SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $80
        or  a, a
        ;the value expected is $20 with flasgs Z=0
        ;af=$8000
        push af
