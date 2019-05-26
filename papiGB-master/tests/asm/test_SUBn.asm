SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $df
        sub a, $5
        ;af=$da40
        push af
