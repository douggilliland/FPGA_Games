SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $f8
        add $8
        ;the value expected is 00b0
        push af
