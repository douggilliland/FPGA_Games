SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $FF
        or a,$ff
        jp nz, da_label
        or  a,a
        nop
da_label:
        ;expected $0fbe
        push af
