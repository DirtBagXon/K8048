;**************************************************************************
;*          K8048  Microchip PIC(tm) Programmer & Experiment board        *
;**************************************************************************
;*          (C) VELLEMAN Components,2003  All rights reserved             *
;*          Hardware & sample software by Pascal De Petter 	          *
;**************************************************************************
;*          Hardw. Rev: P8048'1          Softw. Rev:  1.02                *
;*          OSC.......: XT 4MHz Max.     POWER.....:  15V DC              *
;**************************************************************************

;==========================================================================
;	 Tutor example file: F84DEMO1.ASM
;       
;	'Simple LED running light' 
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
;       Variables
;
;==========================================================================


TIMER1          EQU     H'0C'   ;Timer 1, Used for general delay.		
TIMER2          EQU     H'0D'   ;Timer 2, used for delay !
EFFECT		EQU	H'0E'	;Used to store pattern




		ORG	0			;Setting Reset vector, reset vector address is 000h in PIC16F84
		GOTO	RESET			;Jump to RESET procedure when boot-up PIC device.
	
		
;		**************************	;Delay routine.
;               *        delay  routine: *
;               **************************
DELAY		MOVLW   D'150'          ;*	;Put 150 decimal in the 'TIMER1' register.
                MOVWF   TIMER1          ;*
                ;
DELAY2		MOVLW	D'150'			;Put 150 decimal in the 'TIMER2' register.
		MOVWF	TIMER2
		DECFSZ  TIMER2,F        ;*	;Timer2 = Timer2 -1, skip next instruction if Timer2 = 0.
                GOTO    $-1             ;*	;Jump back 1 instruction.
                
		DECFSZ	TIMER1,F		;Timer1 = Timer1 - 1, skip next instruction if Timer1 = 0
		GOTO	DELAY2			;Jump to 'DELAY2' routine	
		RETLW   0			;Return (jump back to main) and load W-reg with 0.


;		**************************
;               *     main routine:      *
;               **************************

RESET						;Program starts here !!!		
		
		BSF	STATUS,RP0		;Jump to bank 1 of PIC16F84 to access special registers.
		MOVLW	B'00001111'		;Config Port A, Low nibble = Ra0 -> Ra3 are inputs, high nibble not implemented.
		MOVWF	TRISA			;Set I/O configuration for PORTA
		MOVLW	B'11000000'		;Config Port B, Ra7 & Ra6 are input, Ra5...Ra0 are outputs.
		MOVWF	TRISB			;Set I/O configuration for PORTB
		BCF	STATUS,RP0		;Jump back to bank 0 of PIC.

		CLRF	PORTA			;Clear all I/O's of PORTA
		CLRF	PORTB			;Clear all I/O's of PORTB
		MOVLW	B'00000001'		;Load start pattern for running light. 
		MOVWF	EFFECT

						;Loop starts here !!!

LOOP		MOVFW	EFFECT			;Read current pattern from EFFECT register.
		MOVWF	PORTB			;and copy it to PORTB (1 LED with be ON)
		CALL	DELAY			;Wait here
						
						;Here we shift 1 bit in the register to create next pattern of
						;the running light sequence.
		
		RLF	EFFECT,W		;Bit rotation to LEFT and store result in W-register
						;to avoid filling register with CARRY bit (see datasheets RLF command)
		RLF	EFFECT,F		;Bit rotation to LEFT and store result back in the same register.
						;Example: 00000010 => 00000100.
					
			

		GOTO	LOOP			;Jump endless back to begin of LOOP.


	        END                   		;End of source code.


 
