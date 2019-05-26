SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $f0
        ld  e, $10
        add a, e
        ;the value expected is $00 with flags Z=1 C=1
        ;af=0090
        push af
