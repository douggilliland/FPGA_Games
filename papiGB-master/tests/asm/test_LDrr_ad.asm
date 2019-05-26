SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld d, $13
        ld a, $12
        or a,a ;borra las banderas

        ld a, d
        push af

        ;the value expected is $1300
