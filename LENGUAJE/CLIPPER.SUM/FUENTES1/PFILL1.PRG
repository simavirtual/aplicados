**** PROGRAMA: PFILL1.PRG
tam = 3000
PRIVATE m[tam]
inicio = TIME()
FOR i = 1 TO tam
    m[i] = 0
NEXT
fin = TIME()
? ELAPTIME(inicio,fin)