SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld c,  $f2
        ld [hl],c
        dec hl
        dec c
        ld [hl],c
        ;the value expected is $f2f1
