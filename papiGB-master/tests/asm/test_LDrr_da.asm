SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld de, $1313
        or a,a ;borra las banderas

        ld d, a
        push de
        ;the value expected is $1513
