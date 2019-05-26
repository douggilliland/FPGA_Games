SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, 0
        ld 	b, 1
        sub a, b
        ;Expected A =-1. Flags Z=0, N=1, H=1, C=1.
        ; AF = FF70
        push af
