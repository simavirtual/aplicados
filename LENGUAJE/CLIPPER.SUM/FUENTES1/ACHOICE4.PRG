*  NOMBRE DEL ARCHIVO: ACHOICE4.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/16/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
** Programa ACHOICE4.PRG
** Implantando una UDF con mejor control
USE func
INDEX ON nomefunc TO indnome

* Estructura base de dados : C:\CLIPPER5\FUNC.DBF
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
*  Total **                       64
DECLARE m3[20]
FOR i = 1 TO 20
    m3[i] = nomefunc
    SKIP
NEXT

SET COLOR TO w/n,w/n                           && Elimina el color "enhanced" (del cursor)
c1 = 02
l1 = 03
c2 = 20
l2 = 22
resp = 1
DO WHILE resp <> 0
   CLEAR
   @l1-1,c1-1 TO l2+1,c2+1
   KEYBOARD CHR(5)+CHR(24)                     && Flecha abajo y luego flecha arriba
   resp = ACHOICE(l1,c1,l2,c2,m3,"","acfunc",3)
ENDDO
USE


FUNCTION acfunc
PARAMETERS modo, posat, posrel
ultecla = LASTKEY()
@l1+posrel,c2+2 SAY CHR(17)
@ 2,30 SAY "MODO"
@ 3,30 SAY STR(modo,3)
@ 2,40 SAY "POS. ACTUAL"
@ 3,40 SAY STR(posat,3)
@ 2,50 SAY "POS. RELATIVA"
@ 3,50 SAY STR(posrel,3)
IF modo = 0
   volta = 2
ENDIF
IF modo = 1                                    && Se paso del inicio
   KEYBOARD CHR(30)
   volta = 2
ENDIF
IF modo = 2                                    && Se paso del final
   KEYBOARD CHR(31)
   volta = 2
ENDIF
IF modo = 3
   DO CASE
      CASE ultecla = 19
	   @ 1, 1 SAY "FLECHA IZQUIERDA NO ES VALIDA"
	   INKEY(3)
	   @ 1, 1 SAY SPACE(60)
	   volta = 2
      CASE ultecla = 4
	   @ 1, 1 SAY "FLECHA DERECHA NO ES VALIDA"
	   INKEY(2)
	   @ 1, 1 SAY SPACE(60)
	   volta = 2
      CASE ultecla >= 65 .AND. ultecla <= 122  && Si se presiona una
	   volta = 3                           && letra se mueve el cursor
      OTHERWISE                                && hacia la primera
	   volta = 0     && otras teclas       && ocurrencia (item) que
			 && abortan la funcion && se inicie con esa letra

   ENDCASE
ENDIF
@l1,c2+2 CLEAR TO l2,c2+2                      && Borra una columna a la derecha de la
@l1+posrel,c2+2 SAY CHR(17)                    && ventana y muestra una flecha en la colum-
RETURN(volta)                                  && na al frente del elemento seleccionado.
