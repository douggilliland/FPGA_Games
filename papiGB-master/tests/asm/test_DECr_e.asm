SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $80
        add a		; Sets carry flag  <---OJO
        ld  d, $00
        ld  e, $F1
        dec e        ;Expected: DE = $00F0, Flags Z=0, N=1, H=0, C=1
        push de
