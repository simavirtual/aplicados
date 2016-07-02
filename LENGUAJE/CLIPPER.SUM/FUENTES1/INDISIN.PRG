**** ARCHIVO: INDISIN.PRG
** SIN INDIZACION
USE func
CLEAR
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)