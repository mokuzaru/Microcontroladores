;ejemplo01

     list p=16f877a
     include<p16f877a.inc>
     include<macro16f877.inc>
__config 0x3f32
cblock 0x20
endc
     org    0000h
     goto   inicio
     org    0004h
     goto   interrupcion
inicio
     banco  1
     bcf    portb,0
     banco  0
     bcf    portb,0
     call   InicioIntTMR0
repite
     nop
     goto   repite

interrupcion
     bsf    portb,0
     segundo .1
     bcf    portb,0
     segundo .1
     call   FinIntTMR0
     retfie 
     
include<electronicpic16f877.asm>
include<interrupcion.asm>
end	