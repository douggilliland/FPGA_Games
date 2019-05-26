SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $00
        ld  d, $00
        or a, d
        ;the value expected is $67 with flasgs Z=1
        ;af=$0080
        push af
