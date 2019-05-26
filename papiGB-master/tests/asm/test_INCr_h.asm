SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $00
        or	a, a		; Clears all flags
        ld  h, $10
        ld  l, $00
        inc h        ;Expected: HL = $1100, Flags Z=0, N=0, H=0, C=0
        push hl
