SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $20
        ld  e, $49
        and a, e
        ;the value expected is $00 with flasgs Z=1 N=0 H=1 C=0
        ;af=$00a0
        push af
