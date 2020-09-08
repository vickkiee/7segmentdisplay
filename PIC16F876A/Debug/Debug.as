opt subtitle "HI-TECH Software Omniscient Code Generator (Lite mode) build 9453"

opt pagewidth 120

	opt lm

	processor	16F876A
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 17 "../main2.c"
	psect config,class=CONFIG,delta=2 ;#
# 17 "../main2.c"
	dw 0xFFFD & 0xFFFB & 0xFFFF & 0xFFBF & 0xFF7F & 0xFFFF & 0xFFFF & 0xFFFF & 0xFFFF ;#
	FNCALL	_main,___lwdiv
	FNCALL	_main,___lwmod
	FNCALL	_main,_LED_DISPLAY
	FNROOT	_main
	FNCALL	intlevel1,_TMR0INT
	global	intlevel1
	FNROOT	intlevel1
	global	_LED_DIS
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"../main2.c"
	line	27

;initializer for _LED_DIS
	retlw	0C0h
	retlw	0F9h
	retlw	0A4h
	retlw	0B0h
	retlw	099h
	retlw	092h
	retlw	082h
	retlw	0F8h
	retlw	080h
	retlw	090h
	retlw	088h
	retlw	083h
	retlw	0C6h
	retlw	0A1h
	retlw	086h
	retlw	08Eh
	retlw	0FFh
	global	_DIS_NUM
	global	_counter
	global	_TMR2_COUNTER
	global	_INTCON
_INTCON	set	11
	global	_PORTB
_PORTB	set	6
	global	_PORTC
_PORTC	set	7
	global	_TMR0
_TMR0	set	1
	global	_CARRY
_CARRY	set	24
	global	_GIE
_GIE	set	95
	global	_RA0
_RA0	set	40
	global	_RA2
_RA2	set	42
	global	_TMR0IF
_TMR0IF	set	90
	global	_ADCON1
_ADCON1	set	159
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	global	_TRISC
_TRISC	set	135
	global	_EEADR
_EEADR	set	269
	global	_EEDATA
_EEDATA	set	268
	global	_EECON1
_EECON1	set	396
	global	_EECON2
_EECON2	set	397
	global	_RD
_RD	set	3168
	global	_WR
_WR	set	3169
	global	_WREN
_WREN	set	3170
	file	"Debug.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_counter:
       ds      2

_TMR2_COUNTER:
       ds      1

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_DIS_NUM:
       ds      4

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"../main2.c"
_LED_DIS:
       ds      17

; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	clrf	((__pbssBANK0)+0)&07Fh
	clrf	((__pbssBANK0)+1)&07Fh
	clrf	((__pbssBANK0)+2)&07Fh
	clrf	((__pbssBANK0)+3)&07Fh
global btemp
psect inittext,class=CODE,delta=2
global init_fetch,btemp
;	Called with low address in FSR and high address in W
init_fetch:
	movf btemp,w
	movwf pclath
	movf btemp+1,w
	movwf pc
global init_ram
;Called with:
;	high address of idata address in btemp 
;	low address of idata address in btemp+1 
;	low address of data in FSR
;	high address + 1 of data in btemp-1
init_ram:
	fcall init_fetch
	movwf indf,f
	incf fsr,f
	movf fsr,w
	xorwf btemp-1,w
	btfsc status,2
	retlw 0
	incf btemp+1,f
	btfsc status,2
	incf btemp,f
	goto init_ram
; Initialize objects allocated to BANK0
psect cinit,class=CODE,delta=2
global init_ram, __pidataBANK0
	bcf	status, 7	;select IRP bank0
	movlw low(__pdataBANK0+17)
	movwf btemp-1,f
	movlw high(__pidataBANK0)
	movwf btemp,f
	movlw low(__pidataBANK0)
	movwf btemp+1,f
	movlw low(__pdataBANK0)
	movwf fsr,f
	fcall init_ram
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	?_LED_DISPLAY
?_LED_DISPLAY:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_TMR0INT
?_TMR0INT:	; 0 bytes @ 0x0
	global	??_TMR0INT
??_TMR0INT:	; 0 bytes @ 0x0
	ds	5
	global	??_LED_DISPLAY
