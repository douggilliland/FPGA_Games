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
        adc a, l
        ;the value expected is a=$9a and f=$00 af=$9a00
        push af
