SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $02
        ld  d, $ff
        or  a,a
        nop
        add a, d
        nop
        sbc a, d
        ;Expected Z=0 N=1 H=1 C=1 -- AF = 0170
        push af
