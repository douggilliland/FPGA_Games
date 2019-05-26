SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $00
        or	a, a		; Clears all flags
        ld  d, $10
        ld  e, $00
        dec d        ;Expected: DE = $0F00, Flags Z=0, N=1, H=1, C=0
        push de
