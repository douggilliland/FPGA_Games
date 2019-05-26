SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $A
        ld 	h, 0
        sub a, h
        ;Expected: A = $0A, Flags Z=0, N=1, H=0, C=0
        ; AF = $0A40
        push af
