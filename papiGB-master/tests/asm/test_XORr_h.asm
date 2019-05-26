SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $e6
        ld  h, $a9
        xor a, h
        ;the value expected is $ef with flasgs Z=0
        ;af=$4f00
        push af
