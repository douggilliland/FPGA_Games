SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld a, $0
        rr a
        jr nc, end

        ld a, $cc
        ;the value expected is af=$8000
end:
        push af
