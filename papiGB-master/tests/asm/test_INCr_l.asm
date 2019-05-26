SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $80
        add a		; Sets carry flag  <---OJO
        ld  h, $00
        ld  l, $FF
        inc l        ;Expected: HL = $0011, Flags Z=1, N=0, H=1, C=1
        push hl
