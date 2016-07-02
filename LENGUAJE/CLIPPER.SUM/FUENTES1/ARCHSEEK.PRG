**** PROGRAMA: ARCHSEEK.PRG
CLEAR
USE func INDEX indcod
SEEK 004
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
SEEK "004"
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
SEEK "040"
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
? REPL("-",70)
cCOD = "004"
SEEK cCOD
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
SEEK &cCOD
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
INKEY(0)