??_LED_DISPLAY:	; 0 bytes @ 0x5
	global	??___lwmod
??___lwmod:	; 0 bytes @ 0x5
	ds	1
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	?___lwmod
?___lwmod:	; 2 bytes @ 0x0
	global	LED_DISPLAY@TEMP
LED_DISPLAY@TEMP:	; 1 bytes @ 0x0
	global	___lwmod@divisor
___lwmod@divisor:	; 2 bytes @ 0x0
	ds	1
	global	LED_DISPLAY@i
LED_DISPLAY@i:	; 1 bytes @ 0x1
	ds	1
	global	___lwmod@dividend
___lwmod@dividend:	; 2 bytes @ 0x2
	ds	2
	global	___lwmod@counter
___lwmod@counter:	; 1 bytes @ 0x4
	ds	1
	global	?___lwdiv
?___lwdiv:	; 2 bytes @ 0x5
	global	___lwdiv@divisor
___lwdiv@divisor:	; 2 bytes @ 0x5
	ds	2
	global	___lwdiv@dividend
___lwdiv@dividend:	; 2 bytes @ 0x7
	ds	2
	global	??___lwdiv
??___lwdiv:	; 0 bytes @ 0x9
	ds	1
	global	___lwdiv@quotient
___lwdiv@quotient:	; 2 bytes @ 0xA
	ds	2
	global	___lwdiv@counter
___lwdiv@counter:	; 1 bytes @ 0xC
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0xD
	ds	1
;;Data sizes: Strings 0, constant 0, data 17, bss 7, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      6       9
;; BANK0           80     14      35
;; BANK1           80      0       0
;; BANK3           96      0       0
;; BANK2           96      0       0

;;
;; Pointer list with targets:

;; ?___lwmod	unsigned int  size(1) Largest target is 0
;;
;; ?___lwdiv	unsigned int  size(1) Largest target is 0
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   _main->___lwmod
;;   _main->_LED_DISPLAY
;;   ___lwdiv->___lwmod
;;
;; Critical Paths under _TMR0INT in COMMON
;;
;;   None.
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->___lwdiv
;;   ___lwdiv->___lwmod
;;
;; Critical Paths under _TMR0INT in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _TMR0INT in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK3
;;
;;   None.
;;
;; Critical Paths under _TMR0INT in BANK3
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _TMR0INT in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 1, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 1     1      0     530
;;                                             13 BANK0      1     1      0
;;                            ___lwdiv
;;                            ___lwmod
;;                        _LED_DISPLAY
;; ---------------------------------------------------------------------------------
;; (1) _LED_DISPLAY                                          3     3      0     136
;;                                              5 COMMON     1     1      0
;;                                              0 BANK0      2     2      0
;; ---------------------------------------------------------------------------------
;; (1) ___lwmod                                              6     2      4     232
;;                                              5 COMMON     1     1      0
;;                                              0 BANK0      5     1      4
;; ---------------------------------------------------------------------------------
;; (1) ___lwdiv                                              8     4      4     162
;;                                              5 BANK0      8     4      4
;;                            ___lwmod (ARG)
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 1
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (2) _TMR0INT                                              5     5      0       0
;;                                              0 COMMON     5     5      0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   ___lwdiv
;;     ___lwmod (ARG)
;;   ___lwmod
;;   _LED_DISPLAY
;;
;; _TMR0INT (ROOT)
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;BANK3               60      0       0       9        0.0%
;;BITBANK3            60      0       0       8        0.0%
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               60      0       0      11        0.0%
;;BITBANK2            60      0       0      10        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       7        0.0%
;;BITBANK1            50      0       0       6        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      2D      12        0.0%
;;ABS                  0      0      2C       3        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       1       2        0.0%
;;BANK0               50      E      23       5       43.8%
;;BITBANK0            50      0       0       4        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      6       9       1       64.3%
;;BITCOMMON            E      0       0       0        0.0%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 29 in file "../main2.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels required when called:    2
;; This function calls:
;;		___lwdiv
;;		___lwmod
;;		_LED_DISPLAY
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"../main2.c"
	line	29
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 6
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	30
	
