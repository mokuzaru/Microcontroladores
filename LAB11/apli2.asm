;Aplicacion
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20
cuenta
dato
fila
a1
a2
a3
a4
a5
a6
a7
a8
a9
a10
a11
a12
a13
a14
a15
a16
endc
org		0000h
call	Inicio_lcd
call	RS232_Inicializa
clrf	cuenta
clrf	dato
clrf	fila
clrf	a1
clrf	a2
clrf	a3
clrf	a4
clrf	a5
clrf	a6
clrf	a7
clrf	a8
clrf	a9
clrf	a10
clrf	a11
clrf	a12
clrf	a13
clrf	a14
clrf	a15
clrf	a16
cursor off
Repite
	call	RS232_LeeDato
	csnir	RS232_LeeDato,dato,Diferentes
Regresa
	csi		cuenta,.16,Enter1
Enter2
	movf	RS232_Dato,0
	movwf	dato
	csi		cuenta,.1,Dato1
	csi		cuenta,.2,Dato2
	csi		cuenta,.3,Dato3
	csi		cuenta,.4,Dato4
	csi		cuenta,.5,Dato5
	csi		cuenta,.6,Dato6
	csi		cuenta,.7,Dato7
	csi		cuenta,.8,Dato8
	csi		cuenta,.9,Dato9
	csi		cuenta,.10,Dato10
	csi		cuenta,.11,Dato11
	csi		cuenta,.12,Dato12
	csi		cuenta,.13,Dato13
	csi		cuenta,.14,Dato14
	csi		cuenta,.15,Dato15
	csi		cuenta,.16,Dato16
Guardado
	call	EnviaCarLCD
	goto	Repite
Diferentes
	incf	cuenta,1
	goto	Regresa
Enter1
	borralcd
	movf	a1,0
	call	EnviaCarLCD
	movf	a2,0
	call	EnviaCarLCD
	movf	a3,0
	call	EnviaCarLCD
	movf	a4,0
	call	EnviaCarLCD
	movf	a5,0
	call	EnviaCarLCD
	movf	a6,0
	call	EnviaCarLCD
	movf	a7,0
	call	EnviaCarLCD
	movf	a8,0
	call	EnviaCarLCD
	movf	a9,0
	call	EnviaCarLCD
	movf	a10,0
	call	EnviaCarLCD
	movf	a11,0
	call	EnviaCarLCD
	movf	a12,0
	call	EnviaCarLCD
	movf	a13,0
	call	EnviaCarLCD
	movf	a14,0
	call	EnviaCarLCD
	movf	a15,0
	call	EnviaCarLCD
	movf	a16,0
	call	EnviaCarLCD
	enter
	clrf	a1
	clrf	a2
	clrf	a3
	clrf	a4
	clrf	a5
	clrf	a6
	clrf	a7
	clrf	a8
	clrf	a9
	clrf	a10
	clrf	a11
	clrf	a12
	clrf	a13
	clrf	a14
	clrf	a15
	clrf	a16
	clrf 	cuenta
	incf	fila,1
	csi		fila,.2,Borra1
Borra2
	goto	Enter2
Borra1
	borralcd
	clrf	fila
	goto	Borra2

Dato1	movwf	a1
		goto	Guardado
Dato2	movwf	a2
		goto	Guardado
Dato3	movwf	a3
		goto	Guardado
Dato4	movwf	a4
		goto	Guardado
Dato5	movwf	a5
		goto	Guardado
Dato6	movwf	a6
		goto	Guardado
Dato7	movwf	a7
		goto	Guardado
Dato8	movwf	a8
		goto	Guardado
Dato9	movwf	a9
		goto	Guardado
Dato10	movwf	a10
		goto	Guardado
Dato11	movwf	a11
		goto	Guardado
Dato12	movwf	a12
		goto	Guardado
Dato13	movwf	a13
		goto	Guardado
Dato14	movwf	a14
		goto	Guardado
Dato15	movwf	a15
		goto	Guardado
Dato16	movwf	a16
		goto	Guardado

include<electronicpic16f877.asm>
include<lcd.asm>
include<rs232_16f877.asm>
end