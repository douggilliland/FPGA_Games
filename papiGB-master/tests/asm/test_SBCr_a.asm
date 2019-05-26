SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $0F
        or  a,a
        nop
        sbc a, a
        ;Expected Z=1 N=1 H=0 C=0 -- AF=00C0
        push af
