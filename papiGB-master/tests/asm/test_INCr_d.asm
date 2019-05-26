SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $00
        or	a, a		; Clears all flags
        ld  d, $0F
        ld  e, $00
        inc d        ;Expected: DE = $1000, Flags Z=0, N=0, H=1, C=0
        push de
