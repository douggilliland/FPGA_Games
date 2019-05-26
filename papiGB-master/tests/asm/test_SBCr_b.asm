SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $fF
        ld  b, $0f
        or  a,a
        nop
        add a, b
        nop
        sbc a, b
        ;Expected Z=0 N=1 H=1 C=1 -- AF =FE70
        push af
