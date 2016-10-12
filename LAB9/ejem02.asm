list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config 0x3f32
cblock	0x20
cuenta								;Variable para almacenar una cuenta
endc
org 0000h							;Inica el programa en cero
goto	Inicio						;Ir a la etiqueta inicio
org		0004h						;Ubica el programa en 4
goto	Interrupcion				;Ir a la etiqueta interrupcion
Inicio
	banco 	1						;Ingresa al banco 1
	clrf	trisb					;PORTB = salidas
	bcf		trisc,0					;RC0 = salida
	banco	0						;Regresa al banco 0
	clrf	cuenta					;Inicia cuenta en 0
	bcf		portc,0					;RC0=0
	call	InicioIntTMR0			;Inicia la cuenta para la interrupción
repite
	mover portb,0xff				;PORTB = b'11111111'
	segundo	.1						;Tiempo de 1 segundo
	clrf	portb					;PORTB = b'00000000'
	segundo	.1						;Tiempo de 1 segundo
	goto	repite					;Ir a la etiqueta repite
Interrupcion
	incf	cuenta					;Incremente en uno la variable cuenta
	csi		cuenta,.100,PrenderLed	;Compara y va a PrendeLed si cuenta es 100
	csi		cuenta,.200,ApagarLed	;Compara y va a ApagarLed si cuenta es 200
	call	FinIntTMR0				;Finaliza la interrupción
	retfie							;Retorna donde se produjo la interrupción
PrenderLed
	bsf		portc,0					;RC0 = 1
	call	FinIntTMR0				;Finaliza la interrupción
	retfie							;Retorna donde se produjo la interrupción
ApagarLed
	bcf		portc,0					;RC0 = 0
	clrf	cuenta					;Reinicia la cuenta a 0
	call	FinIntTMR0				;Finaliza la interrupción
	retfie							;Retorna donde se produjo la interrupción
include<electronicpic16f877.asm>
include<interrupcion.asm>
end
