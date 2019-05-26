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
        adc a, d
        ;the value expected is a=$01 and f=$30 af=$0130
        push af
