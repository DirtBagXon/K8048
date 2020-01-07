;**************************************************************************
;*          K8048  Microchip PIC(tm) Programmer /  tutor KIT              *
;**************************************************************************
;*          (C) VELLEMAN Components,2003  All rights reserved             *
;*          Hardware & sample software by Pascal De Petter 	          *
;**************************************************************************
;*          Hardw. Rev: P8048'x ß1       Softw. Rev:  1.00ß               *
;*          OSC.......: XT 4MHz Max.     POWER.....:  15V DC              *
;**************************************************************************

;==========================================================================
;
;       Revision History
;
;==========================================================================
;==========================================================================
;
;       Configuration Bits
;
;==========================================================================

_CPD                         EQU     H'3EFF'
_CPD_OFF                     EQU     H'3FFF'
_CP                          EQU     H'3F7F'
_CP_OFF                      EQU     H'3FFF'
_BODEN                       EQU     H'3FFF'
_BODEN_OFF                   EQU     H'3FBF'
_MCLRE_ON                    EQU     H'3FFF'
_MCLRE_OFF                   EQU     H'3FDF'
_PWRTE_OFF                   EQU     H'3FFF'
_PWRTE_ON                    EQU     H'3FEF'
_WDT_ON                      EQU     H'3FFF'
_WDT_OFF                     EQU     H'3FF7'
_LP_OSC                      EQU     H'3FF8'
_XT_OSC                      EQU     H'3FF9'
_HS_OSC                      EQU     H'3FFA'
_EC_OSC                      EQU     H'3FFB'
_INTRC_OSC_NOCLKOUT          EQU     H'3FFC'
_INTRC_OSC_CLKOUT            EQU     H'3FFD'
_EXTRC_OSC_NOCLKOUT          EQU     H'3FFE'
_EXTRC_OSC_CLKOUT            EQU     H'3FFF'

;==========================================================================
;
;       Configuration 
;
;==========================================================================


	__CONFIG        _CPD_OFF & _CP  & _BODEN_OFF & _PWRTE_ON & _WDT_OFF &  _MCLRE_ON & _INTRC_OSC_NOCLKOUT & _XT_OSC


;==========================================================================
;
;       Register Definitions
;
;==========================================================================

W                            EQU     H'0000'
F                            EQU     H'0001'

;----- Register Files------------------------------------------------------

INDF                         EQU     H'0000'
TMR0                         EQU     H'0001'
PCL                          EQU     H'0002'
STATUS                       EQU     H'0003'
FSR                          EQU     H'0004'
PORTA                        EQU     H'0005'
PORTC                        EQU     H'0007'

PCLATH                       EQU     H'000A'
INTCON                       EQU     H'000B'
PIR1			     EQU     H'000C'

TMR1L			     EQU     H'000E'		
TMR1H			     EQU     H'000F'		
T1CON			     EQU     H'0010'		

CMCON			     EQU     H'0019'		

OPTION_REG	             EQU     H'0081'

TRISA			     EQU     H'0085'
TRISC			     EQU     H'0087'

PIE1			     EQU     H'008C'

PCON			     EQU     H'008E'

OSCCAL			     EQU     H'0090'

WPUA			     EQU     H'0095'
WPU			     EQU     H'0095'
IOCA			     EQU     H'0096'
IOC			     EQU     H'0096'

VRCON			     EQU     H'0099'
EEDATA			     EQU     H'009A'	
EEADR			     EQU     H'009B'	
EECON1			     EQU     H'009C'
EECON2			     EQU     H'009D'

;----- STATUS Bits --------------------------------------------------------

IRP                          EQU     H'0007'
RP1                          EQU     H'0006'
RP0                          EQU     H'0005'
NOT_TO                       EQU     H'0004'
NOT_PD                       EQU     H'0003'
Z                            EQU     H'0002'
DC                           EQU     H'0001'
C                            EQU     H'0000'

;----- INTCON Bits --------------------------------------------------------

GIE                          EQU     H'0007'
PEIE                         EQU     H'0006'
T0IE                         EQU     H'0005'
INTE                         EQU     H'0004'
GPIE                         EQU     H'0003'
T0IF                         EQU     H'0002'
INTF                         EQU     H'0001'
GPIF                         EQU     H'0000'

;----- PIR1 Bits ----------------------------------------------------------

