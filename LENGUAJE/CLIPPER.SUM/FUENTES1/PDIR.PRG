**** PROGRAMA: PDIR.PRG
DO WHILE .T.
   CLEAR
   tipo = SPACE(12)
   @ 1, 1 SAY "Digite el tipo de archivo a listar : " GET tipo
   READ
   IF UPPER(tipo) = "FIN"
      EXIT
   ENDIF
   PRIVATE ARQ[ADIR("&tipo.")]
   ADIR("&tipo.",ARQ)
   qtd = LEN(ARQ)
   @ 2, 1 SAY "Directorio con: "+ STR(qtd,4)+" archivos"
   linhas = (qtd/5+1)
   IF linhas > 20
      linhas = 20
   ENDIF
   y = 1
   @ 0, 0 TO linhas+4,76 DOUBLE
   FOR i = 1 TO linhas+1
       FOR x = 1 TO 5
           IF y <= 100 .AND. y <= qtd
              @i+3,x*15-14 SAY ARQ[y]
              y++
           ELSEIF y < qtd
              DO WHILE y <= qtd
		 @24,16 SAY " Presione una tecla para continuar... "
                 SCROLL(4,1,linhas+3,75,1)
                 INKEY(0)
                 FOR w = 1 TO 5
                     IF y <= qtd
                        @23,w*15-14 SAY ARQ[y]
                     ENDIF
                     y++
                 NEXT w
              ENDDO
           ENDIF
       NEXT
   NEXT
   INKEY(0)
ENDDO