l2776:	
	bsf	status, 5	;RP0=1, select bank1
	bcf	status, 6	;RP1=0, select bank1
	clrf	(134)^080h	;volatile
	line	31
	clrf	(135)^080h	;volatile
	line	32
	clrf	(133)^080h	;volatile
	line	33
	
l2778:	
	movlw	(06h)
	movwf	(159)^080h	;volatile
	line	35
	
l2780:	
	movlw	(07h)
	movwf	(129)^080h	;volatile
	line	36
	
l2782:	
	movlw	(0A0h)
	movwf	(11)	;volatile
	line	37
	
l2784:	
	movlw	(03Dh)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(1)	;volatile
	line	38
	clrf	(_counter)
	clrf	(_counter+1)
	goto	l2786
	line	39
	
l625:	
	line	40
	
l2786:	
	movlw	low(03E8h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(?___lwdiv)
	movlw	high(03E8h)
	movwf	((?___lwdiv))+1
	movf	(_counter+1),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(_counter),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+(?___lwdiv)),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	(_DIS_NUM)
	line	41
	
l2788:	
	movlw	low(064h)
	movwf	(?___lwdiv)
	movlw	high(064h)
	movwf	((?___lwdiv))+1
	movf	(_counter+1),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(_counter),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	movlw	low(03E8h)
	movwf	(?___lwmod)
	movlw	high(03E8h)
	movwf	((?___lwmod))+1
	fcall	___lwmod
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___lwmod)),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(0+(?___lwmod)),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+(?___lwdiv)),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	0+(_DIS_NUM)+01h
	line	42
	
l2790:	
	movlw	low(0Ah)
	movwf	(?___lwdiv)
	movlw	high(0Ah)
	movwf	((?___lwdiv))+1
	movf	(_counter+1),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(_counter),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	movlw	low(064h)
	movwf	(?___lwmod)
	movlw	high(064h)
	movwf	((?___lwmod))+1
	fcall	___lwmod
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(1+(?___lwmod)),w
	clrf	1+(?___lwdiv)+02h
	addwf	1+(?___lwdiv)+02h
	movf	(0+(?___lwmod)),w
	clrf	0+(?___lwdiv)+02h
	addwf	0+(?___lwdiv)+02h

	fcall	___lwdiv
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+(?___lwdiv)),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	0+(_DIS_NUM)+02h
	line	43
	
l2792:	
	movlw	low(0Ah)
	movwf	(?___lwmod)
	movlw	high(0Ah)
	movwf	((?___lwmod))+1
	movf	(_counter+1),w
	clrf	1+(?___lwmod)+02h
	addwf	1+(?___lwmod)+02h
	movf	(_counter),w
	clrf	0+(?___lwmod)+02h
	addwf	0+(?___lwmod)+02h

	fcall	___lwmod
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(0+(?___lwmod)),w
	movwf	(??_main+0)+0
	movf	(??_main+0)+0,w
	movwf	0+(_DIS_NUM)+03h
	line	44
	
l2794:	
	fcall	_LED_DISPLAY
	goto	l2786
	line	45
	
l626:	
	line	39
	goto	l2786
	
l627:	
	line	46
	
l628:	
	global	start
	ljmp	start
	opt stack 0
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_LED_DISPLAY
psect	text203,local,class=CODE,delta=2
global __ptext203
__ptext203:

