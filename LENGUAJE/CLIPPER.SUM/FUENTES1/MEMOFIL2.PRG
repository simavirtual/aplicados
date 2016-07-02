*  NOMBRE DEL ARCHIVO: MEMOFIL2.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/15/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
SET SCOREBOARD OFF
CLEAR
DO WHILE .T.
   arq = SPACE(12)
   @ 1, 1 SAY "ARCHIVO A EDITAR :" GET arq
   READ
   IF UPPER(arq) = "FIN"
      EXIT
   ENDIF

   pos = RAT(".",arq)
   IF pos = 0
      arq = TRIM(arq)+".TXT"
   ENDIF
   IF .NOT. FILE("&arq")
      @23,10 SAY "ARCHIVO INEXISTENTE..."
      INKEY(2)
      LOOP
   ELSE
      pos = RAT(".",arq)
      IF SUBSTR(arq,pos+1,3) <> UPPER("TXT")
	 @23,10 SAY "SOLO PUEDE LEER ARCHIVOS TXT"
	 INKEY(2)
	 LOOP
      ENDIF
   ENDIF
   texedit = MEMOREAD(arq)
   @ 9, 9 TO 21,66
   texedit = MEMOEDIT(texedit,10,10,20,65,.T.,"jr_udf")
   IF LASTKEY() = 23                   && Crtl W
      @23,10 SAY "Grabando el archivo &arq."
      IF .NOT. MEMOWRIT(arq,texedit)
	 @ 23,10 SAY ".......ARCHIVO &arq. NO GRABADO..."
      ENDIF
      INKEY(2)
      @23,10 SAY SPACE(60)
   ENDIF
   @ 9, 9 CLEAR TO 22,66
ENDDO


FUNCTION jr_udf
PARAMETERS mode, line, col
retval = 0
DO CASE
   CASE mode = 0
	@22,11 SAY line PICTURE "Linea: 99999"
	@22,35 SAY col PICTURE "Columna: 99999"
	@22,51 SAY IF(READINSERT(),"<ins>","     ")
   CASE mode = 1 .OR. mode = 2
	IF LASTKEY() = 27               && Esc
	   @23,10 SAY "Abandonando la edici¢n"
	   @23,10 SAY INKEY(2)
	   @23,10 SAY SPACE(60)
	ENDIF
   CASE mode = 3
	READINSERT(.T.)
	@22,51 SAY IF(READINSERT(),"<ins>","     ")
ENDCASE
RETURN(retval)