SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld  bc, $cafe
        dec bc
        ;the value expected is $cafd not flags affected
        push bc
