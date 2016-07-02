*  NOMBRE DEL ARCHIVO: ACHOICE3.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/16/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
*  Programa ACHOICE3.PRG
*  Usando ACHOICE() con UDF
USE func
INDEX ON nomefunc TO indnome

* Estructura base de datos : C:\CLIPPER5\FUNC.DBF
* Numero de registros      : 20
* Fecha ultima atualizacion: 21/10/90
* Campo  Nombre   Campo Tipo    Tamano  Dec    Indice
*    1  CODFUNC     Caracter       3               N
*    2  NOMEFUNC    Caracter      30               N
*    3  CODSET      Caracter       1               N
*    4  CODCAR      Caracter       1               N
*    5  DATAENT     Data           8               N
*    6  SALARIO     Numerico       9      2        N
*    7  GREMIO      Logico         1               N
*    8  COMENT      Memo          10               N
** Total **                       64

DECLARE m3[20]
FOR i = 1 TO 20
    m3[i] = nomefunc
    SKIP
NEXT

c1 = 02
l1 = 03
c2 = 20
l2 = 22
resp = 1
DO WHILE resp <> 0
   CLEAR
   @l1-1,c1-1 TO l2+1,c2+1
   resp = ACHOICE(l1,c1,l2,c2,m3,"","acfunc")
ENDDO
USE
CLEAR

FUNCTION acfunc
PARAMETERS modo, posat, posrel
ultecla = LASTKEY()
@ 2,30 SAY "MODO"
@ 3,30 SAY STR(modo,3)
@ 2,40 SAY "POS. ACTUAL"
@ 3,40 SAY STR(posat,3)
@ 2,50 SAY "POS. RELATIVA"
@ 3,50 SAY STR(posrel,3)

IF modo = 0
   RETURN(2)
ENDIF
IF modo = 1            && Se paso del inicio
   KEYBOARD CHR(30)
   RETURN(2)
ENDIF
IF modo = 2            && Se paso del final
   KEYBOARD CHR(31)
   RETURN(2)
ENDIF
IF modo = 3
   DO CASE
      CASE ultecla = 19
	   @ 1, 1 SAY "LA FLECHA IZQUIERDA NO ES VALIDA"
	   INKEY(3)
	   @ 1, 1 SAY SPACE(60)
	   RETURN(2)
      CASE ultecla = 4
	   @ 1, 1 SAY "LA FLECHA DERECHA NO ES VALIDA"
	   INKEY(3)
	   @ 1, 1 SAY SPACE(60)
	   RETURN(2)
   ENDCASE
ENDIF