SECTION "sec", ROM0
DS $100
				jp  $200
DS $100
				ld sp, $FFFF
        dec sp
        ld  hl, $cafa
        dec hl
        ;the value expected is $caf9 not flags affected
        push hl
