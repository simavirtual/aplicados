**** PROGRAMA: PAEVAL.PRG
CLEAR
USE func
totreg = LASTREC()
m1 = {}
FOR i = 1 TO totreg
    AADD(m1,nomefunc)
    SKIP
NEXT
USE
CLEAR
? "Contenido de la matriz"
?
FOR i = 1 TO totreg
    ? m1[i]
NEXT
INKEY(0)

bl1 = {|nome| QOUT(UPPER(LEFT(nome,1))+LOWER(SUBS(nome,2)))}
AEVAL(m1,bl1,1,5)
INKEY(0)

** Parte 2
CLEAR
USE func
d := DIRECTORY("*.DBF")
t1 = 0
bl2 = {|d| QOUT(PADR(d[1],12),d[2]), t1 += d[2]}
AEVAL(d,bl2)
?
? "Espacio ocupado ",t1
INKEY(0)