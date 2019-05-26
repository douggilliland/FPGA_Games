SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld l, $26
        ld a, $12
        or a,a ;borra las banderas

        ld a, l
        push af

        ;the value expected is $2600
