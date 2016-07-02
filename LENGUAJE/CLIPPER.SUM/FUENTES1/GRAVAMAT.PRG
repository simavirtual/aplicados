**** PROGRAMA: GRAVAMAT.PRG
SET DATE BRIT
elem = 10
PRIVATE m[elem]

** Inicaliza elementos con fechas

datab = DATE() - 1
FOR i = 1 TO elem
    datab = datab + 1
    m[i] = datab
NEXT

FOR i = 1 TO LEN(m)
    ind = STR(i,3)
    IF SUBS(ind,2,1) = " "
       ind = "00"+SUBS(ind,3,1)
     ELSE
       IF SUBS(ind,1) = " "
          ind = "0"+SUBS(ind,2,2)
       ENDIF
    ENDIF
    m&ind = m[i]
NEXT

arqmem = "m.mat"
SAVE TO &arqmem
RELEASE ALL LIKE ^^*