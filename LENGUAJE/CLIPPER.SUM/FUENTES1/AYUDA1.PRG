**** PROGRAMA: AYUDA1.PRG
SET KEY -1 TO ajuda
DO WHILE .T.
   cod = SPACE(3); nome = SPACE(30); valor = 0
   ocupacao = SPACE(3); coment1 :=  coment2 := SPACE(60)
   CLEAR
   @10,10 SAY "CODIGO..." GET cod
   @12,10 SAY "NOMBRE..." GET nome
   @14,10 SAY "SALARIO.." GET valor
   READ
   IF LASTKEY() = 27
      EXIT
   ENDIF
   CLEAR
   @10,10 SAY "OCUPACION..." GET ocupacao
   @12,10 SAY "COMENTARIO.." GET coment1
   @14,10 SAY "            " GET coment2
   READ
ENDDO

PROCEDURE AJUDA(prog,linha,var)
telahelp = SAVESCREEN(10,40,14,60)
@10,40 CLEAR TO 14,60
@10,40 TO 14,60
@11,41 SAY "PROGRAMA "+prog
@12,41 SAY "LINEA "+STR(linha,3)
@13,41 SAY "VARIABLE "+var
INKEY(0)
RESTSCREEN(10,40,14,60,telahelp)