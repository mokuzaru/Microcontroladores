;Ejemplo 2
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20				;Variables a utilizar
endc
org		0000h				;Iniciamos en la posición 0
call	RS232_Inicializa	;Configuramos los pines Rx(RC7) y Tx(RC6)
Repite
	movlw	.65
	call	RS232_EnviaDato	
	milisegundo	.1
	
	movlw	.49
	call	RS232_EnviaDato	
	milisegundo	.1
	
	movlw	.66
	call	RS232_EnviaDato	
	milisegundo	.1
	
	movlw	.50
	call	RS232_EnviaDato	
	milisegundo	.1
	goto	Repite			
include<electronicpic16f877.asm>
include<lcd.asm>
include<rs232_16f877.asm>
end