;
; A simple bios to init hardware, load the menu...that sort of thing

SECTION	"Org $00",HOME[$00]
begin:

	ld sp, $fffe
	
	ld a, $48
	ld [$ff01], a

	call spin
	
	ld a, $49
	ld [$ff01], a

    call spin
   
	ld a, $49
	ld [$ff01], a

	call mipiInit;

	; call read_byte 
	; ld e, a
	; ld d, 0
	; ld b, 0
	; ld c, 0
; copy_loop:
	; call read_byte
	; ld [bc], a
	; inc bc
	; bit 7, b
	; jr z, copy_loop
	; ld b, $0
	; inc d
	; ld a, d
	; ld [$ff90], a ;select next memory bank
	; cp e
	; jr nz, copy_loop
	
;load the cart header data (must be in first FF bytes of code)
ld a, $00
ld [$ff83], a
ld a, [$0147] ;mbc
ld [$ff80], a
ld a, [$0148] ;rom size
ld [$ff81], a
ld a, [$0149] ;ram size
ld [$ff82], a
ld a, [$0143] ;gb mode
ld [$ff86], a

ld a, $42
ld [$ff01], a

call spin

ld a, $49
ld [$ff01], a

jr begin

SECTION	"Org $200", HOME[$200]
spin:
	ld a, $7f
spin_loop:
	dec a
	jr nz, spin_loop
	ret
	
	
read_byte:

loop:
	ld a, [$ff08]
	bit 0, a
	jr z, loop
	ld [$ff08],a
	ld a, [$ff09]
	ret
	
	
	
mipiInit:
    ld a, $80
	ld [$ff40], a
	ld d, $F8
	call writeCtl
	ld b, 30
	call waitForVblank
	res 3, d ;reset
	call writeCtl
	ld b, 1
	call waitForVblank
	set 3, d  ;reset clear
	call writeCtl
	ld b, 1
	call waitForVblank
	
	; enable display
	res 5, d
	call writeCtl
	
	; setup pll
	ld a, $BA
	ld b, $0f
	ld c, $00
	call writeCmdPause
	
	; cycle the display
	set 5, d
	call writeCtl
	res 5, d
	call writeCtl
	
	; enable pll
	ld a, $B9
	ld b, $01
	ld c, $00
	call writeCmdPause
	
	; turn off display to let pll start
	set 5, d
	call writeCtl
	
	; delay a bit to let pll start up
	ld b, 2
	call waitForVblank
	
	; write MCS_CCR
	ld a, $BB
	ld b, $44
	ld c, $00
	call writeCmdPause
	
	; write MCS_TR
	ld a, $D6
	ld b, $00
	ld c, $01
	call writeCmdPause
	
	; write MCS_CFGR
	ld a, $B7
	ld b, $43
	ld c, $02
	call writeCmdPause
	
	; write MCS_VCR
	ld a, $B8
	ld b, $00
	ld c, $00
	call writeCmdPause
	
	; TDC size (0)
		; write MCS_PSCR1
		ld a, $BC
		ld b, $00
		ld c, $00
		call writeCmdPause
		
		; write MCS_PSCR2
		ld a, $BD
		ld b, $00
		ld c, $00
		call writeCmdPause
	
	; write DCS_SLPOUT
	ld a, $11
	ld b, $00
	ld c, $00
	call writeCmdPause	
	
	ld b, 5
	call waitForVblank
	
	; TDC size (1)
		; write MCS_PSCR1
		ld a, $BC
		ld b, $01
		ld c, $00
		call writeCmdPause
		
		; write MCS_PSCR2
		ld a, $BD
		ld b, $00
		ld c, $00
		call writeCmdPause
		
	; write DCS_COLMOD
	ld a, $3A
	ld b, $05
	ld c, $00
	call writeCmdPause	

		; TDC size (0)
		; write MCS_PSCR1
		ld a, $BC
		ld b, $00
		ld c, $00
		call writeCmdPause
		
		; write MCS_PSCR2
		ld a, $BD
		ld b, $00
		ld c, $00
		call writeCmdPause
		
	; write DCS_DISPON
	ld a, $29
	ld b, $00
	ld c, $00
	call writeCmdPause	
	
drawLoop:	
	; clear the screen
	; enable display
	set 5, d
	call writeCtl
	
	; TDC size (4)
		; write MCS_PSCR1
		ld a, $BC
		ld b, $04
		ld c, $00
		call writeCmdPause
		
		; write MCS_PSCR2
		ld a, $BD
		ld b, $00
		ld c, $00
		call writeCmdPause
	
	; write DCS_CASET
	ld a, $2A
	ld b, $00
	ld c, $00
	call writeCmdPause
	ld a, 0
	call writeByte
	ld a, 239
	call writeByte
	
	; write DCS_PASET
	ld a, $2B
	ld b, $00
	ld c, $00
	call writeCmdPause
	ld a, 0
	call writeByte
	ld a, 239
	call writeByte
	
	; TDC size (240*240*2)
		; write MCS_PSCR1
		ld a, $BC
		ld b, $e0
		ld c, $01
		call writeCmdPause
		
		; write MCS_PSCR2
		ld a, $BD
		ld b, $00
		ld c, $00
		call writeCmdPause
	
	; write MCS_PSCR3
	ld a, $BE
	ld b, $00
	ld c, $04
	call writeCmdPause	
	
	; ; enable display
	; res 5, d
	; call writeCtl
	
	; call setCmd
	; ld a, $2C
	; call writeByte
	; call setData
	
	; ld b, 240
; loop2:
	; ld c, 240
; loop1:	
	; ld a, b
	; call writeByte
	; ld a, c
	; call writeByte
	; dec c
	; jr nz, loop1
	; dec b
	; jr nz, loop2
	
	; disable display
	set 5, d
	call writeCtl

	xor a
	ld [$ff40], a
ret

	
	
	

	


	



; waits the number of vblanks specified in b	
waitForVblank:
	ld a, [$ff44]	
	cp a, $90
	jr nz, waitForVblank
waitForClear:
	ld a, [$ff44]	
	cp a, $90
	jr z, waitForClear
	dec b
	jr nz, waitForVblank
	ret 
;write control regs
writeCtl:
	ld a, d
	ld [$ff85],a 
	ret
;write pause command a = reg, b = low, c = hi
writeCmdPause:
	ld e, a
	call setCmd
	ld a, e
	call writeByte
	call setData
	ld a, b
	call writeByte
	ld a, c
	call writeByte
	ret
	
writeByte:
	ld [$ff84], a
	res 6, d ;toggle write
    call writeCtl
	res 5, d
	call writeCtl
	nop
	set 5, d
	set 6, d
	call writeCtl
	
	ret
	
setCmd:
	res 4, d
	call writeCtl
	ret

setData:
	set 4, d
	call writeCtl
	ret