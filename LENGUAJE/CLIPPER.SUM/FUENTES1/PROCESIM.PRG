**** PROGRAMA: PROCESIM.PRG
USE func NEW
USE cargos NEW
USE setores NEW
CLEAR
@0,0,MAXROW(),MAXCOL() BOX REPL(CHR(176),9)

A->(muestrastru())
cargos->(muestrastru())
muestrastru()

PROCEDURE muestrastru
SAVE SCREEN
DECLARE nombres[FCOUNT()]
AFIELDS(nombres)
@0,64,0+LEN(nombres)+1,78 BOX REPL(CHR(219),8)+" "
a = ACHOICE(1,65,1+LEN(nombres),77,nombres)
RESTORE SCREEN