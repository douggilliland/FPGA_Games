SECTION "sec", ROM0
DS $100
        jp  $200
DS $100
				ld sp, $FFFE
				ld	a, $00
				or	a, a		; Clears all flags
				ld  b, $00
        ld  c, $00
        inc b
				;Expected Flags Z=0 N=0 H=0 C=0, AF = $0000
        push af			; Tests Flags
