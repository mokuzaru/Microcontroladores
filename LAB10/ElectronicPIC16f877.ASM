cblock	                	
Cont_1        
Cont_2        
Cont_3        
Cont_4        
contador_1	
contador_2	             
endc
;***************************************************************
;Rutinas para generaci�n de retardos
;Frecuencia de cristal:20Mhz
;***************************************************************
Milisegundo
         movwf  Cont_1
    xx
         movlw  .17
         movwf  Cont_2 
    xx1
         movlw  .58
         movwf  Cont_3     
    xx2
         nop
         nop
         decfsz Cont_3     
         goto   xx2
         decfsz Cont_2 
         goto   xx1
         decfsz Cont_1
         goto   xx
         return
Segundo
         movwf  Cont_1
    xxx
         movlw  .250
         movwf  Cont_2 
    xxx1
         movlw  .250
         movwf  Cont_3     
    xxx2
         movlw  .19
         movwf  Cont_4 
    xxx3
         nop
         decfsz Cont_4 
         goto   xxx3
         decfsz Cont_3     
         goto   xxx2
         decfsz Cont_2 
         goto   xxx1
         decfsz Cont_1
         goto   xxx
         return
;***************************************************************
;Rutinas para el uso de display 7 segmentos �nodo y c�todo com�n
;***************************************************************
DisplayCatodoComun
        addwf   PCL,1
        retlw   0X3F        ;N�mero 0
        retlw   0X06        ;N�mero 1
        retlw   0X5B        ;N�mero 2
        retlw   0X4F        ;N�mero 3
        retlw   0X66        ;N�mero 4
        retlw   0X6D        ;N�mero 5
        retlw   0X7D        ;N�mero 6
        retlw   0X07        ;N�mero 7
        retlw   0X7F        ;N�mero 8
        retlw   0X6F        ;N�mero 9
DisplayAnodoComun
        addwf   PCL,1
        retlw   0X40        ;N�mero 0
        retlw   0X79        ;N�mero 1
        retlw   0X24        ;N�mero 2
        retlw   0X30        ;N�mero 3
        retlw   0X19        ;N�mero 4
        retlw   0X12        ;N�mero 5
        retlw   0X02        ;N�mero 6
        retlw   0X78        ;N�mero 7
        retlw   0X00        ;N�mero 8
        retlw   0X10        ;N�mero 9
      
;*************************************************************
t0		    equ	0x82	;constante para generar aprox. 25ms
t4.6ms		equ	0x06*4	;constante para generar 4,6ms
t15.4ms		equ	0x14*4	;constante para generar 15,4ms
t200us		equ	0x01	;constante para generar aprox. 200us

;*************************************************************
retardo:
	clrf	contador_1		;aclara contador1
ret	decfsz	contador_1,F	
	goto 	ret
	decfsz	contador_2,F
	goto	ret
	return	

ret50ms:					;RETARDO 50 ms
	movlw	t0		
	movwf	contador_2
	call 	retardo
	call	retardo
	return

ret100ms:					;RETARDO 100 ms
	call	ret50ms		
	call	ret50ms
	return

ret300ms:					;RETARDO 300 ms
	call	ret100ms
	call 	ret100ms
	call	ret100ms
	return

ret600ms:					;RETARDO 600 ms
	call	ret300ms
	call	ret300ms
	return












