*  NOMBRE DEL ARCHIVO: DBEDIT2.PRG
*  POR: JOSE ANTONIO RAMALHO
*  NOTA: CAIXA POSTAL 62.574 CEP 01295 SAO PAULO
*  FECHA: 12/17/90
*  DESC:
*  LLAMADO POR :
*  ARCHIVOS DE DATOS:
*  PROGRAMA DBEDIT2.PRG

** Ejemplo 1
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
sepcol = CHR(178)

m3[5] = "@E"
m3[6] = "@E999,999.99"

m4[2] = "Nombres faltantes deben; buscarse en el DP"

l1 = 10
c1 = 10
l2 = 20
c2 = 60
@l1-1,c1-1 TO l2+1,c2+1 DOUBLE
DBEDIT(l1,c1,l2,c2,m1,"testatecla",m3,m2,sepcabe,sepcol,seproda,m4)
CLEAR
SET CURSOR ON



FUNCTION testatecla
PARAMETERS mode, counter
SET CURSOR OFF
DO CASE
   CASE mode = 0
	IF DELETED()
	   @23,70 SAY "ELIMINADO"
	ELSE
	   @23,70 SAY REPLICATE(" ",9)
	ENDIF
	RETURN(1)                              && Nada se modifico
   CASE mode = 1
	@23,55 SAY "INICIO DEL ARCHIVO"        && Se presiono PgUp o flecha
	INKEY(.5)                              && hacia arriba en un registro
	@23,55 SAY REPLICATE(" ",20)
	RETURN(1)
   CASE mode = 2                               && Se presiono PgDn o flecha
	@23,55 SAY "FIN DE ARCHIVO"            && hacia abajo al ultimo
	INKEY(.5)                              && registro
	@23,55 SAY REPLICATE(" ",20)
	RETURN(1)
   CASE mode = 3
	@23,10 SAY "ARCHIVO VACIO"
	INKEY(1)
	RETURN(0)
	** Verifica ultima tecla presionada
   CASE mode = 4
	DO CASE
	   CASE LASTKEY() = 27                 && Se presiono Esc
		RETURN(0)                      && Abandona DBEDIT()
	   CASE LASTKEY() = 13                 && Se presiono Enter, en este caso edita
		** remos el campo actual.
		campo = FIELDNAME(counter)
		IF TYPE("&campo") = "M"
		   memotela = SAVESCREEN(9,44,21,76)
		   moldura(9,44,21,76,.F.,"CAMPO MEMO")
		   REPLACE &campo WITH MEMOEDIT(&campo,10,45,20,75,.T.)
		   RESTSCREEN(9,44,21,76,memotela)
		ELSE
		   coled = COL()               && Obtiene columna actual
		   lined = ROW()               && Obtiene linea actual
		   @lined,coled GET &campo     && Edita el campo actual
		   SET CURSOR ON
		   READ
		   SET CURSOR OFF
		ENDIF
		KEYBOARD CHR(4)                && Mueve el cursor hacia la columna
		RETURN(1)                      && de la derecha con CHR(4) (->)
	   ENDCASE
   OTHERWISE
	RETURN(1)
ENDCASE




FUNCTION moldura
PARAMETERS topo, esq, dir, baixo, tipo, texto
IF PCOUNT() < 6
   @23,10 SAY "NUMERO DE PARAMETROS INVALIDO"
   RETURN(.F.)
ENDIF
IF tipo
   @topo,esq TO dir,baixo DOUBLE
ELSE
   @topo,esq TO dir,baixo
ENDIF
IF LEN(texto) > 0
   tam = baixo - esq
   novapos =(tam - LEN(texto))/2
   @topo,esq+novapos SAY texto
ENDIF
RETURN(.T.)