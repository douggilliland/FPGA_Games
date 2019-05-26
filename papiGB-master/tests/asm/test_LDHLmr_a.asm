SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld a,  $95
        ld [hl],a
        dec hl
        dec a
        ld [hl],a
        ;the value expected is $9594
