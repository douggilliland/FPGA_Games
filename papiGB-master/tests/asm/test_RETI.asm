SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld hl, int_label
        push hl
        reti
        jp  end_label
int_label:
        ld  hl, $71CE
end_label:
        ;expected $71CE
        push hl
