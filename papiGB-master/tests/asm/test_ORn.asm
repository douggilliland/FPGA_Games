SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $01
        or  a, a
        or  a, $15
        ;the value expected is $00 with flasgs Z=0 N=0 H=1 C=0
        ;af=$1500
        push af
