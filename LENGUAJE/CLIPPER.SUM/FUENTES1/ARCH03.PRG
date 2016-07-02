**** PROGRAMA ARCH03.PRG
USE func
DO WHILE .T.
   CLEAR
   @11,09,21,60 BOX REPL(CHR(219),8)
   mcod = SPACE(3)
   @13,10 SAY "CODIGO....: " GET mcod
   READ
   IF VAL(mcod)=0
      EXIT
   ENDIF
   ***************************************
   LOCATE FOR codfunc = mcod
   ***************************************
   IF EOF()
      @23,10 SAY "CODIGO NO ENCONTRADO.."
      INKEY(2)
      @23,10 SAY SPACE(60)
      LOOP
   ENDIF

   @13,35 SAY "ADMISION..: "+DTOC(dataent)
   @15,10 SAY "NOMBRE....: "+nomefunc
   @17,10 SAY "SECCION...: "+codset
   @17,40 SAY "CARGO.....: "+codcar
   @19,10 SAY "SALARIO...: "
   @19,23 SAY salario PICT "@E999,999.99"
   @19,40 SAY "ASOCIADO.: "+IF(gremio,"SI","NO")
   @21,16 SAY "Teclee <espacio> para terminar consulta"
   INKEY(0)
ENDDO
CLEAR