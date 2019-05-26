SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $00
        ld 	l, $0B
        sub a, l
        ;Expected: A = $F5, Flags Z=0, N=1, H=1, C=1
        ; AF = $F570
        push af
