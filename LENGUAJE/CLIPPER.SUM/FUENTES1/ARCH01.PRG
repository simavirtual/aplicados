**** PROGRAMA: ARCH01.PRG
CLEAR
USE func
USE cargos NEW ALIAS ca
USE setores NEW ALIAS se
FOR i = 1 TO 3
    ? ALIAS(i)
NEXT
?
CLOSE ALL                   // Cierra todos los archivos abiertos
USE func
USE cargos NEW ALIAS ca
SELECT 6
USE setores ALIAS se
FOR i = 1 TO 6
    IF LEN(ALIAS(i)) > 0
       ? "Archivo ",ALIAS(i)," abierto en el area ",SELECT(ALIAS(i))
    ENDIF
NEXT