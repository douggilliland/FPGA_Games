SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $77
        ld  c, $5a
        and a, c
        ;the value expected is $52 with flasgs Z=0 N=0 H=1 C=0
        ;af=$5220
        push af
