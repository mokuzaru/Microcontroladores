;Ejemplo02
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20
endc
	
org		0000h
banco 	1						;Ingresamos al banco 1
clrf	trisb					;PORTB = salidas
clrf	trisc					;PORTC = salidas
banco	0						;Regresamos al banco 0
	
clrf	portb					;Iniciamos PORTB = 0h
clrf	portc					;Iniciamos PORTC = 0h
movlw	.5						;Cargamos 5 a W (escogemos el canal)
call	Inicio_ADC				;Rutina para configurar el conversor,
								;el canal leído será el AN5
repite
	call	ADC10Bits			;Valor analógico representado en 10 bits
	movf	RegADC1,0			;Movemos 8 bits menos significativos a W
	movwf	portb				;Movemos W al PORTB
	movf	RegADC2,0			;Movemos 2 bits más significativos a W
	movwf	portc				;Movemos W al PORTC
	goto	repite				;Ir a repite	

include<electronicpic16f877.asm>
include<adc.asm>
end