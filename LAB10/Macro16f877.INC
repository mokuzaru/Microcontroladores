;======================================================
;Nombre de archivo:macro16f877.asm
;Hecho por: Ing. Carlos Enrique Mendiola Mogollón
;Empresa: Electronic-digital(CM)
;E-mail: digitalcorel@hotmail.com
;Dirección Web:www.electronic-digital.blogspot.com
;======================================================
porta   equ PORTA
portb   equ PORTB
portc   equ PORTC
portd   equ PORTD
porte   equ PORTE
trisb   equ TRISB
trisc   equ TRISC
trisd   equ TRISD
salida  equ 0
entrada equ 1
;......................................................
;******************************************************
;Operaciones con registros,datos y saltos
;......................................................
;******************************************************
;mover un número a registro
mover        macro   registro,literal
             movlw   literal
             movwf   registro
             endm
;mover el contenido del registro2 al registro1
movregistro  macro   registro1,registro2
             movf    registro2,0
             movwf   registro1
             endm
;compara el dato con el registro y salta si no es igual
csni         macro 	 registro,dato,direcc   
			 movlw	 dato
		     subwf	 registro,0
			 btfss	 STATUS,Z
			 goto	 direcc
			 endm   
;compara y salta si no es igual entre registros
csnir 	     macro	registro1,registro2,direcc
		     movf	registro2,0
	         subwf	registro1,0
	         btfss	STATUS,Z
	         goto	direcc
	         endm
;compara dato con registro y salta si es igual
csi          macro	registro,dato,direcc
			 movlw	dato
	         subwf	registro,0
	         btfsc	STATUS,Z
	         goto	direcc
	         endm
;compara entre registros y salta si son iguales
csir		 macro	registro1,registro2,direcc
			 movf	registro2,0
			 subwf	registro1,0
			 btfsc	STATUS,Z
			 goto	direcc
			 endm
;decrementa registro y compara con dato y salta si no es igual
dcsni		 macro	registro,dato,direcc
			 decf	registro,1
			 movlw	dato
		     subwf	registro,0
			 btfss	STATUS,Z
			 goto	direcc
			 endm
;decrementa registro y compara con dato y salta si es igual
dcsi		 macro	registro,dato,direcc
			 decf	registro,1
			 movlw	dato
			 subwf	registro,0
			 btfsc	STATUS,Z
			 goto	direcc
		     endm
;compara y salta si es menor
csme		 macro	registro,dato,direcc
			 movlw	dato
			 subwf	registro,0	; W = REGISTRO - W
			 btfss	STATUS,C	; ¿C='1'?
		 	 goto	direcc
			 endm
;compara y salta si es menor igual
csmei		 macro	registro,dato,direcc
		     movlw	dato
			 subwf	registro,0	; W = REGISTRO - W
			 btfss	STATUS,C	; ¿C='1'?
			 goto	direcc
			 btfsc	STATUS,Z	; ¿Z='0'?
			 goto	direcc
;compara y salta si no es menor
csnme		 macro	registro,dato,direcc
	   		 movlw	dato
			 subwf	registro,0	; W = REGISTRO - W
			 btfsc	STATUS,C	; ¿C='0'?
			 goto	direcc
			 endm
;compara y salta si es mayor o igual
csmai 		 macro	registro,dato,direcc
			 movlw	dato
			 subwf	registro,0	; W = REGISTRO - W
			 btfsc	STATUS,C	; ¿C='0'?
			 goto	direcc
			 endm
;Saltos
salta        macro  ETIQUETA
             movlw  HIGH    ETIQUETA
             movwf  PCLATH
             goto   ETIQUETA
             endm
;...............................................................
;***************************************************************
;Retardos
;...............................................................
;***************************************************************
milisegundo	 macro X
			 movlw X
			 call  Milisegundo
			 endm
segundo    	 macro X
			 movlw X
			 call  Segundo
			 endm
;...............................................................
;***************************************************************
;Para controlar la pantalla LCD 2x16
;...............................................................
;***************************************************************
;Inicializar la pantalla LCd
 InicioLcd macro 
           call  Inicio_lcd
           endm
;Para mandar caracter al LCD
 ponerc    macro ASCII
           movlw ASCII
           call  EnviaCarLCD
           endm
