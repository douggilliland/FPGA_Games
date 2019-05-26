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
        adc a, c
        ;the value expected is a=$00 and f=$b0 af=$00b0
        push af
