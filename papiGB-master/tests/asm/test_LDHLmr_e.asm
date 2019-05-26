SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld e,  $23
        ld [hl],e
        dec hl
        dec e
        ld [hl],e
        ;the value expected is $2322