;; *************** function _LED_DISPLAY *****************
;; Defined at:
;;		line 60 in file "../main2.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               1    1[BANK0 ] unsigned char 
;;  TEMP            1    0[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       2       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         1       2       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text203
	file	"../main2.c"
	line	60
	global	__size_of_LED_DISPLAY
	__size_of_LED_DISPLAY	equ	__end_of_LED_DISPLAY-_LED_DISPLAY
	
_LED_DISPLAY:	
	opt	stack 6
; Regs used in _LED_DISPLAY: [wreg-fsr0h+status,2+status,0]
	line	62
	
l2756:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(LED_DISPLAY@TEMP)
	bsf	status,0
	rlf	(LED_DISPLAY@TEMP),f
	line	63
	
l2758:	
	clrf	(LED_DISPLAY@i)
	
l2760:	
	movlw	(04h)
	subwf	(LED_DISPLAY@i),w
	skipc
	goto	u2461
	goto	u2460
u2461:
	goto	l2764
u2460:
	goto	l637
	
l2762:	
	goto	l637
	
l635:	
	line	64
	
l2764:	
	movf	(LED_DISPLAY@TEMP),w
	movwf	(7)	;volatile
	line	65
	
l2766:	
	movf	(LED_DISPLAY@i),w
	addlw	_DIS_NUM&0ffh
	movwf	fsr0
	bcf	status, 7	;select IRP bank0
	movf	indf,w
	addlw	_LED_DIS&0ffh
	movwf	fsr0
	movf	indf,w
	movwf	(6)	;volatile
	line	66
	
l2768:	
	clrc
	rlf	(LED_DISPLAY@TEMP),f

	line	67
	
l2770:	
	opt asmopt_off
movlw	66
movwf	(??_LED_DISPLAY+0)+0,f
u2487:
decfsz	(??_LED_DISPLAY+0)+0,f
	goto	u2487
	clrwdt
opt asmopt_on

	line	63
	
l2772:	
	movlw	(01h)
	movwf	(??_LED_DISPLAY+0)+0
	movf	(??_LED_DISPLAY+0)+0,w
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	addwf	(LED_DISPLAY@i),f
	
l2774:	
	movlw	(04h)
	subwf	(LED_DISPLAY@i),w
	skipc
	goto	u2471
	goto	u2470
u2471:
	goto	l2764
u2470:
	goto	l637
	
l636:	
	line	69
	
l637:	
	return
	opt stack 0
GLOBAL	__end_of_LED_DISPLAY
	__end_of_LED_DISPLAY:
;; =============== function _LED_DISPLAY ends ============

	signat	_LED_DISPLAY,88
	global	___lwmod
psect	text204,local,class=CODE,delta=2
global __ptext204
__ptext204:

;; *************** function ___lwmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    0[BANK0 ] unsigned int 
;;  dividend        2    2[BANK0 ] unsigned int 
;; Auto vars:     Size  Location     Type
;;  counter         1    4[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    0[BANK0 ] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       4       0       0       0
;;      Locals:         0       1       0       0       0
;;      Temps:          1       0       0       0       0
;;      Totals:         1       5       0       0       0
;;Total ram usage:        6 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text204
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwmod.c"
	line	5
	global	__size_of___lwmod
	__size_of___lwmod	equ	__end_of___lwmod-___lwmod
	
___lwmod:	
	opt	stack 6
; Regs used in ___lwmod: [wreg+status,2+status,0]
	line	8
	
l2734:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	(___lwmod@divisor+1),w
	iorwf	(___lwmod@divisor),w
	skipnz
	goto	u2401
	goto	u2400
u2401:
	goto	l2752
u2400:
	line	9
	
l2736:	
	clrf	(___lwmod@counter)
	bsf	status,0
	rlf	(___lwmod@counter),f
	line	10
	goto	l2742
	
l1274:	
	line	11
	
l2738:	
	movlw	01h
	
u2415:
	clrc
	rlf	(___lwmod@divisor),f
	rlf	(___lwmod@divisor+1),f
	addlw	-1
	skipz
	goto	u2415
	line	12
	
l2740:	
	movlw	(01h)
	movwf	(??___lwmod+0)+0
	movf	(??___lwmod+0)+0,w
	addwf	(___lwmod@counter),f
	goto	l2742
	line	13
	
l1273:	
	line	10
	
l2742:	
	btfss	(___lwmod@divisor+1),(15)&7
	goto	u2421
	goto	u2420
u2421:
	goto	l2738
u2420:
	goto	l2744
	
l1275:	
	goto	l2744
	line	14
	
l1276:	
	line	15
	
l2744:	
	movf	(___lwmod@divisor+1),w
	subwf	(___lwmod@dividend+1),w
	skipz
	goto	u2435
	movf	(___lwmod@divisor),w
	subwf	(___lwmod@dividend),w
u2435:
	skipc
	goto	u2431
	goto	u2430
u2431:
	goto	l2748
u2430:
	line	16
	
l2746:	
	movf	(___lwmod@divisor),w
	subwf	(___lwmod@dividend),f
	movf	(___lwmod@divisor+1),w
	skipc
	decf	(___lwmod@dividend+1),f
	subwf	(___lwmod@dividend+1),f
	goto	l2748
	
l1277:	
	line	17
	
l2748:	
	movlw	01h
	
u2445:
	clrc
	rrf	(___lwmod@divisor+1),f
	rrf	(___lwmod@divisor),f
	addlw	-1
	skipz
	goto	u2445
	line	18
	
l2750:	
	movlw	low(01h)
	subwf	(___lwmod@counter),f
	btfss	status,2
	goto	u2451
	goto	u2450
u2451:
	goto	l2744
u2450:
	goto	l2752
	
l1278:	
	goto	l2752
	line	19
	
l1272:	
	line	20
	
l2752:	
	movf	(___lwmod@dividend+1),w
	clrf	(?___lwmod+1)
	addwf	(?___lwmod+1)
	movf	(___lwmod@dividend),w
	clrf	(?___lwmod)
	addwf	(?___lwmod)

	goto	l1279
	
l2754:	
	line	21
	
l1279:	
	return
	opt stack 0
GLOBAL	__end_of___lwmod
	__end_of___lwmod:
;; =============== function ___lwmod ends ============

	signat	___lwmod,8314
	global	___lwdiv
psect	text205,local,class=CODE,delta=2
global __ptext205
__ptext205:

;; *************** function ___lwdiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwdiv.c"
;; Parameters:    Size  Location     Type
;;  divisor         2    5[BANK0 ] unsigned int 
;;  dividend        2    7[BANK0 ] unsigned int 
;; Auto vars:     Size  Location     Type
;;  quotient        2   10[BANK0 ] unsigned int 
;;  counter         1   12[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  2    5[BANK0 ] unsigned int 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       4       0       0       0
;;      Locals:         0       3       0       0       0
;;      Temps:          0       1       0       0       0
;;      Totals:         0       8       0       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text205
	file	"C:\Program Files (x86)\HI-TECH Software\PICC\9.82\sources\lwdiv.c"
	line	5
	global	__size_of___lwdiv
	__size_of___lwdiv	equ	__end_of___lwdiv-___lwdiv
	
___lwdiv:	
	opt	stack 6
; Regs used in ___lwdiv: [wreg+status,2+status,0]
	line	9
	
l2634:	
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	clrf	(___lwdiv@quotient)
	clrf	(___lwdiv@quotient+1)
	line	10
	
l2636:	
	movf	(___lwdiv@divisor+1),w
	iorwf	(___lwdiv@divisor),w
	skipnz
	goto	u2251
	goto	u2250
u2251:
	goto	l2656
u2250:
	line	11
	
l2638:	
	clrf	(___lwdiv@counter)
	bsf	status,0
	rlf	(___lwdiv@counter),f
	line	12
	goto	l2644
	
l1264:	
	line	13
	
l2640:	
	movlw	01h
	
u2265:
	clrc
	rlf	(___lwdiv@divisor),f
	rlf	(___lwdiv@divisor+1),f
	addlw	-1
	skipz
	goto	u2265
	line	14
	
l2642:	
	movlw	(01h)
	movwf	(??___lwdiv+0)+0
	movf	(??___lwdiv+0)+0,w
	addwf	(___lwdiv@counter),f
	goto	l2644
	line	15
	
l1263:	
	line	12
	
l2644:	
	btfss	(___lwdiv@divisor+1),(15)&7
	goto	u2271
	goto	u2270
u2271:
	goto	l2640
u2270:
	goto	l2646
	
l1265:	
	goto	l2646
	line	16
	
l1266:	
	line	17
	
l2646:	
	movlw	01h
	
u2285:
	clrc
	rlf	(___lwdiv@quotient),f
	rlf	(___lwdiv@quotient+1),f
	addlw	-1
	skipz
	goto	u2285
	line	18
	movf	(___lwdiv@divisor+1),w
	subwf	(___lwdiv@dividend+1),w
	skipz
	goto	u2295
	movf	(___lwdiv@divisor),w
	subwf	(___lwdiv@dividend),w
u2295:
	skipc
	goto	u2291
	goto	u2290
u2291:
	goto	l2652
u2290:
	line	19
	
l2648:	
	movf	(___lwdiv@divisor),w
	subwf	(___lwdiv@dividend),f
	movf	(___lwdiv@divisor+1),w
	skipc
	decf	(___lwdiv@dividend+1),f
	subwf	(___lwdiv@dividend+1),f
	line	20
	
l2650:	
	bsf	(___lwdiv@quotient)+(0/8),(0)&7
	goto	l2652
	line	21
	
l1267:	
	line	22
	
l2652:	
	movlw	01h
	
u2305:
	clrc
	rrf	(___lwdiv@divisor+1),f
	rrf	(___lwdiv@divisor),f
	addlw	-1
	skipz
	goto	u2305
	line	23
	
l2654:	
	movlw	low(01h)
	subwf	(___lwdiv@counter),f
	btfss	status,2
	goto	u2311
	goto	u2310
u2311:
	goto	l2646
u2310:
	goto	l2656
	
l1268:	
	goto	l2656
	line	24
	
l1262:	
	line	25
	
l2656:	
	movf	(___lwdiv@quotient+1),w
	clrf	(?___lwdiv+1)
	addwf	(?___lwdiv+1)
	movf	(___lwdiv@quotient),w
	clrf	(?___lwdiv)
	addwf	(?___lwdiv)

	goto	l1269
	
l2658:	
	line	26
	
l1269:	
	return
	opt stack 0
GLOBAL	__end_of___lwdiv
	__end_of___lwdiv:
;; =============== function ___lwdiv ends ============

	signat	___lwdiv,8314
	global	_TMR0INT
psect	text206,local,class=CODE,delta=2
global __ptext206
__ptext206:

;; *************** function _TMR0INT *****************
;; Defined at:
;;		line 48 in file "../main2.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 0/0
;;		Unchanged: 0/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK3   BANK2
;;      Params:         0       0       0       0       0
;;      Locals:         0       0       0       0       0
;;      Temps:          5       0       0       0       0
;;      Totals:         5       0       0       0       0
;;Total ram usage:        5 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text206
	file	"../main2.c"
	line	48
	global	__size_of_TMR0INT
	__size_of_TMR0INT	equ	__end_of_TMR0INT-_TMR0INT
	
_TMR0INT:	
	opt	stack 6
; Regs used in _TMR0INT: [wreg+status,2+status,0]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_TMR0INT+1)
	movf	fsr0,w
	movwf	(??_TMR0INT+2)
	movf	pclath,w
	movwf	(??_TMR0INT+3)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movf	btemp+1,w
	movwf	(??_TMR0INT+4)
	ljmp	_TMR0INT
psect	text206
	line	49
	
i1l1704:	
	bcf	(90/8),(90)&7
	line	50
	
i1l1706:	
	movlw	(01h)
	movwf	(??_TMR0INT+0)+0
	movf	(??_TMR0INT+0)+0,w
	addwf	(_TMR2_COUNTER),f
	line	51
	
i1l1708:	
	movlw	1<<((40)&7)
	xorwf	((40)/8),f
	line	52
	
i1l1710:	
	movf	(_TMR2_COUNTER),w
	xorlw	02h
	skipz
	goto	u1_21
	goto	u1_20
u1_21:
	goto	i1l631
u1_20:
	line	53
	
i1l1712:	
	movlw	1<<((42)&7)
	xorwf	((42)/8),f
	line	54
	
i1l1714:	
	clrf	(_TMR2_COUNTER)
	line	55
	movlw	low(01h)
	addwf	(_counter),f
	skipnc
	incf	(_counter+1),f
	movlw	high(01h)
	addwf	(_counter+1),f
	line	56
	
i1l631:	
	line	57
	movlw	(03Ch)
	movwf	(1)	;volatile
	line	58
	
i1l632:	
	movf	(??_TMR0INT+4),w
	movwf	btemp+1
	movf	(??_TMR0INT+3),w
	movwf	pclath
	movf	(??_TMR0INT+2),w
	movwf	fsr0
	swapf	(??_TMR0INT+1)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_TMR0INT
	__end_of_TMR0INT:
;; =============== function _TMR0INT ends ============

	signat	_TMR0INT,88
psect	text207,local,class=CODE,delta=2
global __ptext207
__ptext207:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
