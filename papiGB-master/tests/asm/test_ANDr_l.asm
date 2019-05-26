SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $71
        ld  l, $2f
        and a, l
        ;the value expected is $21 with flasgs Z=0 N=0 H=1 C=0
        ;af=$2120
        push af
