SECTION "sec", ROM0
DS $100
        jp  $200

DS $100
        ld sp, $FFFE
        ld a, $00
        or a,a
        ld a,$FF
        add a,$10
        jr hola
cesar:  jr end
hola:   jr cesar

        ld a, $cc
        ;the value expected is af=$0F10
end:
        push af
