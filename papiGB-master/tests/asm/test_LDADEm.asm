SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld de, $FFFD
        ld sp, $FFFe

        ld a,  1
        or a,a

        ld a, $20

        ldd [hl],a
        ldd [hl],a

        ld a,  $10
        nop
        nop
        ld a,[de]

        push af

        ;the value expected is $2000
