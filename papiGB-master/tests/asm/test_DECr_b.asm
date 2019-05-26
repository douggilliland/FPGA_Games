SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
				ld sp, $FFFE
				ld	a, $00
				or	a, a		; Clears all flags
				ld  b, $01
        ld  c, $00
        dec b
        ;Expected BC = $0000, Flags Z=1, N=1, H=0, C=0
        push bc		
