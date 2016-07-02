*  NOMBRE DEL ARCHIVO: MEMOGET1.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/15/90
*  DESC:
*  LLAMADO POR:
*  ARCHIVOS DE DATOS:
SET KEY -2 TO editamemo
USE func
INDEX ON codfunc TO indcod
* Estructura de la base de datos : C:\CLIPPER5\FUNC.DBF
* Numero de registros            : 20
* Fecha ultima de actualizacion  : 21/10/90
* Campo Nombre Campo  Tipo       Tamano   Dec    Indice
*    1  CODFUNC      Caracter       3               N
*    2  NOMEFUNC     Caracter      30               N
*    3  CODSET       Caracter       1               N
*    4  CODCAR       Caracter       1               N
*    5  DATAENT      Data           8               N
*    6  SALARIO      Num‚rico       9      2        N
*    7  GREMIO       L¢gico         1               N
*    8  COMENT       Memo          10               N
*** Total **                       64

DO WHILE .T.
   CLEAR
   mcod = SPACE(3)
   campomemo = "memo"
   @10,10 SAY "1. Codigo..: " GET mcod
   READ
   IF VAL(mcod) = 0
      EXIT
   ENDIF
   SEEK mcod
   IF FOUND()
      mnome = nomefunc
   ELSE
      LOOP
   ENDIF
   @12,10 SAY "2. Nombre.: " GET mnome
   @14,10 SAY "3. Obs....: " GET campomemo
   READ
ENDDO


PROCEDURE editamemo
PARAMETERS pr, li, va
IF va = "CAMPOMEMO"
   SAVE SCREEN
   @13,39 TO 23,78 DOUBLE
   REPLACE coment WITH MEMOEDIT(coment,14,40,22,77,.T.)
   RESTORE SCREEN
ENDIF
** Si existe mas de un campo memo en el archivo basta adicionar
** opciones ELSEIF para ejecutar el REPLACE apropiado.
RETURN