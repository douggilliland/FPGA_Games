SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $ff
        ld  b, $01
        add a, b
        ;the value expected is 00 - with Flags Z-H-C = 1
        ;af=00b0
        push af
