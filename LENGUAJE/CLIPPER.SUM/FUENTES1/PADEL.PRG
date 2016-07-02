**** PROGRAMA: PADEL.PRG
CLEAR
A := {"MARIA","MILENE","SELMA","LIGIA","NILDA","LUCIA"}
? "El tama¤o de A = ",LEN(A)
FOR i = 1 TO LEN(A)
    ? PADR(A[i],10),VALTYPE(A[i])
NEXT
?
? "Eliminado el tercer elemento de A"
? "ADEL(A,3)"
ADEL(A,3)
?
? "El tama¤o de A = ",LEN(A)
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
? "Eliminado el tercer elemento de A"
? "ADEL(A,3)"
ADEL(A,3)
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
NEXT