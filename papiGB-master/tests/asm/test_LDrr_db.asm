SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld de, $8782
        ld b, $11
        or a,a ;borra las banderas

        ld d, b
        push de
        ;the value expected is $1182
