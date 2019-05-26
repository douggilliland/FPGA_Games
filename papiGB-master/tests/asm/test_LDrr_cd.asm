SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld bc, $8897
        ld d, $71
        or a,a ;borra las banderas

        ld c, d
        push bc

        ;the value expected is $8871
