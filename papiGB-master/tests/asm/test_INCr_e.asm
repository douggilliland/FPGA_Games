SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $80
        add a		; Sets carry flag  <---OJO
        ld  d, $00
        ld  e, $F0
        inc e        ;Expected: DE = $00F1, Flags Z=0, N=0, H=0, C=1
        push de
