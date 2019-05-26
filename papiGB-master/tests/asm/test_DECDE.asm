SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld  de, $cafe
        dec de
        ;the value expected is $cafd not flags affected
        push de
