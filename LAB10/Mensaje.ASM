;*****************************************************
;Nombre de archivo:mensaje.asm
;Rutina para mandar cadena de mensajes al LCD
;Hecho por: Ing. Carlos Enrique Mendiola Mogollón
;Empresa: Electronic-digital (CM)
;E-mail: digitalcorel.com
;Dirección Web:www.electronic-digital.blogspot.com
;******************************************************
cblock 
OFFSET
ENVIAR_DATA
DATAX
COMPARADOR
endc
;----------------------------------------------  
;Mensajes a ser enviados, máximo 16 caracteres
TEXTO_1
    addwf  PCL,1
    DT     "Voltaje: ",0XFF
TEXTO_2
    addwf  PCL,1
    DT     "0",0XFF
TEXTO_3
    addwf  PCL,1
    DT     "1",0XFF
TEXTO_4
    addwf  PCL,1
    DT     "2",0XFF
TEXTO_5
    addwf  PCL,1
    DT     "3",0XFF
TEXTO_6
    addwf  PCL,1
    DT     "4",0XFF
TEXTO_7
    addwf  PCL,1
    DT     "5",0XFF
TEXTO_8
    addwf  PCL,1
    DT     "6",0XFF
TEXTO_9
    addwf  PCL,1
    DT     "7",0XFF
TEXTO_10
    addwf  PCL,1
    DT     "8",0XFF
TEXTO_11
    addwf  PCL,1
    DT     "9",0XFF
TEXTO_12
    addwf  PCL,1
    DT     "",0XFF
TEXTO_13
    addwf  PCL,1
    DT     "",0XFF
TEXTO_14
    addwf  PCL,1
    DT     "",0XFF
TEXTO_15
    addwf  PCL,1
    DT     "",0XFF
;--------------------------------------------------------------
;**************************************************************    
TEXT1  mover  DATAX,0
BRIN1  tabla  TEXTO_1,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA 
       incf   DATAX
       goto   BRIN1
TEXT2  mover  DATAX,0
BRIN2  tabla  TEXTO_2,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN2
TEXT3  mover  DATAX,0
BRIN3  tabla  TEXTO_3,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN3
TEXT4  mover  DATAX,0
BRIN4  tabla  TEXTO_4,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN4
TEXT5  mover  DATAX,.0
BRIN5  tabla  TEXTO_5,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN5
TEXT6  mover  DATAX,0
BRIN6  tabla  TEXTO_6,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
	   putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN6
TEXT7  mover  DATAX,0
BRIN7  tabla  TEXTO_7,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN7
TEXT8  mover  DATAX,0
BRIN8  tabla  TEXTO_8,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN8
TEXT9  mover  DATAX,0
BRIN9  tabla  TEXTO_9,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN9
TEXT10 mover  DATAX,0
BRIN10 tabla  TEXTO_10,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN10
TEXT11 mover  DATAX,0
BRIN11 tabla  TEXTO_11,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN11
TEXT12 mover  DATAX,0
BRIN12 tabla  TEXTO_12,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN12
TEXT13 mover  DATAX,0
BRIN13 tabla  TEXTO_13,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN13
TEXT14 mover  DATAX,0
BRIN14 tabla  TEXTO_14,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN14
TEXT15 mover  DATAX,0
BRIN15 tabla  TEXTO_15,DATAX,ENVIAR_DATA
       csi    ENVIAR_DATA,0XFF,SALIR
       putv   ENVIAR_DATA
       incf   DATAX
       goto   BRIN15 
SALIR
       return