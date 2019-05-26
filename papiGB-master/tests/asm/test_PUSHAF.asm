SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $dffb
        ld  a, $1b
        push af
        nop
        ld a,$ff
        sub a,$ff
        nop
        nop
        pop af
