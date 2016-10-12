list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config 0x3f32
cblock	0x20						;Variables de otras librerías
cuenta								;Cuenta de unidades
cuenta2								;Cuenta de decenas
cuenta3								;Cuenta de centenas
endc
	org 0000h						;Inicia en 0
	goto	Inicio					;Ir a Inicio
	org		0004h					;Mueve a 4h
	goto	Interrupcion			;Ir a Interrupcion
Inicio	
	banco 	1						;Ir a banco 1
	clrf	trisb					;PORTB = salidas
	clrf	trisc					;PORTC = salidas
	clrf	trisd					;PORTD = salidas
	banco	0						;Regresa al banco 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	clrf	cuenta					;Cuenta inicia en 0
	clrf	cuenta2					;Cuenta2 inicia en 0
	clrf	cuenta3					;Cuenta3 inicia en 0
	clrf	portb					;PORTB = b'00000000'
	movlw	0						;Carga a W en 0
	call	DisplayCatodoComun		;Llama a la rutina del display
	movwf	portc					;Carga el valor devuelto en PORTC
	movwf	portd					;Carga el valor devuelto en PORTD	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call	InicioIntTMR0			;Inicia la Interrupción
;Display
repite
	movf	cuenta,0				;Carga cuenta a W
	call	DisplayCatodoComun		;Llama a la rutina del display
	movwf	portc					;Carga el valor devuelto en PORTC
	movf	cuenta2,0				;Carga cuenta2 a W
	call	DisplayCatodoComun		;Llama a la rutina del display
	movwf	portd					;Carga el valor devuelto en PORTD
	incf	cuenta,1				;Aumenta cuenta en una unidad
	csi		cuenta,.10,IniciaCero	;Si cuenta es 10 va a IniciaCero
paso1
	segundo	.1						;Demora 1 segundo
	goto	repite					;Ir a repite
IniciaCero	
	movlw	0						;Carga 0 a W
	movwf	cuenta					;Mueve W a cuenta
	incf	cuenta2					;Aumenta cuenta 2 en una unidad
	csi		cuenta2,.10,IniciaCero2	;Si cuenta2 es 10 va a IniciaCero2
	goto	paso1					;Ir a paso1
IniciaCero2
	movlw	0						;Carga 0 a W
	movwf	cuenta					;Mueve W a cuenta
	movwf	cuenta2					;Mueve W a cuenta2
	goto	paso1					;Ir a paso 1
;------------------------------
Interrupcion
	incf	cuenta3					;Aumenta cuenta3 en una unidad
	csi		cuenta3,.125,PrenderLed	;Si cuenta3 es 125 va a PrenderLed
	csi		cuenta3,.250,ApagarLed	;Si cuenta3 es 250 va a ApagarLed
	call	FinIntTMR0				;Finaliza la interrupción
	retfie							;Retorna donde se inició la interrupción
PrenderLed
	movlw	b'11111111'				;Carga 255 a W
	movwf	portb					;Mueve W al PORTB
	call	FinIntTMR0				;Finaliza la interrupción
	retfie							;Retorna donde se inició la interrupción
ApagarLed
	clrf	portb					;PORTB = b'00000000'
	clrf	cuenta3					;cuenta3 = 0
	call	FinIntTMR0				;Finaliza la interrupción
	retfie							;Retorna donde se inició la interrupción
;------------------------------
include<electronicpic16f877.asm>
include<interrupcion.asm>
end