;Para mandar caracter contenido en un resgistro
 putv      macro REGISTRO
           movf  REGISTRO,0
           call  EnviaCarLCD
           endm
;Para activar y apagar el cursor del  LCD
 cursor    macro X
           if    X==1 
           movlw DISP_ON_CURSOR_BLINK
           call  EnviaCmdLCD
           endif
           if    X==0
           movlw DISP_ON_NOCURSOR
           call  EnviaCmdLCD
           endif
           if    X==2
           movlw CURSOR_LEFT
           call  EnviaCmdLCD
           endif
           if    X ==3
           movlw CURSOR_RIGHT
           call  EnviaCmdLCD
           endif
           endm
;Bajar a la segunda fila de la pantalla LCD
 enter     macro
           movlw DISP_LINEA2
           call  EnviaCmdLCD
           endm
;Borrar escritura LCD
 borralcd  macro
           movlw DISP_CLEAR
           call  EnviaCmdLCD
           endm
;Desplazar a la derecha
 desplazaderecha  macro  
               	  movlw  DISPLAY_RIGHT
               	  call   EnviaCmdLCD             
                  endm
;Desplazar a la izquierda
 desplazaizquierda  macro              
               		movlw  DISPLAY_LEFT
               		call   EnviaCmdLCD             
                 	endm
;Programación especial para el envio de cadenas
;de mensajes al LCD
tabla   macro  ETIQUETA,DIRECC,REGISTRO
        movf   DIRECC,0
        movwf  OFFSET
        movlw  HIGH   ETIQUETA
        movwf  PCLATH
        movlw  LOW    ETIQUETA
        addlw  .1
        addwf  OFFSET,0
        btfsc  STATUS,C
        incf   PCLATH
        movf   OFFSET,0
        call   ETIQUETA
        movwf  REGISTRO
        endm
mensaje macro  x
        if x==1
        call TEXT1
        endif
        if x==2
        call TEXT2
        endif
        if x==3
        call TEXT3
        endif
        if x==4
        call TEXT4
        endif
        if x==5
        call TEXT5
        endif
        if x==6
        call TEXT6
        endif
        if x==7
        call TEXT7
        endif
        if x==8
        call TEXT8
        endif
        if x==9
        call TEXT9
        endif
        if x==.10
        call TEXT10
        endif
        if x==.11
        call TEXT11
        endif
        if x==.12
        call TEXT12
        endif
        if x==.13
        call TEXT13
        endif
        if x==.14
        call TEXT14
        endif
        if x==.15
        call TEXT15
        endif   	   
        endm     
tab_digito   macro  ETIQUETA,DIRECC,REGISTRO
        movf   DIRECC,0
        movwf  OFFSET_X
        movlw  HIGH ETIQUETA
        movwf  PCLATH
        movlw  LOW ETIQUETA
        addlw  .1
        addwf  OFFSET_X,0
        btfsc  STATUS,C
        incf   PCLATH
        movf   OFFSET_X,0
        call   ETIQUETA
        movwf  REGISTRO
        endm
;Cambio de Banco y Páginas
banco	macro	x
	if x == 0
		bcf	STATUS,RP0
		bcf	STATUS,RP1
	endif
	if x == 1
		bsf	STATUS,RP0
		bcf	STATUS,RP1
	endif
	if x == 2
		bcf	STATUS,RP0
		bsf	STATUS,RP1
	endif
	if x == 3
		bsf	STATUS,RP0
		bsf	STATUS,RP1
	endif
	endm
;pagina
pagina	macro	x
	if x == 0
		bcf	PCLATH,3
		bcf	PCLATH,4
	endif
	if x == 1
		bsf	PCLATH,3
		bcf	PCLATH,4
	endif
	if x == 2
		bcf	PCLATH,3
		bsf	PCLATH,4
	endif
	if x == 3
		bsf	PCLATH,3
		bsf	PCLATH,4
	endif
	endm
;-----------------------------------------------
;Para interactuar con el RS232
InicioRS232  macro 
             call   RS232_Inicializa
             endm
;para interactuar con el teclado_proteus
InicioTeclado macro
              call  Inicio_TecladoLCD
              endm
;-----------------------------------------------





