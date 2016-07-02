**** PROGRAMA: P_ASCAN.PRG
CLEAR
USE func
totreg = LASTREC()
m1 = {{},{},{}}
FOR i = 1 TO totreg
    AADD(m1[1],nomefunc); AADD(m1[2],salario); AADD(m1[3],dataent)
    SKIP
NEXT
CLEAR
? "Contenido de la matriz"
?
FOR i = 1 TO totreg
    ? m1[1,i], m1[2,i], m1[3,i]
NEXT
INKEY(0)
CLEAR
posini = 1
x = 1
DO WHILE x <> 0
   x = ASCAN(m1[2],{|z| (z > 50000 .AND. z < 100000)},posini)
   IF x = 0
      EXIT
   ELSE
      ? m1[1,x],m1[2,x]
      posini = x + 1
   ENDIF
ENDDO