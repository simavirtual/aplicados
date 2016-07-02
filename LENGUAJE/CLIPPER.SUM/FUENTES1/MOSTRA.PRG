* PROGRAMA: MOSTRA.PRG

showdir()

FUNCTION showdir
LOCAL showdirSCR := SAVESCREEN(00,00,24,79)
SET SCORE OFF
P = "C:\"+curdir("C")
P1 = P                 // Graba el directorio actual
DO WHILE .T.
   @00,00,24,79 BOX REPL(CHR(219),8)+CHR(176)
   SET COLOR TO W/N
   @01,02 TO 04,78
   @02,03,03,77 BOX REPL(" ",9)
   @02,03 SAY "Path :"
   @02,44 SAY "Alcance..."
   @06,04 TO 23,19 DOUBLE
   @07,05,22,18 BOX REPL(" ",9)
   SET COLOR TO W/N, N/W
   p = "C:\"+curdir("C")
   p = p + SPACE(30 - LEN(p))
   m = "*.*"
   m = m + SPACE(12 - LEN(m))
   @02,12 GET p PICTURE "@K40"
   READ
   IF LASTKEY() = 27
      RUN CD &p1
      EXIT
   ENDIF
   @02,54 GET m PICTURE "@K"
   READ
   RUN CD &p
   dir1 = {}; tot := 0
   diret1 = DIRECTORY(m)
   ASORT(diret1,,,{|a,b| a[1] < b[1]})
   AEVAL(diret1,{|arq| AADD(dir1,arq[1]),tot += arq[2]})
   @02,62 SAY LEN(dir1) PICT " 9999 Archivos"
   @03,62 SAY tot PICT "99,999,999 Bytes"
   KEYBOARD CHR(24)+CHR(5)
   opc = ACHOICE(07,05,22,18,dir1,.T.,"showfile")
ENDDO
CLEAR
RUN CD &p1
RESTSCREEN(00,00,24,79,showdirscr)
RETURN

FUNCTION showfile
PARAMETERS modo, elem, posi
DO CASE
   CASE modo = 0
	@03,03 say space(52)
	@03,03 SAY diret1[elem,1]
	@03,16 SAY diret1[elem,2] PICTURE "@ER 999,999 Bytes"
	@03,35 SAY diret1[elem,3]
	@03,45 SAY diret1[elem,4]
	@03,55 SAY diret1[elem,5]
	return(2)
   CASE modo=3
	DO CASE
	   CASE LASTKEY() = 27
		RETURN(0)
	   CASE LASTKEY() = 13
		telaedita := SAVESCREEN(8,07,23,76)
		SET CURSOR ON
		arq_novo = dir1[elem]
		IF diret1[elem,2] > (MEMORY(1) * 1024)
		   moldura(08,21,12,76,.F.,"A T E N C I O N")
		   @10,22 SAY "Memoria insuficiente para editar archivo"
		   @11,22 SAY "Presione algo para continuar.."
		   INKEY(3)
		   RESTSCREEN(08,07,23,76,telaedita)
		   RETURN(2)
		ENDIF
		moldura(08,07,23,76,.F.,"&arq_novo.")
		texto = MEMOREAD("&arq_novo.")
		edita = SUBS("&arq_novo.",AT(".","&arq_novo.")+1,3)
		IF edita <> "PRG" .AND. edita <> "TXT" .AND. editA <> "BAT"
		   texto = MEMOEDIT(texto,09,08,22,75,.F.,"",132)
		ELSE
		   texto = MEMOEDIT(texto,09,08,22,75,.T.,"",132)
		   ok_nota = confirma("Confirma la grabacion del archivo  &arq_novo. ")
		   IF ok_nota = 1
		      MEMOWRIT("&arq_novo.",texto)
		   ENDIF
		   SET CURSOR OFF
		ENDIF
		RESTSCREEN(8,07,23,76,telaedita)
		RETURN(2)
	ENDCASE
   OTHERWISE
       RETURN(2)
ENDCASE

FUNCTION confirma(texto)
largjan = LEN(texto) + 2
IF largjan < 16
   largjan = 16
ENDIF
ces = (80 - largjan)/2
les = 19
telavelha = SAVESCREEN(les,0,les+4,79)
corantig = SETCOLOR()
cornova = "W/B,N/W"
SET COLOR TO &cornova
@les,ces CLEAR TO les+3,ces+largjan
@les,ces TO les+3,ces+largjan DOUBLE
@les+1,ces+2 SAY texto
coluna = (largjan - 9)/2
@les+2,ces+coluna PROMPT "Si"
@les+2,ces+coluna+6 PROMPT "No"
MENU TO confirm
SET COLOR TO &corantin
RESTSCREEN(les,0,les+4,79,telavelha)
RETURN(confirm)


FUNCTION moldura(topo,esq,dir,baixo,duplo,texto)
IF PCOUNT() < 6
   @23,10 SAY "Numero de parametros invalidos"
   RETURN(.F.)
ENDIF
IF duplo
   @topo,esq TO dir,baixo DOUBLE
ELSE
   @ topo,esq TO dir,baixo
ENDIF
IF LEN(texto) > 0
   tam = baixo - esq
   novapos = (tam - LEN(texto))/2
   @ topo,esq+novapos SAY texto
ENDIF
RETURN(.T.)

* Fin: MOSTRA.PRG