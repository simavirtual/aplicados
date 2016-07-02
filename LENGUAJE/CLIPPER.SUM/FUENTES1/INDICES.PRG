**** PROGRAMA: INDICAMD.PRG
** INDIZACION POR CAMPOS DE TIPOS DIFERENTES
USE func
INDEX ON codset+DTOC(dataent) TO indsetda
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ?RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

**** ARCHIVO: INDICAMI.PRG
** INDIZACION POR CAMPOS DE TIPOS IGUALES
USE func
INDEX ON codset+nomefunc TO indsetno
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ?RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
SKIP
ENDDO
INKEY(0)

**** PROGRAMA: INDIDECR.PRG
** INDIZACION EN ORDEN DESCENDENTE DE CAMPO NUMERICO
CLEAR
USE func
INDEX ON -salario TO saldec
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

**** PROGRAMA: INDIDESC.PRG
** INDIZANDO EN ORDEN DESCENDENTE  - CAMPO DE CARACTERES
USE func
INDEX ON -ASC(nomefunc) TO indnodes
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ?RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

**** ARCHIVO: INDIFECD.PRG
** INDIZACION EN ORDEN DESCENDENTE  - CAMPO DE FECHA
USE func
INDEX ON (CTOD("31/12/99")-dataent) TO inddades
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ?RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

**** PROGRAMA: INDIFECH.PRG
** INDIZACION POR LA FECHA DE ENTRADA
USE func
INDEX ON dataent TO inddat
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

**** PROGRAMA: ARCHIVO: INDILOGI.PRG
** INDIZACION POR CAMPOS LOGICOS
USE func
INDEX ON IIF(gremio,"A","B") TO indgrem

GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ?RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

**** ARCHIVO: INDINOMB.PRG
** INDIZACION POR EL NOMBRE
USE func
INDEX ON nomefunc TO indnome
INDEX ON LEFT(nomefunc,15) TO indnalt
GOTO TOP
CLEAR
DO WHILE .NOT. EOF()
   ? RECNO(), codfunc, PADL(nomefunc,30), salario, gremio, dataent, codset
   SKIP
ENDDO
INKEY(0)

******************************************
** OTROS INDICES USADOS EN LOS EJEMPLOS **

*USE func
*INDEX ON codfunc TO indcod

*USE func
*INDEX ON codset+STR(salario,9,2) TO indsetsa

*USE func
*INDEX ON codset+codcar TO setcar

*USE cargos
*INDEX ON codcar TO indcodcar

*USE setores
*INDEX ON codset TO indcodse

*USE cargos
*INDEX ON codcar TO indcar

*USE setores
*INDEX ON codset TO indset

*USE func
*INDEX ON nomefunc TO indnome