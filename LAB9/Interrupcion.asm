;**************************************************************
;==============================================================
;Rutina de interrupciones
;Hecho por: Ing. Carlos Enrique Mendiola Mogoll�n
;Empresa: Electronic-digital(CM)
;E-mail: Electronic_digital20@hotmail.com
;Direcci�n Web:www.electronic-digital.blogspot.com
;==============================================================
;**************************************************************
cblock
endc
;--------------------------------------------------------------
;Interrupci�n de TMR0 de 1ms aproximadamente.
;Para iniciar interrupci�n:
;call InicioIntTMR0
InicioIntTMR0
    banco 1
    mover OPTION_REG,b'11010110'  ;PreDivisor x128/Temporizador
    bsf   INTCON,T0IE   ;Interrupcion TMR0 ON 
    bsf   INTCON,GIE    ;Interrupcion global ON
    banco 0
    bcf   INTCON,T0IF
    mover TMR0,.217     ;t=(0.2u)(256-TMR0)(PreDivisor)=0.998ms
    segundo .1
    return
;Para Finalizar interrupci�n:
;call FinIntTMR0
;retfie
FinIntTMR0
    bcf   INTCON,T0IF    ;Flag desborde OFF
    mover TMR0,.217
    return
;---------------------------------------------------------------

;---------------------------------------------------------------