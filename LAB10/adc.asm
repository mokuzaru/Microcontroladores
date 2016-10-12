cblock 
RegADC1
RegADC2
endc
;----------------------------------------------------------------
;Inicialización del conversor ADC
;tiempo de conversión Tad=1.6
;Selección de canal
;Código para guardar en el ADCON0
;b'10000001'  ;canal0
;b'10001001'  ;canal1
;b'10010001'  ;canal2
;b'10011001'  ;canal3
;b'10100001'  ;canal4
;b'10101001'  ;canal5
;b'10110001'  ;canal6
;b'10111001'  ;canal7  
Inicio_ADC
    movwf RegADC1
    rlf   RegADC1
    rlf   RegADC1
    rlf   RegADC1,0
    andlw b'00111000'
    iorlw b'10000001'
    movwf ADCON0    ;Tad=1.6 /CHX
    return    
;----------------------------------------------------------------
;rutina de conversión ADC 8bits
ADC8Bits
    movlw  .1
    call   Milisegundo
    bsf    ADCON0,GO ;GO=1 --> empieza conversión
    btfss  ADCON0,GO ;Espera que finalice conversión
    goto   $-1   
    movf   ADRESH,0  ;Saco el valor de conversión binaria (8bits)
    movwf  RegADC1   ;Guardo dato en el RegADC
    return
ADC10Bits
    movlw  .1 
    call   Milisegundo
    bsf    ADCON0,GO ;GO=1 --> empieza conversión
    btfss  ADCON0,GO ;Espera que finalice conversión
    goto   $-1   
    bsf    STATUS,RP0
    rlf    ADRESL
    rlf    ADRESL
    rlf    ADRESL
    movf   ADRESL,0
    bcf    STATUS,RP0
    andlw  b'00000011'
    movwf  RegADC1
    movf   ADRESH,0
    movwf  RegADC2
    rlf    ADRESH
    rlf    ADRESH
    movf   ADRESH,0
    andlw  b'11111100'
    iorwf  RegADC1
    rlf    RegADC2
    rlf    RegADC2
    rlf    RegADC2,0
    andlw  b'00000011'
    movwf  RegADC2
    return   
;----------------------------------------------------------------