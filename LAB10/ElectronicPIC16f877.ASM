cblock	                	
Cont_1        
Cont_2        
Cont_3        
Cont_4        
contador_1	
contador_2	             
endc
;***************************************************************
;Rutinas para generación de retardos
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
;Rutinas para el uso de display 7 segmentos ánodo y cátodo común
;***************************************************************
DisplayCatodoComun
        addwf   PCL,1
        retlw   0X3F        ;Número 0
        retlw   0X06        ;Número 1
        retlw   0X5B        ;Número 2
        retlw   0X4F        ;Número 3
        retlw   0X66        ;Número 4
        retlw   0X6D        ;Número 5
        retlw   0X7D        ;Número 6
        retlw   0X07        ;Número 7
        retlw   0X7F        ;Número 8
        retlw   0X6F        ;Número 9
DisplayAnodoComun
        addwf   PCL,1
        retlw   0X40        ;Número 0
        retlw   0X79        ;Número 1
        retlw   0X24        ;Número 2
        retlw   0X30        ;Número 3
        retlw   0X19        ;Número 4
        retlw   0X12        ;Número 5
        retlw   0X02        ;Número 6
        retlw   0X78        ;Número 7
        retlw   0X00        ;Número 8
        retlw   0X10        ;Número 9
      
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












