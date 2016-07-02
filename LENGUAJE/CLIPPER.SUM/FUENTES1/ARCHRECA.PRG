**** ARCHIVO: ARCHRECA.PRG
** RECUPERACION DE REGISTROS MARCADOS PARA ELIMINACION
CLEAR
USE func
RECALL RECORD 3
GOTO 12 
RECALL
GOTO TOP
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, DELETED()
   SKIP
ENDDO
INKEY(0)