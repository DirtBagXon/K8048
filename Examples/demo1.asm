;**************************************************************************
;*           VELLEMAN   High-Q KIT  K8048/VM111 SAMPLE SOFTWARE           *
;**************************************************************************
;*           DEMO1: Simple Running light for testing LD1...LD5            *
;*	     DEMO1: Program for testing K8048/VM111 with PIC16F627!       *
;**************************************************************************
;*          (C) VELLEMAN Components,2003  All rights reserved             *
;**************************************************************************
;*          Hardw. Rev: P8048'1          Softw. Rev:  1.20                *
;*          OSC.......: XT 4MHz Max.     POWER.....:  12V DC              *
;**************************************************************************

W                            EQU     H'0000'
F                            EQU     H'0001'

;----- Register Files------------------------------------------------------

INDF                         EQU     H'0000'
TMR0                         EQU     H'0001'
PCL                          EQU     H'0002'
STATUS                       EQU     H'0003'
FSR                          EQU     H'0004'
PORTA                        EQU     H'0005'
PORTB                        EQU     H'0006'

INTCON                       EQU     H'000B'
OPTION_REG                   EQU     H'0081'
TRISA                        EQU     H'0085'
TRISB                        EQU     H'0086'
CMCON                        EQU     H'001F'

;----- STATUS Bits --------------------------------------------------------
IRP                          EQU     H'0007'
RP1                          EQU     H'0006'
RP0                          EQU     H'0005'
NOT_TO                       EQU     H'0004'
NOT_PD                       EQU     H'0003'
Z                            EQU     H'0002'
DC                           EQU     H'0001'
C                            EQU     H'0000'

;==========================================================================
;
;       RAM Definition
;
;==========================================================================

    __MAXRAM H'01FF'
    __BADRAM H'07'-H'09', H'0D', H'13'-H'14', H'1B'-H'1E'
    __BADRAM H'87'-H'89', H'8D', H'8F'-H'91', H'93'-H'97', H'9E'
    __BADRAM H'105', H'107'-H'109', H'10C'-H'11F', H'150'-H'16F'
    __BADRAM H'185', H'187'-H'189', H'18C'-H'1EF'

;==========================================================================
;
;       Configuration Bits
;
;==========================================================================

_BODEN_ON                    EQU     H'3FFF'
_BODEN_OFF                   EQU     H'3FBF'
_CP_ALL                      EQU     H'03FF'
_CP_75                       EQU     H'17FF'
_CP_50                       EQU     H'2BFF'
_CP_OFF                      EQU     H'3FFF'
_DATA_CP_ON                  EQU     H'3EFF'
_DATA_CP_OFF                 EQU     H'3FFF'
_PWRTE_OFF                   EQU     H'3FFF'
_PWRTE_ON                    EQU     H'3FF7'
_WDT_ON                      EQU     H'3FFF'
_WDT_OFF                     EQU     H'3FFB'
_LVP_ON                      EQU     H'3FFF'
_LVP_OFF                     EQU     H'3F7F'
_MCLRE_ON                    EQU     H'3FFF'
_MCLRE_OFF                   EQU     H'3FDF'
_ER_OSC_CLKOUT               EQU     H'3FFF'
_ER_OSC_NOCLKOUT             EQU     H'3FFE'
_INTRC_OSC_CLKOUT            EQU     H'3FFD'
_INTRC_OSC_NOCLKOUT          EQU     H'3FFC'
_EXTCLK_OSC                  EQU     H'3FEF'
_LP_OSC                      EQU     H'3FEC'
_XT_OSC                      EQU     H'3FED'
_HS_OSC                      EQU     H'3FEE'

	__CONFIG        _BODEN_ON & _CP_OFF & _DATA_CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_ON & _XT_OSC

;==========================================================================
;       Variable Definition
;==========================================================================
TIMER1		EQU	H'20'		;Used in delay routine
TIMER2		EQU	H'21'		; "	"	"	
PATERN		EQU	H'22'		;Pattern data for effect's

		ORG	0		;Reset vector address
		GOTO	RESET		;goto RESET routine when boot.


;		*********************************************
;		*  Example of a delay routine               *
;		*********************************************

DELAY_ROUTINE   MOVLW   D'255'         ;54 Generate approx 10mS delay at 4Mhz CLK
                MOVWF   TIMER2
DEL_LOOP1       MOVLW   D'255'	       ;60	
                MOVWF   TIMER1
DEL_LOOP2       DECFSZ  TIMER1,F
                GOTO    DEL_LOOP2
                DECFSZ  TIMER2,F
                GOTO    DEL_LOOP1
		RETLW   0


;	       **********************************
;              **  RESET :  main boot routine  **
;              **********************************

RESET		MOVLW	B'00000111'	;Disable Comparator module's
		MOVWF	CMCON
		;
		BSF	STATUS,RP0	;Switch to register bank 1
					;Disable pull-ups
					;INT on rising edge
					;TMR0 to CLKOUT
					;TMR0 Incr low2high trans.
					;Prescaler assign to Timer0
					;Prescaler rate is 1:256
		MOVLW	B'11010111'	;Set PIC options (See datasheet).
		MOVWF	OPTION_REG	;Write the OPTION register.
		;
		CLRF	INTCON		;Disable interrupts
		MOVLW	B'11000000'
		MOVWF	TRISB		;RB7 & RB6 are inputs.
					;RB5...RB0 are outputs.
		MOVLW	B'11111111'	;all RA ports are inputs
		MOVWF	TRISA
		BCF	STATUS,RP0	;Switch Back to reg. Bank 0
		CLRF	PORTB		
		;

EFFECT_1	MOVLW	B'00000001'	;Activate LD1 (RB0)
		MOVWF	PORTB
		CALL	DELAY_ROUTINE
		MOVLW	B'00000010'	;Activate LD2 (RB1)
		MOVWF	PORTB
		CALL	DELAY_ROUTINE
		MOVLW	B'00000100'	;Activate LD3 (RB2)
		MOVWF	PORTB
		CALL	DELAY_ROUTINE
		MOVLW	B'00001000'	;Activate LD4 (RB3)
		MOVWF	PORTB
		CALL	DELAY_ROUTINE
		MOVLW	B'00010000'	;Activate LD5 (RB4)
		MOVWF	PORTB
		CALL	DELAY_ROUTINE
		MOVLW	B'00100000'	;Activate LD6 (RB5)
		MOVWF	PORTB
		CALL	DELAY_ROUTINE
		GOTO	EFFECT_1
		END
