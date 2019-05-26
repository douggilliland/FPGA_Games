SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $15
        ld  e, $ff
        or  a,a
        nop
        add a, e
        nop
        sbc a, e
        ;Expected Z=0 N=1 H=1 C=1 -- AF = 1470
        push af
