SECTION "sec", ROM0
DS $100
        jp  $200
DS $100

        ld a,  $85
        ld c,  $FD
        ld [$FF00+c],a
        ld a,  $25
        dec c
        ld [$FF00+c],a
        ;the value expected is $8525
