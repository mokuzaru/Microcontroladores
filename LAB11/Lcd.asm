;.......................................................................
;NOMBRE DEL ARCHIVO:LCD.ASM
;.......................................................................
;***********************************************************************

	cblock
		CHAR    	;ubicación del caracter
		TEMP		;almacenamiento temporal
		NumCadena 	;número de la cadena 
		indice	
		W_temp
	endc

DATOS   EQU	PORTD		;lineas de datos = portD
CNTRL   EQU     PORTD		;lineas de control = portD

E       EQU     1		;linea de control E = bit1
RW      EQU     2		;linea de control RW = bit2
RS      EQU     3		;linea de control RS = bit3

DISP_ON_CURSOR_BLINK	EQU	0FH     ;Display on, cursor on,blink
DISP_ON_NOCURSOR		EQU	0CH     ;Display on, cursor off
DISP_CLEAR			EQU	01H     ;Aclarar display
DISP_OFF 			EQU	08H		;apaga el display
DISP_LINEA2			EQU	0C0H		;segunda linea
DISP_RETURN_HOME		EQU	02H

CURSOR_LEFT			EQU	10H	; Cursor a la izquierda
CURSOR_RIGHT			EQU	14H	; Cursor a la derecha

DISPLAY_LEFT			EQU	18H	; DISPLAY a la izquierda
DISPLAY_RIGHT			EQU	1CH	; DISPLAY a la derecha

off					EQU  0
on					EQU  1

;*******************************************************************
;EnviaCarLCD - Envia un caracter a la pantalla LCD                 *
;Esta rutina separa el caracter entre el nibble superior e inferior*
;y los envia a la pantalla LCD, nibble mas alto primero		   * 
;*******************************************************************
EnviaCarLCD
	movwf	W_temp		;almacena temporal W
	movwf   CHAR            ;W contiene caracter a ser enviado
	call    TestBusyLCD     ;Esperar que LCD este listo
	movf    CHAR,w          
	andlw   0xF0            ;Obtener el nibble superior
	movwf   DATOS           ;Enviar datos al LCD
	bcf     CNTRL,RW        ;Poner al LCD en modo lectura
	bsf     CNTRL,RS        ;Poner al LCD en modo de datos
	nop
	bsf     CNTRL,E         ;Conmutar E
	nop
	bcf     CNTRL,E
	swapf   CHAR,w
	andlw   0xF0            ;Obtener el nibble inferior
	movwf   DATOS           ;Enviar datos al LCD
	bcf     CNTRL,RW        ;Poner al LCD en modo lectura
	bsf     CNTRL,RS        ;Poner al LCD en modo de datos
	nop
	bsf     CNTRL,E         ;Conmutar E
	nop
	bcf     CNTRL,E
	movf	W_temp,W	;restaura W
	return

;*******************************************************************
;*EnviaCmdLCD - Envia comando a la pantalla LCD                       *
;*Esta rutina separa el comando en nibble superior y nibble	   *
;*inferior y los envia a la pantalla LCD, nibble mas alto primero  *
;*******************************************************************
EnviaCmdLCD
	movwf   CHAR            ;Caracter a ser enviado esta en reg. W
	call    TestBusyLCD     ;esperar LCD listo
	movf    CHAR,w          
	andlw   0xF0            ;Obtener nibble superior
	movwf   DATOS           ;enviar dato al LCD
	bcf     CNTRL,RW        ;Poner LCD en modo lectura
	bcf     CNTRL,RS        ;Poner LCD en modo comando
	nop
	bsf     CNTRL,E         ;conmutar E para LCD
	nop
	bcf     CNTRL,E
	swapf   CHAR,w
	andlw   0xF0            ;Obtener nibble inferior
	movwf   DATOS           ;enviar dato al LCD
	nop
	bsf     CNTRL,E         ;conmutar E para LCD
	nop
	bcf     CNTRL,E
	return

