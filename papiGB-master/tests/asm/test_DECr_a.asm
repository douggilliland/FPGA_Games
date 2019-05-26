SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $80
        add a		; Sets carry flag  <---OJO
        ld  a, $10
        dec a        ;Expected: AF = $0F03, Flags Z=0, N=1, H=1, C=1
        push af
