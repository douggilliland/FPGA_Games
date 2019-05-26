SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $02
        or  a,a
        nop
        add a, a
        ;the value expected is 4
        push af
