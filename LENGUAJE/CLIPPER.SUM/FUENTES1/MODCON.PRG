* NOMBRE DEL ARCHIVO: MODCON.PRG
* POR: JOSE ANTONIO RAMALHO
* NOTA:
* FECHA: 02/21/91
* DESC:
* LLAMADO POR:
* ARCHIVOS DE DATOS:
LOCAL op
@02,42 SAY procname()
SAVE SCREEN
DO WHILE .T.
   menu = {{"ORDENADO POR FECHA/CLIENTE ","Informe ordenado por fecha vencimiento/cliente  "},;
	   {"ORDENADO POR CLIENTE/FECHA ","Informe ordenado por cliente/fecha vencimiento  "},;
	   {"FACTURAS ATRASADAS         ","Relacion de atrasos hasta la fecha dada         "},;
	   {"RESUMEN DEL FLUJO          ","Lista de totales por dia vencido/a vencer       "},;
	   {"RELACION DE CLIENTES       ","Lista clasificada por nombre o codigo           "},;
	   {"CONSULTA/CLIENTE           ","Consulta resumida por cliente/vencimiento       "},;
	   {"CONSULTA/FECHA             ","Consulta resumida total por fecha de vencimiento"},;
	   {"REGRESA                    ","Regresa al menu anterior"}}
   montamenu(10,13,menu)
   menu TO op
   telavelha = SAVESCREEN(04,01,21,79)
   DO CASE
      CASE op = 1
	   DO datacliente
      CASE op = 2
	   DO clientedata
      CASE op = 3
	   DO tituatras
      CASE op = 4
	   DO fluxosin
      CASE op = 5
	   DO relcli
      CASE op = 6
	   DO conclidat
      CASE op = 7
	   DO condatcli
      CASE op = 8
	   RESTORE SCREEN
	   RETURN
   ENDCASE
ENDDO


