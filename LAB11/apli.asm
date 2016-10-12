;Aplicacion
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20					;Variables a utilizar
cuenta
dato
fila
endc

org		0000h					;Iniciamos en la posición 0
call	Inicio_lcd				;Configuramos el LCD en el PORTD
call	RS232_Inicializa		;Configuramos los pines Rx(RC7) y Tx(RC6)
								;para la comunicación RS232
clrf	cuenta					;cuenta = 0
clrf	dato					;dato = 0
clrf	fila					;fila = 0
cursor off						;Apagamos el cursor

Repite
	call	RS232_LeeDato		;Leemos el dato recibido en RC7(Rx)
	csnir	RS232_LeeDato,dato,Diferentes;Si es diferente a dato, salto
Regresa
	csi		cuenta,.16,Enter1	;Si es 16 salto a Enter1
	Regresa2
		movf	RS232_Dato,0	;Mueve el dato recibido a W
		movwf	dato			;Guarda W en dato
		call	EnviaCarLCD		;Envia W al LCD en código ASCII
		goto	Repite			;Ir a Repite
	Diferentes	
		incf	cuenta,1		;Aumenta la cuenta en 1
		goto	Regresa			;Ir a Regresa
	Enter1
		enter					;Pasa a la siguiente fila
		clrf 	cuenta			;Reinicia cuenta en 0
		incf	fila,1			;Incrementa en 1 a fila
		csi		fila,.2,Borra1	;Si fila es 2 salto a Borra1
		goto	Regresa			;Ir a Regresa
	Borra1
		borralcd				;Borra el LCD
		clrf	fila			;Reinicia fila en 0
		goto	Regresa2		;Ir a Regresa2
include<electronicpic16f877.asm>
include<lcd.asm>
include<rs232_16f877.asm>
end