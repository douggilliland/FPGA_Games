SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld hl, $3634
        ld e, $08

        ld h, e
        push hl
        ;the value expected is $0834
