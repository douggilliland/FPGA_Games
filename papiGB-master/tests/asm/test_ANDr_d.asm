SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $ff
        ld  d, $67
        and a, d
        ;the value expected is $67 with flasgs Z=0 N=0 H=1 C=0
        ;af=$6720
        push af
