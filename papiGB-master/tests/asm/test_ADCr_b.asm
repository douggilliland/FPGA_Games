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
        adc a, b
        ;the value expected is a=$1E and f=$20 af=$1E20
        push af
