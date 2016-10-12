;asdasd
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20					;Variables a utilizar
endc

org		0000h					;Iniciamos en la posición 0
banco	1
clrf	TRISB
banco	0
call	RS232_Inicializa		;Configuramos los pines Rx(RC7) y Tx(RC6)
clrf	PORTB
								;para la comunicación RS232
Repite
	call	RS232_LeeDato
	csi		RS232_Dato,.65,Enciende	;A
	csi		RS232_Dato,.66,Apaga	;B
	goto	Repite

Enciende
	bsf		PORTB,0
	goto	Repite

Apaga
	bcf		PORTB,0
	goto	Repite

include<electronicpic16f877.asm>
include<lcd.asm>
include<rs232_16f877.asm>
end