SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $20
        and a, a
        ;the value expected is $20 with flasgs Z=0 N=0 H=1 C=0
        ;af=$2020
        push af
