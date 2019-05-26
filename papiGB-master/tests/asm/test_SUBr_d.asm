SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $50
        ld 	d, $0F
        sub a, d
        ;Expected A = 41, Flags Z=0, N=1, H=1, C=0
        ; AF = $4160
        push af
