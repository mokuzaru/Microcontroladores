;Ejemplo01
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20
endc
	
org		0000h					;Iniciamos en 0
banco 	1						;Ingresamos al banco 1
clrf	trisb					;PORTB = salidas
banco	0						;Regresamso al banco 0
	
clrf	portb					;Iniciamos PORTB = 0h
movlw	.0						;Cargamos 0 a W (Canal elegido)
call	Inicio_ADC				;Llamamos a la rutina para iniciar la
								;configuración del conversor
repite
	call	ADC8Bits			;Digitaliza el valor analógico leído
	movf	RegADC1,0			;Carga a W el valor digitalizado
	movwf	portb				;Muestra ese valor en el PORTB(leds)
	goto	repite				;Ir a repite

include<electronicpic16f877.asm>
include<adc.asm>
end