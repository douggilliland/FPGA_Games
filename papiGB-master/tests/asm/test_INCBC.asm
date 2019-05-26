SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFE
		    ld  bc, $cafd
        inc bc
        ;the value expected is $cafe not flags affected
        push bc
