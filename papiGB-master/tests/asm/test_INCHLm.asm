SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld hl, $C000
        ld a , $62

        ld  [hl],a
        inc [hl]

        ld  a,[hl]
        sub $63
        jp Z,exit
        ld a,$33
exit:
        push af

        ;the value expected is $00C0, flag Z affected
