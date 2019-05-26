SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $ff
        add $01
        jp c, carry_label
        ld  a, $07
carry_label:
        ;expected $00b0
        push af
