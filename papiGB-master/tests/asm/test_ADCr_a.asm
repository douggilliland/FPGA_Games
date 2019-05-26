SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $0F
        or  a,a
        nop
        adc a, a
        ;the value expected is a=$1E and f=$20 af=$1E20
        push af
