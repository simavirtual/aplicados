*  NOMBRE DEL ARCHIVO: DBEDIT1.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/17/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
*  PROGRAMA DBEDIT1.PRG

** Ejemplo 1 uso normal
USE func
DBEDIT()
USE
CLEAR

** Ejemplo 2 limitando el espacio
USE func
DBEDIT(10,10,20,60)
CLEAR

** Ejemplo 3 enmarcando la ventana
l1 = 10
c1 = 10
l2 = 20
c2 = 60
@l1-1,c1-1 TO l2+1,c2+1 DOUBLE
DBEDIT(l1,c1,l2,c2)
CLEAR

** Ejemplo 4 especificando los nombres de los campos
USE func
DECLARE m1[FCOUNT()]
FOR i = 1 TO 4
    m1[i] = FIELDNAME(i)
NEXT

l1 = 10
c1 = 10
l2 = 20
c2 = 60
@l1-1,c1-1 TO l2+1,c2+1 DOUBLE
DBEDIT(l1,c1,l2,c2,m1)
CLEAR

** Ejemplo 5
USE func
DECLARE m1[FCOUNT()], m2[FCOUNT()]
FOR i = 1 TO LEN(m1)
    m1[i] = FIELDNAME(i)
NEXT
m2[1] = "Codigo"
m2[2] = "            Nombre"
m2[3] = "Seccion"
m2[4] = "Cargo"
m2[5] = "Admision"
m2[6] = "Salario"
m2[7] = "Gremio"
m2[8] = "Comentario"

l1 = 10
c1 = 10
l2 = 20
c2 = 60
@l1-1,c1-1 TO l2+1,c2+1 DOUBLE
DBEDIT(l1,c1,l2,c2,m1,"","",m2,"*")
CLEAR




** Ejemplo 6
USE func
DECLARE m1[FCOUNT()], m2[FCOUNT()], m3[FCOUNT()], m4[FCOUNT()]
FOR i = 1 TO LEN(m1)
    m1[i] = FIELDNAME(i)
NEXT
m2[1] = "Codigo"
m2[2] = "            Nombre"
m2[3] = "Seccion"
m2[4] = "Cargo"
m2[5] = "Admision"
m2[6] = "Salario"
m2[7] = "Gremio"
m2[8] = "Comentario"
sepcabe = "*"
seproda = "+"
sepcol  = CHR(178)

m3[5] = "@E"
m3[6] = "@E999,999.99"

m4[2] = "Nombres faltantes deben; buscarse en el DP"

l1 = 10
c1 = 10
l2 = 20
c2 = 60
@l1-1,c1-1 TO l2+1,c2+1 DOUBLE
DBEDIT(l1,c1,l2,c2,m1,"",m3,m2,sepcabe,sepcol,seproda,m4)
CLEAR