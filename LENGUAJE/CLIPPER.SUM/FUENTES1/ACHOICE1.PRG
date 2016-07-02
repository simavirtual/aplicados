*  NOMBRE DEL ARCHIVO: ACHOICE1.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/16/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
*  ACHOICE1.PRG
*
** Ejemplo 1

CLEAR
DECLARE m1[20]
FOR i = 1 TO 20
    m1[i] = STRZERO(i,3)
NEXT
l1 = 1
c1 = 1
l2 = 24
c2 = 11
@l1-1,c1-1 TO l2+1,c2+1
resp = ACHOICE(l1,c1,l2,c2,m1)

@24,15 SAY "elemento seleccionado : --> "+STR(resp,3)
INKEY(0)

** Ejemplo 2 pantalla menor que la matriz (desplazamiento vertical)

c1 = 30
c2 = 40
l2 = 12

@l1-1,c1-1 TO l2+1,c2+1
resp = ACHOICE(l1,c1,l2,c2,m1)
@24,15 SAY "elemento seleccionado : --> "+STR(resp,3)

** Ejemplo 3 uso de matriz secundaria para inhibicion de items

DECLARE m2[20]
AFILL(m2,.T.)
m2[3]  = .F.
m2[7]  = .F.
m2[18] = .F.

c1 = 45
c2 = 55
l2 = 22

@l1-1,c1-1 TO l2+1,c2+1
resp = ACHOICE(l1,c1,l2,c2,m1,m2)
@24,15 SAY "elemento seleccionado : --> "+STR(resp,3)
INKEY(0)

** Ejemplo 4 uso de ACHOICE() para mostrar un campo de una
**           base de datos (columna mas angosta que el texto)

USE func
INDEX ON nomefunc TO indnome

* Estructura base de datos  : C:\CLIPPER5\FUNC.DBF
* Numero de registros       : 20
* Fecha ultima actualizacion: 21/10/90
* Campo  Nombre    Campo Tipo    Tama¤o  Dec    Indice
*    1   CODFUNC     Caracter       3               N
*    2   NOMEFUNC    Caracter      30               N
*    3   CODSET      Caracter       1               N
*    4   CODCAR      Caracter       1               N
*    5   DATAENT     Data           8               N
*    6   SALARIO     Numerico       9      2        N
*    7   GREMIO      Logico         1               N
*    8   COMENT      Memo          10               N
** Total **                        64

DECLARE m3[20]
FOR i = 1 TO 20
    m3[i] = nomefunc
    SKIP
NEXT

c1 = 01
l1 = 01
c2 = 20
l2 = 22
CLEAR

@l1-1,c1-1 TO l2+1,c2+1
resp = ACHOICE(l1,c1,l2,c2,m3)
@ 24,15 SAY "elemento seleccionado : --> "+STR(resp,3)
INKEY(0)
USE


** Ejemplo 5 uso de ACHOICE() para mostrar un campo de un
**           archivo y permitir la seleccion de un registro con
**           exhibicion posterior de los datos del registro correspondiente

USE func
DECLARE m3[20], m4[20]
FOR i = 1 TO 20
    m3[i] = nomefunc
    m4[i] = RECNO()
     SKIP
NEXT

c1 = 01
l1 = 01
c2 = 30
l2 = 22
CLEAR

DO WHILE .T.
   @l1-1,c1-1 TO l2+1,c2+1
   resp = ACHOICE(l1,c1,l2,c2,m3)
   IF resp = 0
      EXIT
   ENDIF

   GOTO m4[resp]

   @01,35 TO 10,79 DOUBLE
   @03,36 SAY "Nombre..: " + nomefunc
   @05,36 SAY "Seccion.: " + codset
   @05,51 SAY "Cargo...: " + codcar
   @07,36 SAY "Admision: " + DTOC(dataent)
   @09,36 SAY "Salario.: " + TRANSFORM(salario,"999,999.99")
   @12,35 SAY "Presione algo para continuar.."
   INKEY(0)
   @01,35 CLEAR TO 12,79
ENDDO

CLEAR