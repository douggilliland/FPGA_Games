SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $0
        or a,a
        ld  a, $FF
        add a,$03
        nop
        sbc a, $01
        ;Expected C=1 -- AF=00C0
        push af
