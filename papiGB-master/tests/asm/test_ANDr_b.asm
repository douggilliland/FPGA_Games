SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $29
        ld  b, $a8
        and a, b
        ;the value expected is $28 with flasgs Z=0 N=0 H=1 C=0
        ;af=$2820
        push af
