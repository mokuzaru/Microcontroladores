;Aplicación - display
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20			;Creamos todas las 
entero					;variables necesarias
analogico
residuo
decenas
unidades
endc
	
org		0000h
;Configuramos como salidas los puertos B, C y D
banco	1
clrf	trisb
clrf	trisc
clrf	trisd
banco	0
;Iniciamos en 0 todas nuestras variables
clrf	entero
clrf	analogico
clrf	residuo
clrf	decenas
clrf	unidades
;Iniciamos en 0 los displays
movlw	.0
call	DisplayCatodoComun
movwf	portb
movwf	portc
movwf	portd
;Leeremos señales analógicas del pin AN0
movlw	.0
call	Inicio_ADC

Repite
	call	ADC8Bits	;Lee AN0
	clrf	entero		;Resetea variable
	clrf	residuo		;Resetea variable
	clrf	decenas		;Resetea variable
	clrf	unidades	;Resetea variable
	movf	RegADC1,0	;Carga a W el valor analógico convertido a binario
	movwf	analogico	;Guarda ese valor en analogico

Compara
	movf	analogico,0			;Cargo analogico a W
	movwf	residuo				;Grabo dicho valor en residuo
	csme	analogico,.51,FinalizaTesteo	;Comparo analogico con 51, y si es menor salta
	movlw	.51					;Carga 51 a W
	subwf	analogico,1			;Resto analogico menos 51 y guardo en residuo
	incf	entero				;Aumento en 1 la variable entero
	goto	Compara				;Ir a Compara	
FinalizaTesteo

	movf	residuo,0			;Mueve residuo a W
	addwf	residuo,1			;Duplica el valor de residuo (0-50 * 2 = 0 - 100)

HallaDecimales
	movf	residuo,0			;Mueve residuo a W
	movwf	unidades			;Mueve W a unidades
	csme	residuo,.10,FinDecenas;Compara residuo con 10, si es menor salta
	movlw	.10					;Carga 10 a W
	subwf	residuo,1			;Resta residuo menos 10, y guarda en residuo
	incf	decenas				;Aumenta en 1 las decenas
	goto	HallaDecimales		;Ir a HallaDecimales
FinDecenas

	movf	entero,0			;Carga entero a W
	call	DisplayCatodoComun	;Llama rutina del display
	movwf	PORTB				;Mueve W al PORTB
	movf	decenas,0			;Carga decenas a W
	call	DisplayCatodoComun	;Llama rutina del display
	movwf	PORTC				;Mueve W al PORTC
	movf	unidades,0			;Carga unidades a W
	call	DisplayCatodoComun	;Llama rutina del display
	movwf	PORTD				;Mueve W al PORTD

	milisegundo	.20				;Retardo para no saturar
	goto	Repite				;Ir a Repite

include<electronicpic16f877.asm>
include<adc.asm>
end