SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld  a, $7F
        xor a, $ED
        ;the value expected is af=$9200
        push af
