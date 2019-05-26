SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $00 ; 0000 0000
        ld 	e, $80 ; 1000 0000
        sub a, e
        ;Expected: A=$80, Flags Z=0, N=1, H=0, C=1
        ;AF = $8050
        push af
