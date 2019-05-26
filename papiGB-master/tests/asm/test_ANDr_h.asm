SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $e6
        ld  h, $a1
        and a, h
        ;the value expected is $a0 with flasgs Z=0 N=0 H=1 C=0
        ;af=$a020
        push af
