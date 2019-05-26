SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $aa
        ld de, $3634
        ;ld l, $08
        or a,a ;borra las banderas

        ld e, a
        push de
        ;the value expected is $36aa
