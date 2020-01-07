;**************************************************************************
;*          K8048  Microchip PIC(tm) Programmer & experiment board        *
;**************************************************************************
;*          (C) VELLEMAN Components,2003  All rights reserved             *
;**************************************************************************
;*          Hardw. Rev: P8048'1          Softw. Rev:  1.02                *
;*          OSC.......: XT 4MHz Max.     POWER.....:  15V DC              *
;**************************************************************************

;==========================================================================
;	Example file F84DEMO2: Pusbutton test
;	
;	Pressing SW1 will enable LD1
;	Pressing SW2 will enable LD2
;	Pressing SW3 will enable LD3
;	Pressing SW4 will enable LD4
;       
;==========================================================================

	

;==========================================================================
;
;       Configuration Bits
;
;==========================================================================

_CP_ON                       EQU     H'000F'
_CP_OFF                      EQU     H'3FFF'
_PWRTE_ON                    EQU     H'3FF7'
_PWRTE_OFF                   EQU     H'3FFF'
_WDT_ON                      EQU     H'3FFF'
_WDT_OFF                     EQU     H'3FFB'
_LP_OSC                      EQU     H'3FFC'
_XT_OSC                      EQU     H'3FFD'
_HS_OSC                      EQU     H'3FFE'
_RC_OSC                      EQU     H'3FFF'

	__CONFIG        _CP_OFF & _PWRTE_ON & _WDT_OFF & _XT_OSC 

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
PORTB                        EQU     H'0006'
EEDATA                       EQU     H'0008'
EEADR                        EQU     H'0009'
PCLATH                       EQU     H'000A'
INTCON                       EQU     H'000B'

OPTION_REG                   EQU     H'0081'
TRISA                        EQU     H'0085'
TRISB                        EQU     H'0086'
EECON1                       EQU     H'0088'
EECON2                       EQU     H'0089'

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
EEIE                         EQU     H'0006'
T0IE                         EQU     H'0005'
INTE                         EQU     H'0004'
RBIE                         EQU     H'0003'
T0IF                         EQU     H'0002'
INTF                         EQU     H'0001'
RBIF                         EQU     H'0000'

;----- OPTION_REG Bits ----------------------------------------------------

NOT_RBPU                     EQU     H'0007'
INTEDG                       EQU     H'0006'
T0CS                         EQU     H'0005'
T0SE                         EQU     H'0004'
PSA                          EQU     H'0003'
PS2                          EQU     H'0002'
PS1                          EQU     H'0001'
PS0                          EQU     H'0000'

;----- EECON1 Bits --------------------------------------------------------

EEIF                         EQU     H'0004'
WRERR                        EQU     H'0003'
WREN                         EQU     H'0002'
WR                           EQU     H'0001'
RD                           EQU     H'0000'

;==========================================================================
;
;       RAM Definition
;
;==========================================================================

        __MAXRAM H'CF'
        __BADRAM H'07', H'50'-H'7F', H'87'

;==========================================================================
;
;	Variables
;       
;==========================================================================

TIMER1          EQU     H'0C' 		;Timer 1, used for general delay.		
TIMER2          EQU     H'0D'   	;Timer 2, used for delay !

;==========================================================================
;	PORTA & PORTB  Bits.  
;==========================================================================
;INPUTS
SW1		EQU     H'00'		;SW1 is triggering RA0
SW2		EQU     H'01'		;SW2 is triggering RA1
SW3		EQU     H'02'		;SW3 is triggering RA2
SW4		EQU     H'03'		;SW4 is triggering RA3
;OUTPUTS
LD1		EQU	H'00'		;LD1 is connected to RB0
LD2		EQU	H'01'		;LD2 is connected to RB1
LD3		EQU	H'02'		;LD3 is connected to RB2
LD4		EQU	H'03'		;LD4 is connected to RB3



		ORG	0		;Reset vector address for PIC16F84
		GOTO	RESET		;Jump to RESET routine when boot PIC.
	
;		**************************	
;               *     delay  routine:    *
;               **************************

DELAY		MOVLW   D'50'          	;Put 50 decimal in the 'TIMER1' register.
                MOVWF   TIMER1          
                ;
DELAY2		MOVLW	D'50'		;Put 50 decimal in the 'TIMER2' register.
		MOVWF	TIMER2
		DECFSZ  TIMER2,F        ;Timer2 = Timer2 -1, skip next instruction if Timer2 = 0.
                GOTO    $-1             ;Jump back 1 instruction.
                
		DECFSZ	TIMER1,F	;Timer1 = Timer1 - 1, skip next instruction if Timer1 = 0
		GOTO	DELAY2		;Jump to 'DELAY2' routine	
		RETLW   0		;Return (jump back to main) and load W-reg with 0.
		
;		**************************
;               *     main routine:      *
;               **************************

RESET		
		
		BSF	STATUS,RP0	;Switch to program memory bank 1 of PIC
		MOVLW	B'00001111'	;All available PORTA I/O are set as inputs.
		MOVWF	TRISA		;Config here PORTA	
		MOVLW	B'11000000'	;RB0...RB5 are outputs, RB6&7 are set as input.
		MOVWF	TRISB		;                       RB6&7 are used by K8048 for programming PIC.
		BCF	STATUS,RP0	;Swicth back to program memory bank 0 of PIC.
		
		CLRF	PORTB		;Clear all PORTB outputs before start mainloop.

LOOP		BTFSC	PORTA,SW1	;Test if SW1 is pressed ?
		BSF	PORTB,LD1	;Yes, Set LED LD1 ON.
		
		BTFSC	PORTA,SW2	;''
		BSF	PORTB,LD2	
		
		BTFSC	PORTA,SW3
		BSF	PORTB,LD3	
		
		BTFSC	PORTA,SW4
		BSF	PORTB,LD4	


		CALL	DELAY		;Wait ....
		CLRF	PORTB		;Set all outputs (LD1...LD4) OFF at the same time 

		GOTO	LOOP		;Jump back to begin of LOOP.

	        END                     ;End of source code.


 
