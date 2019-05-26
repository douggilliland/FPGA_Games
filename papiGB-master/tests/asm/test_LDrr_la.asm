SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld hl, $2120
        or a,a ;borra las banderas

        ld l, a
        push hl
        ;the value expected is $2115
