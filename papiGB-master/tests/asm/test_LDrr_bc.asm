SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld bc, $9895
        or a,a ;borra las banderas

        ld b, c
        push bc

        ;the value expected is $9595
