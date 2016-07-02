**** PROGRAMA: AYUDA4.PRG
SET KEY 28 TO ajuda
DO WHILE .T.
   COD = SPACE(3); NOME = SPACE(30); VALOR = 0
   OCUPACAO = SPACE(3); COMENT1 := COMENT2 := SPACE(60)
   CLEAR
   controle = 1
   @10,10 SAY "CODIGO..." GET COD
   @12,10 SAY "NOMBRE..." GET NOME
   @14,10 SAY "SALARIO.." GET VALOR
   READ
   IF LASTKEY() = 27
      EXIT
   ENDIF
   CLEAR
   controle = 2
   @10,10 SAY "OCUPACION..." GET OCUPACAO
   @12,10 SAY "COMENTARIO.." GET COMENT1
   @14,10 SAY "            " GET COMENT2
   READ
ENDDO

PROCEDURE ajuda(prog,linha,var)
telahelp = SAVESCREEN(11,40,17,73)
@11,40 CLEAR TO 17,73
@11,40 TO 17,73
DO CASE
   CASE var = "COD"
	@13,41 SAY " El codigo debe estar compuesto"
	@14,41 SAY "     por tres digitos y no"
	@15,41 SAY "     puede contener espacios"
        INKEY(0)
   CASE var = "VALOR"
        @13,41 SAY " Escriba el valor pagado hasta"
	@14,41 SAY "     antes de la salida"
        INKEY(0)
   CASE var = "COMENT1" .OR. var = "COMENT2"
	@13,42 SAY "Campo destinado a comentarios"
	@14,42 SAY "diversos sobre el funcionario"
        INKEY(0)
   OTHERWISE
	@13,43 SAY "NO EXISTE AYUDA ESPECIFICA"
	@14,43 SAY "    PARA ESTA VARIABLE"
	@15,43 SAY "EN CASO DE DUDA CONSULTE CON"
	@16,43 SAY "  EL CENTRO DE INFORMACION"
        INKEY(0)
ENDCASE
RESTSCREEN(11,40,17,73,telahelp)