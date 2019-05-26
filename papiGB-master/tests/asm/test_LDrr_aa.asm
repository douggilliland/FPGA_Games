SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $12
        or a,a ;borra las banderas

        ld a, a
        push af

        ;the value expected is $1200
