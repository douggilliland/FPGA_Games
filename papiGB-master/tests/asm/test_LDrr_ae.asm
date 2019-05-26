SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld e, $33
        ld a, $12
        or a,a ;borra las banderas

        ld a, e
        push af

        ;the value expected is $3300
