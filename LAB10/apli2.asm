;valores analógicos en lcd
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20				;Creamos todas las 
entero						;variables necesarias
analogico
residuo
decenas
unidades
endc
org		0000h
call	Inicio_lcd

;Iniciamos en 0 todas nuestras variables
clrf	entero
clrf	analogico
clrf	residuo
clrf	decenas
clrf	unidades
;Leeremos señales analógicas del pin AN0
movlw	.0
call	Inicio_ADC
cursor off
Repite
	borralcd				;Borra la pantalla lcd
	mensaje 1				;Muestra 'Voltaje:'
	call	ADC8Bits		;Lee AN0
	clrf	entero			;entero = 0
	clrf	residuo			;residuo = 0
	clrf	decenas			;decenas = 0
	clrf	unidades		;unidades = 0
	movf	RegADC1,0		;Cargamos a W el valor binario
	movwf	analogico		;Movemos W a analogico

Entero
	movf	analogico,0				;Cargo analogico en W
	movwf	residuo					;Cargo W a residuo
	csme	analogico,.51,FinEntero	;Comparo y salto si es menor a 51
	movlw	.51						;Cargo 51 a W
	subwf	analogico,1				;Resto analogico menos 51, guardo en
									;analogico
	incf	entero					;Incremento en uno el valor de entero
	goto	Entero					;Ir a Entero
FinEntero
	movf	residuo,0		;Cargo residuo a W
	addwf	residuo,1		;Sumo residuo más residuo para duplicarlo y
							;lo guardo en esa misma variable
Decimales
	movf	residuo,0				;Cargo residuo a W
	movwf	unidades				;Cargo W en unidades
	csme	residuo,.10,FinDecimales;Comaparo y salto si es menor a 10
	movlw	.10						;Cargo 10 a W
	subwf	residuo,1				;Resto residuo menos 10, guardo en
									;residuo
	incf	decenas					;Aumento en uno el valor de decenas
	goto	Decimales				;Ir a Decimales
FinDecimales

	csi	entero,.0,A0			;Comparo entero con
	csi	entero,.1,A1			;sus valores posibles
	csi	entero,.2,A2			;y nos dirigimos a
	csi	entero,.3,A3			;sus rutinas para
	csi	entero,.4,A4			;mostrarlo en el lcd
	csi	entero,.5,A5
	csi	entero,.6,A6
	csi	entero,.7,A7
	csi	entero,.8,A8
	csi	entero,.9,A9
SIGUE
	movlw	'.'					;Mandamos el punto
	call	EnviaCarLCD			;decimal
	csi	decenas,.0,B0			;Comparo decenas
	csi	decenas,.1,B1			;con sus valores
	csi	decenas,.2,B2			;posibles y nos 
	csi	decenas,.3,B3			;dirigimos a sus
	csi	decenas,.4,B4			;rutinas para
	csi	decenas,.5,B5			;mostrarlo en el
	csi	decenas,.6,B6			;lcd
	csi	decenas,.7,B7
	csi	decenas,.8,B8
	csi	decenas,.9,B9
SIGUE2
	csi	unidades,.0,C0			;Comparo unidades
	csi	unidades,.1,C1			;con sus valores
	csi	unidades,.2,C2			;posibles y nos
	csi	unidades,.3,C3			;dirigimos a sus
	csi	unidades,.4,C4			;rutinas para
	csi	unidades,.5,C5			;mostrarlo en el
	csi	unidades,.6,C6			;lcd
	csi	unidades,.7,C7
	csi	unidades,.8,C8
	csi	unidades,.9,C9
SIGUE3
	movlw	' '				
	movlw	'V'						;Mandamos V (voltaje)
	call	EnviaCarLCD			
	milisegundo	.50				;Retardo 50 ms
	goto	Repite				;Ir a repite

A0	mensaje 2				;'0'
	goto	SIGUE			;Ir a SIGUE
A1	mensaje 3				;'1'
	goto	SIGUE
A2	mensaje 4				;'2'
	goto	SIGUE
A3	mensaje 5				;'3'
	goto	SIGUE
A4	mensaje 6				;'4'
	goto	SIGUE
A5	mensaje 7				;'5'
	goto	SIGUE
A6	mensaje 8				;'6'
	goto	SIGUE
A7	mensaje 9				;'7'
	goto	SIGUE
A8	mensaje .10				;'8'
	goto	SIGUE
A9	mensaje .11				;'9'
	goto	SIGUE

B0	mensaje 2
	goto	SIGUE2
B1	mensaje 3
	goto	SIGUE2
B2	mensaje 4
	goto	SIGUE2
B3	mensaje 5
	goto	SIGUE2
B4	mensaje 6
	goto	SIGUE2
B5	mensaje 7
	goto	SIGUE2
B6	mensaje 8
	goto	SIGUE2
B7	mensaje 9
	goto	SIGUE2
B8	mensaje .10
	goto	SIGUE2
B9	mensaje .11
	goto	SIGUE2

C0	mensaje 2
	goto	SIGUE3
C1	mensaje 3
	goto	SIGUE3
C2	mensaje 4
	goto	SIGUE3
C3	mensaje 5
	goto	SIGUE3
C4	mensaje 6
	goto	SIGUE3
C5	mensaje 7
	goto	SIGUE3
C6	mensaje 8
	goto	SIGUE3
C7	mensaje 9
	goto	SIGUE3
C8	mensaje .10
	goto	SIGUE3
C9	mensaje .11
	goto	SIGUE3

;Librerías
include<electronicpic16f877.asm>
include<adc.asm>
include<lcd.asm>
include<mensaje.asm>
end	