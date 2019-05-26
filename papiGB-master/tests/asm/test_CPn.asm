SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $00
        cp a, $90
        ;the value af=$0050
        push af
