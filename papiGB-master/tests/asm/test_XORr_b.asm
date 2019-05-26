SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $39
        ld  b, $aa
        xor a, b
        ;the value expected is $93 with flasgs $00
        ;af=$9300
        push af
