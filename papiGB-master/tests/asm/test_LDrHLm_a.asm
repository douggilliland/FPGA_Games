SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld sp, $FFFe

        ld a,  1
        or a,a

        ld a, $60

        ldd [hl],a
        ldd [hl],a
        ld hl, $FFFD

        ld a,  $10
        nop
        nop
        ld a,[hl]

        push af

        ;the value expected is $2000
