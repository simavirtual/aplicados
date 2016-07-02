**** ARCHIVO: ARCHSKIP.PRG
CLEAR
USE func
l := 11; c :=6
@10,5,17,76 BOX REPL(" ",9)
@10,5 TO 17,76 DOUBLE
DO WHILE .NOT. EOF()        //  Mientras no llegue al fin de archivo
   @l,c    SAY codfunc
   @l,c+7  SAY nomefunc
   @l,c+43 SAY salario PICT "@E999,999.99"
   @l,c+55 SAY dataent PICT "@E"
   l++
   IF l > 16
      @17,16 SAY " Presione <Enter> para ver el proximo registro "
      tecla = INKEY(0)
      IF tecla = 27
         EXIT
      ENDIF
      SCROLL(11,06,16,75,1)
      l = 16
   ENDIF
   SKIP                    // Avanza un registro
ENDDO