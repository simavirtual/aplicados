**** PROGRAMA: PDIRECT.PRG
SET SCORE OFF
DO WHILE .T.
   CLEAR
   @00,00 TO 04,76 DOUBLE
   tipo = SPACE(20)
   atributo = SPACE(1)
   @01,01 SAY "Digite directorio/Tipo de archivo a listar:" GET tipo
   READ
   IF UPPER(tipo) = "FIN"
      EXIT
   ENDIF
   @02,01 SAY "Archivos: (N)ormales, (H)idden, (D)irectorios, (S)ystem, (V)olumen";
   GET atributo PICT "!" VALID atributo $ "NHDSV"
   READ
   IF atributo = "S"
      M1 = DIRECTORY("&tipo")
   ELSE
      M1 = DIRECTORY("&tipo","&atributo")
   ENDIF
   qtd = LEN(M1)
   @ 3, 1 SAY "Directorio con : "+ STR(qtd,4)+" archivos"
   IF qtd > 19
      linhas = 19
   ELSE
      linhas = qtd
   ENDIF
   y = 1
   @ 4, 0 TO linhas+5,76 DOUBLE
   l = 5
   FOR y = 1 TO qtd
       IF l > linhas+4
	  @linhas+5,16 SAY " Presione una tecla para la siguiente pantalla... "
          INKEY(0)
          @ 5, 1 CLEAR TO linhas+4,75
          l = 5
       ENDIF
       @ l,01 SAY M1[y,1]
       @ l,15 SAY M1[y,2]
       @ l,30 SAY M1[y,3]
       @ l,45 SAY M1[y,4]
       @ l,60 SAY M1[y,5]
       l = l + 1
   NEXT
   @linhas+5,16 SAY "         Presione una tecla para continuar...     "
   INKEY(0)
ENDDO