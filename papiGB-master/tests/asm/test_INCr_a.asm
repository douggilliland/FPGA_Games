SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $80
        add a		; Sets carry flag  <---OJO
        ld  a, $0F
        inc a        ;Expected: AF = $1003, Flags Z=0, N=0, H=1, C=1
        push af
