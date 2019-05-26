SECTION "sec", ROM0
DS $100
        ld  b, 8
        ld  c, 7
        push bc
        ld  b, 6
        nop
        pop bc
        ;the value expected is b=8 and c=7
        nop
