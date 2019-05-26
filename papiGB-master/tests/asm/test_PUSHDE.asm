SECTION "sec", ROM0
DS $100
        ld  d, 10
        ld  e, 25
        push de
        ;the expected value in the stack is 1025
