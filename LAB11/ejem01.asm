;Ejemplo 1
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20				;Variables a utilizar
endc
org		0000h				;Iniciamos en la posición 0
banco	1					;Entramos al banco 1
clrf	trisb				;PORTB = salidas
banco 	0					;Regresamos al banco 0
clrf	portb				;Iniciamos el PORTB en 0
call	RS232_Inicializa	;Configuramos los pines Rx(RC7) y Tx(RC6)
Repite
	call	RS232_LeeDato	;Leemos el dato recibido en RC7(Rx)
	movf	RS232_Dato,0	;Mueve el dato recibido a W
	movwf	portb			;Mueve W al PORTB
	goto	Repite			;Ir a Repite
include<electronicpic16f877.asm>
include<lcd.asm>
include<rs232_16f877.asm>
end