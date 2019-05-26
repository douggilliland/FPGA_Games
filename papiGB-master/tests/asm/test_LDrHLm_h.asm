SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFD
        ld sp, $FFFe

        ld a,  1
        or a,a

        ld a, $37

        ldd [hl],a
        ldd [hl],a
        ld hl, $FFFD

        nop
        nop
        ld h,[hl]

        push hl

        ;the value expected is $37fd
