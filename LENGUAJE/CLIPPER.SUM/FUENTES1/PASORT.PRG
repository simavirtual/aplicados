**** PROGRAMA: PASORT.PRG
CLEAR
PRIVATE a[5]
a[1] = "ZULU"
a[2] = "ANTONIO"
a[3] = "RENATO"
a[4] = "BERNARDO"
a[5] = "MARCO"

c := b := ACLONE(a)

ASORT(b,3)       // Ordena la matriz a partir del tercer elemento
FOR i = 1 TO 5
    ? b[i]
NEXT
                 // Retorna ZULU, ANTONIO, BERNARDO, MARCO, RENATO
?
ASORT(b)         // Ordena la matriz completa
FOR i = 1 TO 5
    ? b[i]
NEXT
                 // Retorna ANTONIO, BERNARDO, MARCO, RENATO, ZULU
** Ordenacion descendente
ASORT(c,,,{|x,y| x > y})

** En este ejemplo un CODE BLOCK retorna .T. s¢lo si
** el primer argumento es mayor que el segundo
** la matriz se procesa hasta que sea retornando .T.
** para todos los elementos.
?
FOR i = 1 TO 5
    ? b[i]
NEXT
                 // Retorna  ZULU, RENATO, MARCO, BERNARDO, ANTONIO
INKEY(0)
CLEAR

** Ordenaci¢n de submatrices

a = ARRAY(3,3)
a[1,1] = "MILENE"
a[1,2] = "VILMA LENE"
a[1,3] = "MELANIE"

a[2,1] = 300
a[2,2] = 200
a[2,3] = 100

a[3,1] = CTOD("10/10/87")
a[3,2] = CTOD("08/08/89")
a[3,3] = CTOD("12/01/88")

? "Contenido original de a"
?
?
FOR i = 1 TO 3
    FOR j = 1 TO 3
	?? IF(VALTYPE(a[i,j]) = "N",STR(a[i,j],8),a[i,j]),"  "
    NEXT
    ?
NEXT

** Ordenaci¢n por la primera dimensi¢n
? "Ordenado por la primera linea"
?
ASORT(a[1])
?
FOR i = 1 TO 3
    FOR j = 1 TO 3
        ?? IF(VALTYPE(a[i,j]) = "N",STR(a[i,j],8),a[i,j]),"  "
    NEXT
    ?
NEXT

** Ordenaci¢n por la tercera dimensi¢n
? "Ordenado por la tercera linea"
?
ASORT(a[3])
?
FOR i = 1 TO 3
    FOR j = 1 TO 3
        ?? IF(VALTYPE(a[i,j]) = "N",STR(a[i,j],8),a[i,j]),"  "
    NEXT
    ?
NEXT
INKEY(0)
CLEAR