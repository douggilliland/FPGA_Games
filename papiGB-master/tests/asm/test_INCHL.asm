SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld  hl, $00ff
        inc hl
        ;the value expected is $0100 not flags affected
        push hl
