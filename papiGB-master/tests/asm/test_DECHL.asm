SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld  hl, $cafe
        dec hl
        ;the value expected is $cafd not flags affected
        push hl
