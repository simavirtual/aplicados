**** ARCHIVO: ARCHFIND.PRG
CLEAR
USE func INDEX indcod
FIND 004
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
FIND "004"
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
FIND "040"
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()

**** ARCHIVO: ARCHFIN2.PRG
CLEAR
USE func INDEX indcod
FIND 004
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
FIND "004"
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
FIND "040"
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
? REPL("-",70)
cCOD = "004"
FIND cCOD
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()
FIND &cCOD
DISPLAY codfunc, nomefunc, EOF(), FOUND(), RECNO()