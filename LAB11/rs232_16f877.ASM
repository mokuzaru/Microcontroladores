;*******************************************************************************
;-------------------------------------------------------------------------------
;===============================================================================
;Nombre de archivo:RS232_16f877.asm
;Permite realizar las tareas de control de la transmisión serie asíncrona según
;la norma RS-232.
;
;Hecho por: Ing. Carlos E. MEndiola Mogollón
;Empresa: Electronic-digital (CM)
;E-mail: Electronic_digital20@hotmail.com
;Dirección Web:www.electronic-digital.blogspot.com

;Historial:
;-Velocidad de transmisión: 9600 baudios.
;-Tasa de transmisión bit a bit: 104us.
;-Bit Start a nivel bajo.
;-8 bits de dato.
;-Sin paridad.
;===============================================================================
;-------------------------------------------------------------------------------
	CBLOCK
	RS232_ContadorBits
	RS232_Dato
    Ret_micro
	ENDC

#DEFINE  RS232_Entrada	PORTC,7		; Pin rc7 como entrada=Rx
#DEFINE  RS232_Salida	PORTC,6		; Pin rc6 como salida =Tx

;*********************************************************************
;---------------------------------------------------------------------
; Configura las líneas de salida y entrada del microcontrolador.

RS232_Inicializa
	bsf	STATUS,RP0
	bsf	RS232_Entrada		;configura como entrada.
	bcf	RS232_Salida		;configura como salida.
	bcf	STATUS,RP0
	return



;*********************************************************************
;---------------------------------------------------------------------
; En el registro de trabajo W se almacena el  byte leído.

RS232_LeeDato
	movlw	d'8'				 ; Número de bits a recibir.
	movwf	RS232_ContadorBits
RS232_EsperaBitStart
	btfsc	RS232_Entrada 		 ; Entrada=0?
	goto	RS232_EsperaBitStart ; No --> espera el nivel bajo.
	call 	Retardo_100micros	 ; Si --> El primer bit se debe leer a un tiempo igual 
	call 	Retardo_50micros 	 ; a una vez y media el periodo de transmisión.
RS232_LeeBit
	bcf		STATUS,C			 ; C=0		 
	btfsc	RS232_Entrada		 ; Entrada=0?
	bsf		STATUS,C			 ; No --> C=1
	rrf		RS232_Dato,F		 ; Si --> Rota bit derecha en el registro.
	call	Retardo_100micros	 ; Los siguientes bits se lee 100us más tarde.
	decfsz 	RS232_ContadorBits,F ; Comprueba que es el último bit.
	goto	RS232_LeeBit		 ; Si no es el último bit pasa a leer el siguiente.
	call	Retardo_200micros	 ; Espera un tiempo igual al los 2 bits de Stop.
	movf	RS232_Dato,W		 ; El resultado se almacena en el registro W.
	return


;*********************************************************************
;---------------------------------------------------------------------	
;En el registo W esta el dato a enviar.

RS232_EnviaNumero					; Envía el código ASCII de un número.
	addlw	'0'						; Lo pasa a código ASCII sumándole el ASCII del 0.
RS232_EnviaDato
	movwf	RS232_Dato				; Guarda el contenido del byte a transmitir.
	movlw	d'8'					; Este es el número de bits a transmitir.
	movwf	RS232_ContadorBits
	bcf		RS232_Salida			; Bit de Start.
	call	Retardo_100micros
RS232_EnviaBit						; Comienza a enviar datos.
	rrf		RS232_Dato,F			; Lleva el bit que se quiere enviar al Carry para
	btfss	STATUS,C				; deducir su valor. ¿Es un "1" el bit a transmitir?
	goto	RS232_EnviaCero			; No, pues envía un "0".
RS232_EnviaUno
	bsf		RS232_Salida			; Transmite un "1".
	goto	RS232_FinEnviaBit
RS232_EnviaCero
	bcf		RS232_Salida			; Transmite un "0".
RS232_FinEnviaBit
	call	Retardo_100micros		; Este es el tiempo que estará en alto o bajo.
	decfsz 	RS232_ContadorBits,F	; Comprueba que es el último bit.
	goto	RS232_EnviaBit			; Como no es el último bit repite la operación.
	bsf		RS232_Salida			; Envía dos bits de Stop.
	call	Retardo_200micros
	return
	
;-------------------------------------------------
;para un cristal de 20Mhz.
;-------------------------------------------------
Retardo_200micros
    call   Retardo_100micros
    call   Retardo_100micros
    return
Retardo_100micros
    call   Retardo_50micros
    call   Retardo_50micros 
    return
Retardo_50micros
    movlw  .83
    movwf  Ret_micro
bucle_micro
    decfsz Ret_micro
    goto   bucle_micro
    return
