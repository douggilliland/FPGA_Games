SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $01
        ld  h, $ff
        or  a,a
        nop
        add a, h
        nop
        sbc a, h
        ;Expected Z=1 N=1 H=1 C=1 -- AF = 00F0
        push af
