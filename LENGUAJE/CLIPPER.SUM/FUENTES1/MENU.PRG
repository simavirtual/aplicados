* NOMBRE DEL ARCHIVO: MENU.PRG
* POR: JOSE ANTONIO RAMALHO
* NOTA:
* FECHA: 02/21/91
* DESC:
* LLAMADO POR:
* ARCHIVOS DE DATOS:
empresa = "MEGATRON ASESORIA Y ENTRENAMIENTO"
sistema = "CUENTAS POR COBRAR"
SET SCOREBOARD OFF
SET DATE BRITISH
SET WRAP ON
SET DELETED ON
SET MESSAGE TO 23 CENTER
SET KEY 28 TO ajuda
DO WHILE .T.
   telapadrao(PROCNAME())
   menu := {{"FACTURAS          ","Mantenimiento de facturas                 "},;
	    {"CLIENTES          ","Mantenimiento del archivo de clientes     "},;
	    {"CONSULTAS/INFORMES","Consultas en pantalla y informes          "},;
	    {"SERVICIOS         ","Rutinas de respaldo y reindizacion        "},;
	    {"F I N             ","Regresa al sistema operacional            "}}
   montamenu(6,5,menu)
   menu TO op

   DO CASE
      CASE op = 1
	   DO modfat
      CASE op = 2
	   DO modcli
      CASE op = 3
	   DO modcon
      CASE op = 4
	   DO moduti
      CASE op = 5
	   IF confirma("Abandonar el sistema ") = 1
	      EXIT
	   ENDIF
   ENDCASE
ENDDO


FUNCTION montamenu(ls,cs,menu)
LOCAL retangulo := CHR(213)+CHR(205)+CHR(184)+CHR(179)+;
      CHR(190)+CHR(205)+CHR(212)+CHR(179)+CHR(32)
@ls,cs,ls+LEN(menu)+1,cs+LEN(menu[1,1])+1 BOX retangulo
FOR i = 1 to LEN(menu)
    @ls+i,cs+1 PROMPT menu[i,1] MESSAGE menu[i,2]
NEXT
RETURN NIL

FUNCTION menumanut(ls,cs,nome)
tipo = nome
menu = {{"INCLUSION  ","Inclusion de &tipo.                         "},;
	{"ALTERACION ","Alteracion de &tipo.                        "},;
	{"CONSULTA   ","Consulta del arquivo de &tipo.              "},;
	{"EXCLUSION  ","Exclusion de registros de archivos de &tipo."},;
	{"F I N      ","Retorna al menu anterior                   "}}
montamenu(ls,cs,menu)
RETURN NIL


FUNCTION quadro(ls,cs,li,ci,tipo)
LOCAL q[6]
q[1] = CHR(201)+CHR(205)+CHR(187)+CHR(186)+;
       CHR(188)+CHR(205)+CHR(200)+CHR(186)+CHR(32)
q[2] = CHR(218)+CHR(196)+CHR(191)+CHR(179)+;
       CHR(217)+CHR(196)+CHR(192)+CHR(179)
q[3] = CHR(213)+CHR(205)+CHR(184)+CHR(179)+;
       CHR(190)+CHR(205)+CHR(212)+CHR(179)+CHR(32)
q[4] = CHR(214)+CHR(196)+CHR(183)+CHR(186)+;
       CHR(189)+CHR(196)+CHR(211)+CHR(186)
q[5] = CHR(220)+CHR(220)+CHR(220)+CHR(219)+;
       CHR(220)+CHR(220)+CHR(223)+CHR(219)
IF tipo >= 176 .AND. tipo <= 178 .OR. tipo = 219
   IF PCOUNT() = 6
      q[6] = REPLICATE(tipo,9)
   ELSE
      q[6] = REPLICATE(tipo,8)
   ENDIF
   tipo = 6
ENDIF
@ls,cs,li,ci BOX q[tipo]
RETURN NIL

FUNCTION moldura(topo,esq,dir,baixo,duplo,texto)
IF PCOUNT() < 6
   @23,10 SAY "Numero de parametros invalidos"
   RETURN(NIL)
ENDIF
IF duplo
   @topo,esq CLEAR TO dir,baixo
   @topo,esq TO dir,baixo DOUBLE
ELSE
   @topo,esq CLEAR TO dir,baixo
   @topo,esq TO dir,baixo
ENDIF
IF LEN(texto) > 0
   tam = baixo - esq
   novapos = (tam - LEN(texto))/2
   @topo,esq+novapos SAY texto
