SECTION "sec", ROM0
DS $100
        jp  $200
DS $100

        ld a,  $35
        ld [$FF00+$FD],a
        dec a
        ld [$FF00+$FC],a
        ;the value expected is $3534
