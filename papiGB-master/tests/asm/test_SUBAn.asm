SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $0
        sub  a, $88

        ;the value expected is bc=$7870
        push af
