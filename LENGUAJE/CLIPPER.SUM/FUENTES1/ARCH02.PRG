**** PROGRAMA: ARCH02.PRG
USE func
DO WHILE .T.
   CLEAR
   numreg = 0
   @09,09,11,60 BOX REPL(CHR(219),8)
   @10,10 SAY "NUMERO DE REGISTRO..:" GET numreg PICT "999"
   READ
   IF numreg = 0
      EXIT
   ENDIF
   IF numreg < 1 .OR. numreg > LASTREC()
      @23,10 SAY "NUMERO DE REGISTRO INVALIDO"
      INKEY(2)
      @23,10 SAY SPACE(60)
      LOOP
   ENDIF
   GOTO numreg
   @11,09,21,60 BOX REPL(CHR(219),8)
   @13,10 SAY "CODIGO....: "+codfunc
   @13,35 SAY "ADMISION..: "+DTOC(dataent)
   @15,10 SAY "NOMBRE....: "+nomefunc
   @17,10 SAY "SECCION...: "+codset
   @17,40 SAY "CARGO.....: "+codcar
   @19,10 SAY "SALARIO...:"
   @19,24 SAY salario PICT "@E999,999.99"
   @19,40 SAY "ASOCIADO.: "+IF(gremio,"SI","NO")
   @21,16 SAY "Teclee <espacio> para terminar consulta"
   INKEY(0)
ENDDO
CLEAR