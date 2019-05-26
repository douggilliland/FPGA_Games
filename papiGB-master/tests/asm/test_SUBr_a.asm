SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, 20
        sub a
        ; A=0, flags Z=1, H=1, C=1
        push af
