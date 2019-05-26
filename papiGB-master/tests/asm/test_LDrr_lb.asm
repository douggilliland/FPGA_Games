SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld hl, $6463
        ld b, $60
        or a,a ;borra las banderas

        ld l, b
        push hl
        ;the value expected is $6460
