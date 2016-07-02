**** PROGRAMA: ARCHDELE.PRG
** LA FUNCION DELETED()
CLEAR
USE func
GOTO 3
DELETE
GOTO 10
DELETE NEXT 4
GOTO TOP
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, DELETED()
   SKIP
ENDDO
INKEY(0)