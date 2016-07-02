**** PROGRAMA: AYUDA3.PRG
SET KEY 28 TO ajuda
DO WHILE .T.
   cod = SPACE(3); nome = SPACE(30); valor = 0; nasc = CTOD("")
   ocupacao = SPACE(3); coment1 := coment2 := SPACE(60)
   CLEAR
   controle = 1
   @10,10 SAY "CODIGO..." GET cod
   @12,10 SAY "NOMBRE..." GET nome
   @14,10 SAY "SALARIO.." GET valor
   READ

   IF LASTKEY() = 27
      EXIT
   ENDIF
   CLEAR

   controle = 2
   @10,10 SAY "OCUPACION..." GET ocupacao
   @12,10 SAY "COMENTARIO.." GET coment1
   @14,10 SAY "            " GET coment2
   READ
ENDDO

PROCEDURE ajuda(prog,linha,var)
telahelp = SAVESCREEN(11,40,17,73)
@11,40 CLEAR TO 17,73
@11,40 TO 17,73
DO CASE
   CASE controle = 1
	@13,47 SAY "ESTA AYUDA PERTENCE A"
	@14,47 SAY "LA  PRIMERA  PANTALLA"
	@15,47 SAY "    DEL  PROGRAMA"
        INKEY(0)
   CASE controle = 2
	@12,49 SAY " A T E N C I O N"
        @14,41 SAY "ESTA AYUDA PERTENCE A LA SEGUNDA"
        @15,41 SAY "    PANTALLA DEL PROGRAMA"
        INKEY(0)
ENDCASE
RESTSCREEN(11,40,17,73,telahelp)