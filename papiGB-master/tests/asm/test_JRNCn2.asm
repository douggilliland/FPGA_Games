SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ;af = $da40
        jr nc, end

        ld a, $80
        ;the value expected is af=$8040
end:
        push af
