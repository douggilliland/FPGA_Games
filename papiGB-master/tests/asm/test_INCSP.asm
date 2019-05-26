SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFD
		    ld  hl, $ffff
        inc sp
        ;the value expected is $ffff not flags affected
        push hl
