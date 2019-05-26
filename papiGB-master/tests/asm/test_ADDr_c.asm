SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $0F
        ld  c, $05
        add a, c
        ;the value expected is D-20 H-$14 with flags H = 1
        ;af=$1420
        push af
