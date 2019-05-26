SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld a,  $15
        
        ldd [hl],a
        ldd [hl],a
        ;the value expected is $1515