EEIF                         EQU     H'0007'
ADIF                         EQU     H'0006'
CMIF                         EQU     H'0003'
T1IF                         EQU     H'0000'
TMR1IF                       EQU     H'0000'

;----- T1CON Bits ---------------------------------------------------------

TMR1GE                       EQU     H'0006'
T1CKPS1                      EQU     H'0005'
T1CKPS0                      EQU     H'0004'
T1OSCEN                      EQU     H'0003'
NOT_T1SYNC                   EQU     H'0002'
TMR1CS                       EQU     H'0001'
TMR1ON                       EQU     H'0000'

;----- COMCON Bits --------------------------------------------------------

COUT                         EQU     H'0006'
CINV                         EQU     H'0004'
CIS                          EQU     H'0003'
CM2                          EQU     H'0002'
CM1                          EQU     H'0001'
CM0                          EQU     H'0000'

;----- OPTION Bits --------------------------------------------------------

NOT_GPPU		     EQU     H'0007'
INTEDG                       EQU     H'0006'
T0CS                         EQU     H'0005'
T0SE                         EQU     H'0004'
PSA                          EQU     H'0003'
PS2                          EQU     H'0002'
PS1                          EQU     H'0001'
PS0                          EQU     H'0000'

;----- PIE1 Bits ----------------------------------------------------------

EEIE                         EQU     H'0007'
ADIE                         EQU     H'0006'
CMIE                         EQU     H'0003'
T1IE                         EQU     H'0000'
TMR1IE                       EQU     H'0000'

;----- PCON Bits ----------------------------------------------------------

NOT_POR                      EQU     H'0001'
NOT_BOD                      EQU     H'0000'

;----- OSCCAL Bits --------------------------------------------------------

CAL5                         EQU     H'0007'
CAL4                         EQU     H'0006'
CAL3                         EQU     H'0005'
CAL2                         EQU     H'0004'
CAL1                         EQU     H'0003'
CAL0                         EQU     H'0002'

;----- VRCON Bits ---------------------------------------------------------

VREN                         EQU     H'0007'
VRR                          EQU     H'0005'
VR3                          EQU     H'0003'
VR2                          EQU     H'0002'
VR1                          EQU     H'0001'
VR0                          EQU     H'0000'

;----- EECON1 -------------------------------------------------------------

WRERR                        EQU     H'0003'
WREN                         EQU     H'0002'
WR                           EQU     H'0001'
RD                           EQU     H'0000'

;==========================================================================
;
;       RAM Definition
;
;==========================================================================

        __MAXRAM H'FF'
        __BADRAM H'06', H'08'-H'09', H'0D', H'11'-H'18', H'1A'-H'1F', H'60'-H'7F'
        __BADRAM H'86', H'88'-H'89', H'8D', H'8F', H'91'-H'94', H'97'-H'98', H'9E'-H'9F', H'E0'-H'FF'


;==========================================================================
;
;       Variable Definition
;
;==========================================================================


TIMER1          EQU     H'20'   ;Timer 1, Used for general delay.		
TIMER2          EQU     H'21'   ;Timer 2, used for delay !
EFFECT		EQU	H'22'


		ORG	0
		GOTO	RESET
	
		
;		**************************
;               *        delay  routine: *
;               **************************
DELAY		CLRWDT
		MOVLW   D'255'          ;*
                MOVWF   TIMER1          ;*
                ;
DELAY2		MOVLW	D'255'
		MOVWF	TIMER2
		DECFSZ  TIMER2,F        ;*
                GOTO    $-1             ;*
                
		DECFSZ	TIMER1,F
		GOTO	DELAY2	
		RETLW   0


;		**************************
;               *     main routine:      *
;               **************************

RESET		
		
		BSF	STATUS,RP0
		MOVLW	B'00001111'
		MOVWF	TRISA		
		MOVLW	B'00000000'
		MOVWF	TRISC
		MOVLW	B'11001000'
		MOVWF	OPTION_REG
		BCF	STATUS,RP0

		CLRF	PORTA
		CLRF	PORTC

LOOP		CLRWDT
		MOVLW	B'10011111'
		MOVWF	PORTC
		CALL	DELAY
		CLRF	PORTC
		CALL	DELAY

		GOTO	LOOP

	        END                     ;End of source code.


 
