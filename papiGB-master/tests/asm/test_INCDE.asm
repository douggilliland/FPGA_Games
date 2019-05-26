SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld  de, $ffff
        inc de
        ;the value expected is $0000 not flags affected
        push de
