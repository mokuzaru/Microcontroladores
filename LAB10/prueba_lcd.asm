;Aplicación - valores analógicos en lcd
list p=16f877a
include<p16f877a.inc>
include<macro16f877.inc>
__config	0x3f32
cblock	0x20				;Creamos todas las 

endc
org		0000h
call	Inicio_lcd

Repite
	borralcd				;Borra la pantalla lcd
	mensaje 1				;Muestra 'Voltaje:'

	goto	Repite				;Ir a repite

;Librerías
include<electronicpic16f877.asm>
include<lcd.asm>
include<mensaje.asm>
end	