;*******************************************************************
;* Esta rutina chequea el flag de busy de la pantalla LCD, 	   *
;* retorna cuando no esta ocupado				   *
;* Afecta:                                                         *
;*      TEMP - retorna con busy/address                            *
;*******************************************************************
TestBusyLCD
	banco	1
	movlw	b'11110000'	;Seleccionar DATOS[4..7]
	movwf	TRISD
	banco	0
	bcf     CNTRL,RS        ;Porne LCD en modo comando
	bsf     CNTRL,RW        ;prepara para leer flag de busy
	nop
	bsf     CNTRL,E         ;E='1'
	nop
	movf    DATOS,W         ;Lee flag de busy del nibble sup., direccion DDRam
	bcf     CNTRL,E         ;conmuta E para tomar nibble inferior
	andlw   0F0h            ;Enmascara el nibble
	movwf   TEMP		;lo almacena
	nop
	bsf     CNTRL,E
	nop
	swapf   DATOS,w         ;Lee flag de busy del nibble inf., direccion DDRam
	bcf     CNTRL,E         ;Poner E='0'
	andlw   00Fh            ;Enmascara nibble superior
	iorwf   TEMP,1          ;Combina nibbles
	btfsc   TEMP,7          ;Chequea flag de busy, alto = ocupado
	goto    TestBusyLCD     ;Si esta ocupado, chequear nueamente
	bcf     CNTRL,RW        
	banco	1
	movlw	0x00		;poner DATOS como salidas
	movwf	TRISD
	banco	0
	return

;**************************************************************
;* Esta rutina inicializa la pantalla LCD		      *
;*  Afecta:                                                   *
;*      TEMP - retornado con busy/address		      *
;**************************************************************
Inicio_lcd
	banco	0
	bcf	CNTRL,E		; aclara lineas de control
	bcf	CNTRL,RW
	bcf	CNTRL,RS
	movlw	0x0F		;aclara lineas de datos
	movwf	DATOS
;Configurar puertos DATOS[4..7] y CNTRL[1..3] como salidas
	banco	1
	movlw   B'00001111'     ;4 bits mas altos de DATOS 
	movwf	TRISD
	bcf	TRISD,E		;bits de control como salidas
	bcf	TRISD,RW
	bcf	TRISD,RS
	banco	0

;Inicializar la pantalla LCD

	movlw	t15.4ms		;guarda de 15 ms
	movwf	contador_2
	call	retardo
	movlw   B'00110000'     ;Configurar LCD para interfaz de 4 bits
	movwf   DATOS
	nop
	bsf     CNTRL,E         ;conmutar E para LCD
	nop
	bcf     CNTRL,E
	movlw	t4.6ms
	movwf	contador_2
	call	retardo
	movlw   B'00110000'     ;Funcion escoger 2 lineas
	movwf   DATOS           ;de caracteres de 5x7 bits 
	nop
	bsf     CNTRL,E         ;conmutar E para LCD
	nop
	bcf     CNTRL,E
	movlw   B'00110000'     ;Parte de la secuencia de encendido
	movwf   DATOS            
	nop
	bsf     CNTRL,E         ;conmutar E para LCD
	nop
	bcf     CNTRL,E
	movlw	t200us		;retardo
	movwf	contador_2
	call	retardo
	movlw   B'00100000'	;Configurar modo 4 bits
	movwf   DATOS		;
	nop
	bsf     CNTRL,E         ;conmutar E para LCD
	nop
	bcf     CNTRL,E

;El flag de ocupado estaria valido despues de este punto
	movlw   B'00101000'     ;Interfaz de 4 bits, 2 lineas
	call    EnviaCmdLCD		; de caracteres de 5x7
	movlw   DISP_ON_CURSOR_BLINK     ;Display on, cursor on,blink
	call    EnviaCmdLCD
	movlw   DISP_CLEAR     	;Aclarar display
	call    EnviaCmdLCD
	movlw   B'00000110'     ;Poner modo incremental, sin desplazamiento
	call    EnviaCmdLCD		
	movlw   B'10000000'     ;Address DDRam upper left
	call    EnviaCmdLCD
	return


