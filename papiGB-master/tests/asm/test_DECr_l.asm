SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $80
        add a		; Sets carry flag  <---OJO
        ld  h, $00
        ld  l, $00
        dec l        ;Expected: HL = $0011, Flags Z=0, N=1, H=1, C=1
        push hl
