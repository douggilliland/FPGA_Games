SECTION "sec", ROM0
DS $100
        ld  d, 10
        ld  e, 25
        push de
        ld	d, 0
        nop
        pop de
        ;the expected value in d= 10 and e=25
        nop
        nop
