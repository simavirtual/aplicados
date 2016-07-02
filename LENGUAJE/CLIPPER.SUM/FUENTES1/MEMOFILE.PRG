*  NOMBRE DEL ARCHIVO: MEMOFILE.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/15/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
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
	 @23,10 SAY "SOLO PUEDE LEER ARCHIVOS TXT "
	 INKEY(2)
	 LOOP
      ENDIF
   ENDIF

  texto = MEMOREAD(arq)
  @ 9, 9 TO 21,61
  texto = MEMOEDIT(texto,10,10,20,60,.T.)
ENDDO