PROCEDURE conclidat
PRIVATE mcodcli := SPACE(4), ddataini, ddatafim, filtro := ""
IF .NOT. abrearq("clientes","indcodcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
IF .NOT. abrearq("faturas","indcldat")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
DO WHILE .T.
   mcodcli = SPACE(4); ddataini := ddatafim := CTOD("")
   quadro(06,03,14,45,03)
   @07,05 SAY "CODIGO DEL CLIENTE:"
   @08,05 SAY "XXXX = TODOS"
   @07,26 GET mcodcli PICTURE "@N!"
   READ
   IF VAL(mcodcli) = 0 .AND. mcodcli <> "XXXX"
      CLOSE ALL
      EXIT
   ENDIF
   IF mcodcli <> "XXXX"
      SEEK mcodcli
      IF FOUND()
	 @08,05 SAY clientes->nomecli
	 unico = .T.
      ELSE
         LOOP
      ENDIF
      filtro = "codcli = mcodcli"
   ELSE
      filtro = ""
   ENDIF
   @10,05 SAY "FECHA INICIAL.:" GET ddataini
   @11,05 SAY "FECHA FINAL...:" GET ddatafim;
   VALID ddatafim >= ddataini
   READ
   IF ddataini <> CTOD("") .AND. ddatafim <> CTOD("")
      IF LEN(filtro) > 1
	 filtro = filtro+" .AND. vencimento >= ddataini .AND. vencimento <= ddatafim"
      ELSE
	 filtro = "vencimento >= ddataini .AND. vencimento <= ddatafim"
      ENDIF
   ENDIF
   IF LEN(filtro) > 1
      SET FILTER TO &filtro.
   ENDIF
   quadro(06,02,20,77,03)
   campos := {"codcli","clientes->(LEFT(nomecli,18))","codfat",;
	       "vr_nominal","vencimento","pagamento","vr_nominal-vr_pago"}
   matpic := {"","","","@E 9,999,999.99","","","@E 9,999,999.99"}
   mattit := {"CODIGO","NOMBRE DEL CLIENTE","FACTURA","VALOR",;
	      "VENCIMIENTO","FECHA PAGO","SALDO"}
   dbedit(07,03,19,76,campos,,matpic,mattit)
   GOTO TOP
ENDDO
RESTSCREEN(04,01,21,79,telavelha)



PROCEDURE condatcli
IF .NOT. abrearq("clientes","indcodcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
IF .NOT. abrearq("faturas","inddatcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
SELECT clientes
DO WHILE .T.
   mcodcli = SPACE(4)
   mcodcli := SPACE(4); ddataini := CTOD(""); ddatafim := CTOD("")
   quadro(06,03,14,45,03)
   @07,05 SAY "FECHA INICIAL.:" GET ddataini
   @08,05 SAY "FECHA FINAL...:" GET ddatafim
   READ
   IF LASTKEY() = 27
      RESTSCREEN(04,01,21,79,telavelha)
      CLOSE ALL
      RETURN
   ENDIF
   DO CASE
      CASE ddataini = CTOD("") .AND. ddatafim = CTOD("")
	   testadata = 0
      CASE ddataini <> CTOD("") .AND. ddatafim = CTOD("")
	   testadata = 1
      CASE ddataini = CTOD("") .AND. ddatafim <> CTOD("")
	   testadata = 2
      CASE ddataini <> CTOD("") .AND. ddatafim <> CTOD("")
	   testadata = 3
   ENDCASE
   SELECT clientes
   achou = .F.
   DO WHILE .NOT. achou
      @10,05 SAY "CODIGO DEL CLIENTE :"
      @11,05 SAY "XXXX = TODOS"
      @10,26 GET mcodcli PICTURE "@N!"
      READ
      IF mcodcli <> "XXXX"
         SEEK mcodcli
         IF FOUND()
	    @11,05 SAY clientes->nomecli
	    unico = .T.
	    achou = .T.
         ELSE
            LOOP
         ENDIF
      ELSE
	 unico = .F.
         EXIT
      ENDIF
   ENDDO
   SELECT faturas
   GOTO TOP
   quadro(06,02,19,77,3)
   @06,03 SAY "CODIGO"
   @06,19 SAY "NOMBRE"
   @06,32 SAY "FACTURA"
   @06,41 SAY "VENCIMIENTO"
   @06,57 SAY "VALOR"
   @06,67 SAY "FECHA PAGO"
   i = 7
   DO WHILE .NOT. EOF()
      DO CASE
	 CASE pagamento <> CTOD("") .AND. vr_nominal = vr_pago
	      SKIP
	 CASE mcodcli <> "XXXX" .AND. codcli <> mcodcli
	      SKIP
	 CASE (testadata = 1 .OR. testadata = 3) .AND. vencimento < ddataini
	      SKIP
	 CASE (testadata = 2 .OR. testadata = 3) .AND. vencimento > ddatafim
	      SKIP
	 OTHERWISE
	      IF i = 19
		 mensagem(23,10,"Presione <Enter> para ver otros registros",0)
		 SCROLL(07,03,18,76,12)
		 i = 7
	      ENDIF
	      @i,04 SAY codcli +" "+CHR(179)
	      @i,10 SAY clientes->(LEFT(nomecli,20))+" "+CHR(179)
	      @i,33 SAY codfat +" "+CHR(179)
	      @i,43 SAY DTOC(vencimento)+" "+CHR(179)
	      @i,54 SAY vr_nominal PICTURE "@E 9,999,999.99"+CHR(179)
	      @i,68 SAY pagamento
	      SKIP
	      i++
      ENDCASE
   ENDDO
   mensagem(23,10,"Presione <Enter> para ver la proxima pantalla",0)
ENDDO
INKEY(0)
RESTSCREEN(04,01,21,79,telavelha)


PROCEDURE fluxosin
IF .NOT. abrearq("faturas","inddatcl")
   RETURN
ENDIF
@23,10 SAY "Imprimiendo resumen del fujo de caja...espere"
listaflu()


PROCEDURE listaflu
p = 0; lin = 61; totdata := totger := 0
titulo = "RESUMEN DEL FLUJO DE VENCIMIENTOS"
nr = "CR-003"
compvenc = vencimento
SET DEVICE TO PRINTER
pago = "pagamento = CTOD('')"
pagparcial = "pagamento <> CTOD('') .AND. vr_nominal <> vr_pago"
DO WHILE .NOT. EOF() .AND. (&pago .OR. &pagparcial)
   IF lin > 60
      cabecger(titulo,nr)
      cabecflu()
   ENDIF
   detalheflu()
ENDDO
totalfluxo()
final()
SET DEVICE TO SCREEN
mensagem(23,10,"Final del reporte de clientes",2)



PROCEDURE cabecflu
@04,10 SAY "FECHA DE VENCIMIENTO                       SALDO"
@05,00 SAY REPLICATE("=",80)
lin = 7
RETURN

PROCEDURE detalheflu
IF compvenc <> vencimento
   @lin  ,14 SAY compvenc PICTURE 'DD/DD/DD'
   @lin  ,23 SAY REPLICATE(".",23)
   @lin++,46 SAY totdata PICTURE '999,999,999.99'
   compvenc = vencimento
   IF &pagparcial
      totger += vr_nominal - vr_pago; totdata = vr_nominal - vr_pago

   ELSE
      totger += vr_nominal; totdata = vr_nominal

   ENDIF
ELSE
   IF &pagparcial
      totger += vr_nominal -vr_pago; totdata += vr_nominal - vr_pago

   ELSE
      totger += vr_nominal; totdata += vr_nominal

   ENDIF
ENDIF
SKIP
RETURN

PROCEDURE totalfluxo
@lin  ,14 SAY compvenc
@lin  ,23 SAY REPLICATE(".",23)
@lin  ,46 SAY totdata PICTURE '999,999,999.99'
@++lin,36 SAY "TOTAL....:"     // Aumenta valor de lin antes de imprimir
@lin++,46 SAY totger PICTURE '999,999,999.99'



PROCEDURE tituatras
IF .NOT.abrearq("clientes","indcodcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
IF .NOT.abrearq("faturas","inddatcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
SELECT clientes
DO WHILE .T.
   mcodcli := SPACE(4); dataref := CTOD("")
   quadro(06,03,14,45,3)
   @07,5 SAY "FECHA REFERENCIA.:" GET dataref
   READ
   IF LASTKEY() = 27
      RESTSCREEN(04,01,21,79,telavelha)
      CLOSE ALL
      RETURN
   ENDIF
   SELECT clientes
   achou = .F.
   DO WHILE .NOT. achou
      @10,05 SAY "CODIGO DEL CLIENTE:"
      @11,05 SAY "XXXX = TODOS"
      @10,26 GET mcodcli PICTURE "@N!"
      READ
      IF mcodcli <> "XXXX"
         SEEK mcodcli
         IF FOUND()
	    @11,05 SAY clientes->nomecli
	    unico = .T.
	    achou = .T.
         ELSE
            LOOP
         ENDIF
      ELSE
	 unico = .F.
         EXIT
      ENDIF
   ENDDO
   SELECT faturas
   GOTO TOP
   SET DEVICE TO PRINTER
   lin := 61; p := totger := totdia := 0; datacomp = CTOD(""); nr := "CR-005"
   DO WHILE .NOT. EOF()
      DO CASE
	 CASE pagamento = CTOD("") .AND. vencimento > dataref
	      SKIP
	 CASE pagamento <> CTOD("") .AND. vr_nominal = vr_pago
	      SKIP
	 CASE mcodcli <> "XXXX" .AND. codcli <> mcodcli
	      SKIP
	 OTHERWISE
	      listatras()
      ENDCASE
   ENDDO
   totalatras()
   final()
   SET DEVICE TO SCREEN
   mensagem(23,10,"Final del reporte de morosos",2)
ENDDO
RESTSCREEN(04,01,21,79,telavelha)


PROCEDURE listatras
IF lin > 60
   cabecger("RELACION DE FACTURAS ATRASADAS")
   cabecatr()
ENDIF
IF datacomp <> vencimento
   IF datacomp <> CTOD("")
      @lin  ,33 SAY "TOTAL....:"
      @lin++,43 SAY totdia PICTURE "@E 99,999,999.99"+" |"
   ENDIF
   @lin++,01 SAY "VENCIMENTO : "+DTOC(vencimento)
   datacomp = vencimento
   totdia = 0
ENDIF
@lin,04 SAY codcli +" |"
@lin,10 SAY clientes->(LEFT(nomecli,20))+" |"
@lin,33 SAY codfat +" |"
@lin,44 SAY vr_nominal PICTURE "@E 9,999,999.99"+" |"
IF pagamento <> CTOD("")
   @lin,57 SAY vr_pago PICTURE "@E 9,999,999.99"+" |"
ENDIF
totger += vr_nominal - vr_pago; totdia += vr_nominal - vr_pago
SKIP
lin++
RETURN

PROCEDURE cabecatr
@04,03 SAY "CODIGO"
@04,15 SAY "CLIENTE"
@04,33 SAY "FACTURA"
@04,50 SAY "VALOR"
@04,59 SAY "PAGO PARCIAL"
@05,00 SAY REPLICATE("=",80)
lin := 6
RETURN

PROCEDURE totalatras
@lin  ,33 SAY "TOTAL.....:"
@lin++,43 SAY totdia PICTURE "@E 99,999,999.99"
@++lin,33 SAY "T. GENERAL:"
@lin++,43 SAY totger PICTURE "@E 99,999,999.99"
RETURN


PROCEDURE datacliente
IF .NOT. abrearq("clientes","indcodcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
IF .NOT. abrearq("faturas","inddatcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
SELECT clientes
DO WHILE .T.
   mcodcli = SPACE(4)
   mcodcli := SPACE(4); ddataini := CTOD(""); ddatafim := CTOD("")
   quadro(06,03,14,45,03)
   @07,05 SAY "FECHA INICIAL.:" GET ddataini
   @08,05 SAY "FECHA FINAL...:" GET ddatafim
   READ
   IF LASTKEY() = 27
      RESTSCREEN(04,01,21,79,telavelha)
      CLOSE ALL
      RETURN
   ENDIF
   DO CASE
      CASE ddataini = CTOD("") .AND. ddatafim = CTOD("")
	   testadata = 0
      CASE ddataini <> CTOD("") .AND. ddatafim = CTOD("")
	   testadata = 1
      CASE ddataini = CTOD("") .AND. ddatafim <> CTOD("")
	   testadata = 2
      CASE ddataini <> CTOD("") .AND. ddatafim <> CTOD("")
	   testadata = 3
   ENDCASE
   SELECT clientes
   achou = .F.
   DO WHILE .NOT. achou
      @10,05 SAY "CODIGO DEL CLIENTE:"
      @11,05 SAY "XXXX = TODOS"
      @10,26 GET mcodcli PICTURE "@N!"
      READ
      IF mcodcli <> "XXXX"
         SEEK mcodcli
         IF FOUND()
	    @11,05 SAY clientes->nomecli
	    unico = .T.
	    achou = .T.
         ELSE
            LOOP
         ENDIF
      ELSE
	 unico = .F.
         EXIT
      ENDIF
   ENDDO
   SELECT faturas
   GOTO TOP
   SET DEVICE TO PRINTER
   lin := 61; p := totger := totdia := 0; datacomp = CTOD(""); nr := "CR-006"
   DO WHILE .NOT. EOF()
      DO CASE
	 CASE pagamento <> CTOD("") .AND. vr_nominal = vr_pago
	      SKIP
	 CASE mcodcli <> "XXXX" .AND. codcli <> mcodcli
	      SKIP
	 CASE (testadata = 1 .OR. testadata = 3) .AND. vencimento < ddataini
	      SKIP
	 CASE (testadata = 2 .OR. testadata = 3) .AND. vencimento > ddatafim
	      SKIP
	 OTHERWISE
	      listadatcl()
      ENDCASE
   ENDDO
   totalatras()
   final()
   SET DEVICE TO SCREEN
ENDDO
CLOSE ALL
mensagem(23,10,"FINAL DEL REPORTE DE FACTURAS POR VENCER",2)
RESTSCREEN(04,01,21,79,telavelha)



PROCEDURE listadatcl
IF lin > 60
   cabecger("RELACION DE TITULOS POR VENCER")
   cabecdatcl()
ENDIF
IF datacomp <> vencimento
   IF datacomp <> CTOD("")
      @lin  ,33 SAY "TOTAL....:"
      @lin++,43 SAY totdia PICTURE "@E 99,999,999.99"+" |"
   ENDIF
   @lin++,01 SAY "VENCIMIENTO: "+DTOC(vencimento)
   datacomp = vencimento
   totdia = 0
ENDIF
@lin,04 SAY codcli +" |"
@lin,10 SAY clientes->(LEFT(nomecli,20))+" |"
@lin,33 SAY codfat +" |"
@lin,44 SAY vr_nominal PICTURE "@E 9,999,999.99"+" |"
totger += vr_nominal; totdia += vr_nominal
SKIP
lin++
RETURN


PROCEDURE cabecdatcl
@04,03 SAY "CODIGO"
@04,19 SAY "NOMBRE"
@04,33 SAY "FACTURA"
@04,48 SAY "VALOR"
@05,00 SAY REPLICATE("=",79)
lin = 7
RETURN


PROCEDURE clientedata
PRIVATE mcodcli := SPACE(4), ddataini, ddatafim, filtro := ""
IF .NOT. abrearq("clientes","indcodcl")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
IF .NOT. abrearq("faturas","indcldat")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes

DO WHILE .T.
   mcodcli = SPACE(4); ddataini := ddatafim := CTOD("")
   quadro(06,03,14,45,03)
   @07,05 SAY "CODIGO DEL CLIENTE:"
   @08,05 SAY "XXXX = TODOS"
   @07,26 GET mcodcli PICTURE "@N!"
   READ
   IF VAL(mcodcli) = 0 .AND. mcodcli <> "XXXX"
      CLOSE ALL
      EXIT
   ENDIF
   IF mcodcli <> "XXXX"
      SEEK mcodcli
      IF FOUND()
         @8,5 SAY clientes->nomecli
	 unico = .T.
      ELSE
         LOOP
      ENDIF
      filtro = "codcli = mcodcli"
   ELSE
      filtro = ""
   ENDIF
   @10,05 SAY "FECHA INICIAL.:" GET ddataini
   @11,05 SAY "FECHA FINAL...:" GET ddatafim;
   VALID ddatafim >= ddataini
   READ
   IF ddataini <> CTOD("") .AND. ddatafim <> CTOD("")
      IF LEN(filtro) > 1
	 filtro = filtro+" .AND. vencimento >= ddataini .AND. vencimento <= ddatafim"
      ELSE
	 filtro = "vencimento >= ddataini .AND. vencimento <= ddatafim"
      ENDIF
   ENDIF
   IF LEN(filtro) > 1
      SET FILTER TO &filtro.
   ENDIF
   lin := 61; p := totger := totdia := totcli := 0; compcliente = SPACE(4)
   nr = "CR-007"; compdata := CTOD("")
   GOTO TOP
   SET DEVICE TO PRINTER
   DO WHILE .NOT. EOF()
      listacliente()
   ENDDO
   totalcli()
   final()
   SET FILTER TO
   SET DEVICE TO SCREEN
ENDDO
CLOSE ALL
RESTSCREEN(04,01,21,79,telavelha)


PROCEDURE listacliente
IF lin > 60
   cabecger("RELACION DE FACTURAS POR VENCER = POR CLIENTE",nr)
   cabeccliente()
ENDIF
IF compdata <> vencimento .AND. compdata <> CTOD("")
   @lin  ,15 SAY "TOTAL DIA:"
   @lin++,29 SAY totdia PICTURE "@E 99,999,999.99"+" |"
   totdia := 0
ENDIF
IF compcliente <> codcli
   IF compcliente <> SPACE(4)
      @lin  ,15 SAY "TOTAL CLIENTE:"
      @lin++,29 SAY totcli PICTURE "@E 99,999,999.99"+" |"
   ENDIF
   @lin++,01 SAY "CLIENTE..: "+clientes->(nomecli)
   compcliente = codcli
   compdata = vencimento
   totcli = 0
ENDIF
@lin,04 SAY codcli +" |"
@lin,15 SAY codfat +" |"
@lin,30 SAY vr_nominal PICTURE "@E 9,999,999.99"+" |"
@lin,52 SAY DTOC(vencimento)+" |"
totger += vr_nominal; totcli += vr_nominal; totdia += vr_nominal
compcliente = codcli
compdata = vencimento
SKIP
lin++
RETURN

PROCEDURE cabeccliente
@04,03 SAY "CODIGO"
@04,15 SAY "FACTURA"
@04,35 SAY "VALOR"
@04,50 SAY "VENCIMIENTO"
@05,00 SAY REPLICATE("=",80)
lin := 6

PROCEDURE totalcli()
@lin  ,15 SAY "TOTAL DIA:"
@lin++,29 SAY totdia PICTURE "@E 99,999,999.99"+" |"
@lin  ,15 SAY "TOTAL CLIENTE:"
@lin++,29 SAY totcli PICTURE "@E 99,999,999.99"+" |"
@lin  ,15 SAY "TOTAL GENERAL:"
@lin++,29 SAY totger PICTURE "@E 99,999,999.99"+" |"




PROCEDURE cabecger(titulo,nr)
IF p > 0
   @lin,0 SAY REPLICATE("=",71)+nr
   EJECT
ENDIF
@01,00 SAY empresa
@01,64 SAY "PAGINA: "+STRZERO(++p,3)
@02,15 SAY titulo
@02,60 SAY DATE()
@02,70 SAY LEFT(time(),5)
@03,00 SAY REPLICATE("=",80)
RETURN

PROCEDURE final(tampag)
IF tampag = nil
   tampag = 65
ENDIF
pos = tampag - PROW()        // Numero de linea menos numero de linea actual
pos = 60 - pos               // Numero de columnas de la pagina (80) - 20 - pos
@lin,00 SAY REPLICATE("*",pos)
DO WHILE lin <= tampag - 3
   @lin++,pos++ SAY "*"
ENDDO
@lin,pos SAY REPLICATE("*",13) + nr
EJECT
RETURN

* Fin: MODCON.PRG