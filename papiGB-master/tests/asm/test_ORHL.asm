SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld hl, $FFFD
        nop
        nop
        ld e,  $23
        ld [hl],e
        ld a, $dc

        nop
        or a,[hl]

        ;af=$ff00
        push af
