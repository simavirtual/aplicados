**** PROGRAMA: PROASIZE.PRG
?
a := {{10,20,30},{40,50,60},{70,80,90}}
? "CONTENIDO DE a"
?
FOR i = 1 TO LEN(a)
    FOR j = 1 TO LEN(a[1])
        ?? IF(a[i,j] = NIL,"NIL",a[i,j])
    NEXT
    ?
NEXT
? "TAMA¥O DE a ",LEN(a) 
?

ASIZE(a,5)
? "TAMA¥O DE a ",LEN(a)       // Retorna 5
a[4] := {100,110,120}
a[5] := {130}
? "TAMA¥O DE a[4] ",LEN(a[4])
ASIZE(a[1],4)                 // Aumenta en 1 elemento la linea 1
ASIZE(a[3],5)                 // Aumenta en 2 elementos la linea 3
ASIZE(a[5],7)                 // Aumenta en 6 elementos la linea 5
? "CONTENIDO DE a"
?
FOR i = 1 TO LEN(a)
    ? "LINEA ",STR(i,3)," "
    FOR j = 1 TO LEN(a[i])
        ?? IF(a[i,j] = NIL," NIL",a[i,j])
    NEXT
    ?
NEXT
?
? "ASIZE(a,2)"
ASIZE(a,2)                    // Reduce la primera dimension (lineas cambia a 2)
?
FOR i = 1 TO LEN(a)
    ? "LINEA ",STR(i,3)," "
    FOR j = 1 TO LEN(a[i])
        ?? IF(a[i,j] = NIL," NIL",a[i,j])
    NEXT
    ?
NEXT
ASIZE(a[1],2)                 // Reduce la segunda dimension (columnas de a[1] cambian a 2)
? "ASIZE(a[1],2)"
?
FOR i = 1 TO LEN(a)
    ? "LINEA ",STR(i,3)," "
    FOR j = 1 TO LEN(a[i])
        ?? IF(a[i,j] = NIL," NIL",a[i,j])
    NEXT
    ?
NEXT
INKEY(0)