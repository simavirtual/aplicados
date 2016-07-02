**** PROGRAMA: PDBSTRU.PRG
CLEAR
archivo = "FUNC"
USE (archivo)
m1 = DBSTRUCT()
? "    Estructura del archivo ",(archivo)+".DBF"
? "============================================="
? "Nombre     Tipo     Tama¤o    Decimales"
? "============================================="
FOR i = 1 TO LEN(m1)
    ? PADR(m1[i,1],11),m1[i,2],m1[i,3],m1[i,4]
NEXT
INKEY(0)
USE