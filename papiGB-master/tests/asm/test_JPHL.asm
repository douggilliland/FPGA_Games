SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $0F
        ld  hl, da_label
        jp hl
        or  a,a
        nop
da_label:
        ;expected $0fbe
        push af
