SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $a9
        ld  l, $a9
        xor a, l
        ;the valu1e expected is $ef with flasgs Z=0
        ;af=$0080
        push af
