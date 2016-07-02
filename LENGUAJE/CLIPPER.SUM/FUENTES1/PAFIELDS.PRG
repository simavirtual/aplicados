**** ARCHIVO: PAFIELDS.PRG
CLEAR
archivo = "FUNC"
USE (archivo)
t = FCOUNT()
PRIVATE mnom[t], mtip[t], mtam[t], mdec[t]
AFIELDS(mnom,mtip,mtam,mdec)
? "     Estructura del archivo ",(archivo)+".DBF"
? "============================================="
? "Nombre     Tipo     Tama¤o    Decimales"
? "============================================="
FOR i = 1 TO LEN(mnom)
    ? PADR(mnom[i],11),mtip[i],mtam[i],mdec[i]
NEXT
INKEY(0)
USE
