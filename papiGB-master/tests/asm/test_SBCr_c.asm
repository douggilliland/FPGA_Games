SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $03
        ld  c, $fe
        or  a,a
        nop
        add a, c
        nop
        sbc a, c
        ;Expected Z=0 N=1 H=1 C=1 -- AF = 0270
        push af
