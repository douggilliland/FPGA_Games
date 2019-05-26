SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
        ld sp, $FFFE
        ld	a, $00
        or	a, a		; Clears all flags
        ld  b, $00
        ld  c, $00
        dec c
        ;Expected BC = $00FF, Flags Z=0, N=1, H=1, C=0
        push bc
