SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $00
        and a,$ff
        jp z, zero_label
        ld a, $ff
        nop
zero_label:
        ;expected $00a0
        push af
