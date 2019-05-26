SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $15
        ld hl, $6463
        ld d, $80
        or a,a ;borra las banderas

        ld l, d
        push hl
        ;the value expected is $6480
