SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $0F
        ld  h, $1F
        add a, h
        ;the value expected is $2E with flags H = 1
        ;$2E20
        push af
