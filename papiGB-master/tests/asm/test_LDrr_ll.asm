SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld hl, $7902
        or a,a ;borra las banderas

        ld l, l
        push hl
        ;the value expected is $7902
