**** ARCHIVO: PROCEDIM.PRG
USE func NEW
USE cargos NEW
USE setores NEW
CLEAR
@0,0,MAXROW(),MAXCOL() BOX REPL(CHR(176),9)

muestrastru("func")
muestrastru("setores")
muestrastru()

PROCEDURE muestrastru(archivo)
SAVE SCREEN
IF PCOUNT() = 1
   archactu = ALIAS()
   SELE &archivo
ENDIF
DECLARE nombres[FCOUNT()]
AFIELDS(nombres)
@0,64,11,78 BOX REPL(CHR(219),8)+" "
a = ACHOICE(1,65,10,77,nombres)
IF PCOUN() = 1
   SELE &archactu
ENDIF
RESTORE SCREEN