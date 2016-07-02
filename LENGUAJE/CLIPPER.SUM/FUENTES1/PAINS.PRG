**** PROGRAMA: PAINS.PRG
** EJEMPLO DE AINS()
INKEY(0)
CLEAR
A := {"MARIA","MILENE","SELMA","LIGIA","NILDA","LUCIA"}
? "Tama¤o de A = ",LEN(A)
FOR i = 1 TO LEN(A)
    ? PADR(A[i],10),VALTYPE(A[i])
NEXT
?
? "Insercion de un elemento en la segunda posicion de A"
? "AINS(A,3)"
AINS(A,3)
?
? "Tama¤o de A = ",LEN(A)
FOR i = 1 TO LEN(A)
    ? PADR(A[i],10),VALTYPE(A[i])
NEXT
INKEY(0)

A := {100,200,300,{10,20,30,40,50},400,{60,70,80},500}
CLEAR
? "Contenido de A"
?
FOR i = 1 TO LEN(A)
    IF VALTYPE(A[i]) = "A"
       FOR j = 1 TO LEN(A[i])
           ?? A[i,j]
       NEXT
    ELSE
       ?? A[i]
    ENDIF
    ?
NEXT
?
? "Insercion de un elemento en la tercera posicion de A"
? "AINS(A,3)"
AINS(A,3)
?
? "Insercion de un elemento en la quinta posicion de A"
? "AINS(A,5)"
AINS(A,5)
?
? "Contenido de A"
?
FOR i = 1 TO LEN(A)
    IF VALTYPE(A[i]) = "A"
       FOR j = 1 TO LEN(A[i])
           ?? A[i,j]
       NEXT
    ELSE
       ?? A[i]
    ENDIF
    ?
NEXT
INKEY(0)