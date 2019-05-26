SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $dfe2
        ld hl, $dfe0
        ld a, $ff
        sub a, $1
        call nz, label
        ld a, $cc
label:
        ld   a, [hl+]
        ld   b, [hl]
        ld c, a

        ;the value expected is bc=$0208
        ld sp, $fffe
        push bc
