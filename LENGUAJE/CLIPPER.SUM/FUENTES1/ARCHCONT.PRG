**** ARCHIVO: ARCHCONT.PRG
USE func
c := 6
DO WHILE .T.
   l = 11
   CLEAR
   @10,5 TO 17,66 DOUBLE
   mset = SPACE(1)
   @08,c SAY "DIGITE LA SECCION..: " GET mset PICT "@A!"
   READ
   IF mset = SPACE(1)
      EXIT
   ENDIF
   LOCATE FOR codset = mset
   IF EOF()
      @l+2,c+10 SAY "NO HAY FUNCIONARIOS EN ESA SECCION"
      INKEY(3)
      LOOP
   ENDIF
   DO WHILE .NOT. EOF()        // Mientras no llegue a fin de archivo
      @l,c    SAY codfunc
      @l,c+7  SAY nomefunc
      @l,c+43 SAY salario PICT "@E999,999.99"
      @l,c+55 SAY codset
      l++
      IF l > 16
         @17,25 SAY "PRESIONE <Enter> PARA VER EL PROXIMO REGISTRO "
         tecla = INKEY(0)
         IF tecla = 27
            EXIT
         ENDIF
         SCROLL(11,06,16,75,1)
         l = 16
      ENDIF
      CONTINUE                // Avanza al pr¢ximo registro que satisface la
                              // condici¢n del comando LOCATE o hasta el fin
                              // de archivo si no existen mas.
   ENDDO
   @17,c+10 SAY "Presione una tecla para continuar.."
   INKEY(0)
ENDDO