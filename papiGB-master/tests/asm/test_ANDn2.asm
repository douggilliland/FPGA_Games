SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $1
        and a, $10
        ;af=$00a0
        push af
