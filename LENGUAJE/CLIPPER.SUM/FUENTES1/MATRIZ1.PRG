**** PROGRAMA: MATRIZ1.PRG

STATIC  d[5]        && Los comandos STATIC y LOCAL deben ir antes
LOCAL   e[5]        && de cualquier otro comando dentro de una
DECLARE a[5]        && PROCEDURE, funci¢n o programa
PRIVATE b[5]
PUBLIC  c[5]

CLEAR
? TYPE("a")

FOR i = 1 TO 5
    ? a[i], " ", b[i], " ", c[i], " ", d[i], " ", e[i]
NEXT
?
STORE "020" TO a[2], e[3]
e[1] = "RAMALHO"
AFILL(c,"010")
FOR i = 1 TO 5
    ? a[i], " ", b[i], " ", c[i], " ", d[i], " ", e[i]
NEXT
?
WAIT "Presione una tecla para terminar..."