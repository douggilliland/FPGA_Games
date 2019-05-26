SECTION "sec", ROM0
DS $100
        ld  l, 7
        ld  h, 3
        push hl
        ld	l, 0
        nop
        pop hl
        ;the expected value in l= 7 and h=3
        nop
        nop
