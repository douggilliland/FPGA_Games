SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $99
        ld  l, $80
        or  a,a
        nop
        add a, l
        nop
        sbc a, l
        ;Expected Z=0 N=1 H=0 C=1 -- AF = 9850
        push af
