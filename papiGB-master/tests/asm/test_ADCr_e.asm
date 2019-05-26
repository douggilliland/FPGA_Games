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
        adc a, e
        ;the value expected is a=$14 and f=$30 af=$1430
        push af
