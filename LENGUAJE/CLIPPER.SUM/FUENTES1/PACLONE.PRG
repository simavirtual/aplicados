**** PROGRAMA: PACLONE.PRG
** Ejemplo de ACLONE()
LOCAL C[7]
a := {100,200,300,{10,20,30,40,50},400,{60,70,80},500}
b := ACLONE(a)
ACOPY(a,c)
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
?? "Contenido de B"
?
FOR i = 1 TO LEN(B)
 IF VALTYPE(B[i]) = "A"
  FOR j = 1 TO LEN(B[i])
   ?? B[i,j]
  NEXT
 ELSE
   ?? B[i]
 ENDIF
 ?
NEXT
?? "Contenido de C"
?
FOR i = 1 TO LEN(B)
 IF VALTYPE(C[i]) = "A"
  FOR j = 1 TO LEN(C[i])
   ?? C[i,j]
  NEXT
 ELSE
   ?? C[i]
 ENDIF
 ?
NEXT
INKEY(0)
CLEAR
? "Modificaion del valor de A[4,3] a 1000 y de A[1] a 2000"
A[4,3] = 1000
A[1] = 2000
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
?? "Contenido de B"
?
FOR i = 1 TO LEN(B)
 IF VALTYPE(B[i]) = "A"
  FOR j = 1 TO LEN(B[i])
   ?? B[i,j]
  NEXT
 ELSE
   ?? B[i]
 ENDIF
 ?
NEXT
?? "Contenido de C"
?
FOR i = 1 TO LEN(B)
 IF VALTYPE(C[i]) = "A"
  FOR j = 1 TO LEN(C[i])
   ?? C[i,j]
  NEXT
 ELSE
   ?? C[i]
 ENDIF
 ?
NEXT
?? INKEY(0)