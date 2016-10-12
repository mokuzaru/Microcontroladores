list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config 0x3f32
cblock	0x20
endc
org 0000h
goto	Inicio				;Ir a la etiqueta Inicio
org		0004h				;Ubica el programa en la dirección 4h
goto	Interrupcion		;Ir a la etiqueta Interrupcion
Inicio
	banco 	1				;Ingresa al banco 1
	clrf	trisb			;PORTB = salidas
	banco	0				;Regresa al banco 0
	clrf	portb			;PORTB = b'00000000'
	call	InicioIntTMR0	;Llama a la rutina para iniciar la interrupción
							;luego de un milisegundo
repite
	nop						;No operación
	nop						;No operación
	goto	repite			;Ir a repite
Interrupcion
	mover portb,.255		;PORTB = b'11111111'
	milisegundo	.100		;Retardo de 100 milisegundos
	clrf	portb			;PORTB = b'00000000'
	milisegundo	.100		;Retardo de 100 milisegundos
	call	FinIntTMR0		;Llama a la rutina para finalizar la interrupción
	retfie					;Regresa y continua desde donde se produjo la
							;interrupción
include<electronicpic16f877.asm>
include<interrupcion.asm>
end
