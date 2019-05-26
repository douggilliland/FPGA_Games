SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld hl, $FFFE

        ld a,  1
        or a,a

        ld sp,hl

        push af

        ;the value expected is $0100
