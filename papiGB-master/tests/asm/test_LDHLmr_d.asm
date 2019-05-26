SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld d,  $11
        ld [hl],d
        dec hl
        dec d
        ld [hl],d
        ;the value expected is $1110
