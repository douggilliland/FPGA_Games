SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld sp, $FFFe

        ld a,  1
        or a,a

        ld a, $87

        ldd [hl],a
        ldd [hl],a
        ld hl, $FFFD

        nop
        nop
        ld e,[hl]

        push de

        ;the value expected is $0087
