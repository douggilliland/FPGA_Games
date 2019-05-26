SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld [hl],l
        dec hl
        ld [hl],l
        ;the value expected is $FDFC
