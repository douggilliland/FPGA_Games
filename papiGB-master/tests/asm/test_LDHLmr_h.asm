SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld [hl],h
        dec hl
        ld [hl],h
        ;the value expected is $FFFF