ENDIF
RETURN(NIL)


FUNCTION confirma(texto)
LOCAL les, ces, largjan, telavelha
largjan = LEN(texto) + 2
IF largjan < 16
   largjan = 16
ENDIF
ces = (80 - largjan)/2
les = 19
telavelha = SAVESCREEN(les,0,les+4,79)
corantig = SETCOLOR()
cornova = "W/B,N/W"
SET COLOR to &cornova
@les,ces CLEAR TO les+3,ces+largjan
@les,ces TO les+3,ces+largjan DOUBLE
@les+1,ces+2 SAY texto
coluna = (largjan - 9)/2
@les+2,ces+coluna PROMPT "Si"
@les+2,ces+coluna+6 PROMPT "No"
menu TO confirm
SET COLOR TO &corantig
RESTSCREEN(les,0,les+4,79,telavelha)
RETURN(confirm)


FUNCTION telapadrao(programa)
CLEAR
@00,00 TO 03,39 DOUBLE
@00,40 TO 03,79 DOUBLE
@04,00,21,79 BOX REPLICATE(CHR(176),9)
@04,00 TO 21,79
@22,00 TO 24,79 DOUBLE
@01,02 SAY empresa
@01,42 SAY sistema
@01,73 SAY LEFT(time(),5)
@02,42 SAY programa
@02,70 SAY DATE()
@23,02 SAY "MENSAJE:"
RETURN NIL


FUNCTION mensagem(ls,cs,texto,tempo)
@ls,cs SAY SPACE(60)
@ls,cs SAY texto
IF tempo <> NIL
   INKEY(tempo)
ELSE
   INKEY(0)
ENDIF
@ls,cs SAY SPACE(60)
RETURN NIL

FUNCTION abrearq(arq,ind1,ind2,ind3)
PRIVATE arquivo := arq, indice1 := ind1, indice2 := ind2, indice3 := ind3
IF .NOT. FILE("&arquivo..DBF")
   mensagem(23,10,"Archivo "+arquivo +" no encontrado..")
   RETURN(.F.)
ENDIF
IF indice1 = NIL
   USE &arquivo. NEW
ENDIF
IF indice3 <> NIL
   IF .NOT. FILE("&INDICE3..NTX")
      mensagem(23,10,"Archivo indice "+indice3+" no encontrado")
      mensagem(23,10,"Ejecutando la rutina de reindizacion...antes de continuar")
      IF confirma("Reindiza ahora?") = 1
         utireindex()
	 USE &arquivo. index &indice1., &indice2., &indice3. NEW
      ELSE
	 RETURN(.F.)
      ENDIF
   ELSE
      USE &arquivo. index &indice1., &indice2., &indice3. NEW
   ENDIF
   RETURN(.T.)
ENDIF
IF indice2 <> NIL
   IF .NOT. FILE("&INDICE2..NTX")
      mensagem(23,10,"Archivo indice "+indice2+" no encontrado")
      mensagem(23,10,"Ejecutar la rutina de reindizacion.. antes de continuar")
      IF confirma("Reindiza ahora?") = 1
         utireindex()
	 USE &arquivo. index &indice1., &indice2. NEW
      ELSE
	 RETURN(.F.)
      ENDIF
   ELSE
      USE &arquivo. index &indice1., &indice2. NEW
   ENDIF
   RETURN(.T.)
ENDIF
IF indice1 <> NIL
   IF .NOT. FILE("&INDICE1..NTX")
      mensagem(23,10,"Archivo indice "+indice1+" no encontrado")
      mensagem(23,10,"Ejecutar la rutina de reindizacion.. antes de contonuar")
      IF confirma("Reindiza ahora?") = 1
         utireindex()
	 USE &arquivo. INDEX &indice1. NEW
      ELSE
	 RETURN(.F.)
      ENDIF
   ELSE
      USE &arquivo. INDEX &indice1. NEW
   ENDIF
   RETURN(.T.)
ENDIF


PROCEDURE ajuda
IF .NOT. FILE("ajuda.txt")
   mensagem(23,10,"No se encuentra archivo de ayuda",1.5)
   mensagem(23,10,"Consulte el manual para resolver dudas",2)
   RETURN
ENDIF
SAVE SCREEN TO telahelp
moldura(04,01,21,79,.T.,"Texto de ayuda")
memoedit(memoread("ajuda.txt"),05,02,20,78,.F.)
RESTORE SCREEN FROM telahelp
RETURN

* Fin: MENU.PRG