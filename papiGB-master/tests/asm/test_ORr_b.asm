SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $39
        ld  b, $aa
        or a, b
        ;the value expected is $bb with flasgs $00
        ;af=$bb00
        push af
