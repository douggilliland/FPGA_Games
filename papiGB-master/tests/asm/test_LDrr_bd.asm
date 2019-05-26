SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld bc, $3597
        ld d, $40
        or a,a ;borra las banderas

        ld b, d
        push bc

        ;the value expected is $4097
