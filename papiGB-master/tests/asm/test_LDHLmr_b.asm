SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld b,  $50
        ld [hl],b
        dec hl
        dec b
        ld [hl],b
        ;the value expected is $504f
