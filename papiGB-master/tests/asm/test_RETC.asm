SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld hl, carry_label
        push hl
        ld  a, $ff
        add $01
        ret c
        jp  end_label
carry_label:
        ld  a, $71
end_label:
        ;expected $71b0
        push af
