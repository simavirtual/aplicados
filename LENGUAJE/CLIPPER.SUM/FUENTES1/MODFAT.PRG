* NOMBRE DEL ARCHIVO: MODFAT.PRG
* POR: JOSE ANTONIO RAMALHO
* NOTA:
* FECHA:02/21/91
* DESC:
* LLAMADO POR:
* ARCHIVOS DE DATOS:
LOCAL op
SAVE SCREEN
DO WHILE .T.
   @02,42 SAY procname()
   menu = {{"ABONOS     ","Cancela la factura total o parcialmente    "},;
	   {"INCLUSION  ","Inclusion de facturas                      "},;
	   {"ALTERACION ","Alteracion de campos                       "},;
	   {"CONSULTA   ","Consulta del archivo de facturas           "},;
	   {"EXCLUSION  ","Exclusion de registros del archivo         "},;
	   {"F I N      ","Regresa al menu anterior                   "}}
   montamenu(08,13,menu)
   menu TO op
   telavelha = SAVESCREEN(04,01,21,79)
   publvar()
   DO CASE
      CASE op = 1
	   DO baifat
      CASE op = 2
	   DO incfat
      CASE op = 3
	   DO altfat
      CASE op = 4
	   DO confat
      CASE op = 5
	   DO excfat
      CASE op = 6
	   relevar()
	   RETURN
	   RESTORE SCREEN
   ENDCASE
ENDDO


PROCEDURE incfat
IF .NOT. abrearq("clientes","indcodcl")
   RETURN
ENDIF
IF .NOT. abrearq("faturas","indcodfa","indcldat","inddatcl")
   RETURN
ENDIF
DO WHILE .T.
   publvar()
   inicvar()
   mostratexto()
   pesquisa()
   IF VAL(mcodfat) = 0
      EXIT
   ENDIF
   IF .NOT. FOUND()
      getvar()
      READ
   ELSE
      mensagem(23,10,"Factura ya registrada")
      LOOP
   ENDIF
   IF confirma("Graba este registro? ") = 1
      APPEND BLANK
      replvar()
   ELSE
      LOOP
   ENDIF
ENDDO
CLOSE ALL
voltatela()
relevar()
RETURN

PROCEDURE altfat
IF .NOT. abrearq("clientes","indcodcl")
   RETURN
ENDIF
IF .NOT. abrearq("faturas","indcodfa","indcldat","inddatcl")
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodfat) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      mostravar()
      getvar()
      READ
   ELSE
      mensagem(23,10,"Factura no registrada             ")
      LOOP
   ENDIF
   IF confirma("Altera este registro? ") = 1
      replvar()
   ELSE
      LOOP
   ENDIF
ENDDO
CLOSE ALL
voltatela()
RETURN

PROCEDURE confat
IF .NOT. abrearq("clientes","indcodcl")
   RETURN
ENDIF
IF .NOT.abrearq("faturas","indcodfa")
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodfat) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      mostravar()
   ELSE
      mensagem(23,10,"Factura no registrada           ")
      LOOP
   ENDIF
   mensagem(23,10,"Presione <Espacio> para continuar ")
ENDDO
CLOSE ALL
voltatela()
RETURN

PROCEDURE excfat
IF .NOT. abrearq("clientes","indcodcl")
   RETURN
ENDIF
IF .NOT. abrearq("faturas","indcodfa","indcldat","inddatcl")
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodfat) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      mostravar()
   ELSE
      mensagem(23,10,"Factura no registrada")
      LOOP
   ENDIF
   IF confirma("Elimina este registro?") = 1
      DELETE
   ELSE
      LOOP
   ENDIF
ENDDO
CLOSE ALL
voltatela()
RETURN

PROCEDURE baifat
IF .NOT. abrearq("clientes","indcodcl")
   RETURN
ENDIF
IF .NOT. abrearq("faturas","indcodfa")
   RETURN
ENDIF
SET RELATION TO codcli INTO clientes
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodfat) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      mostravar()
      DO CASE
	  CASE mpagamento <> CTOD("") .AND. (mvr_nominal = mvr_pago)
	       IF confirma("Factura cancelada totalmente, continua?") = 2
		  LOOP
	       ELSE
		  @13,58 GET mpagamento PICTURE 'DD/DD/DD'
		  @15,58 GET mvr_pago PICTURE '@E 9,999,999.99'
		  READ
	       ENDIF
	  CASE mpagamento <> CTOD("") .AND. (mvr_nominal <> mvr_pago)
	       @16,38 SAY "SALDO PENDIENTE..:"
	       calc = vr_pago
	       @16,58 SAY mvr_nominal - mvr_pago PICTURE '@E 9,999,999.99'
	       @13,58 GET pagamento PICTURE 'DD/DD/DD'
	       @15,58 GET mvr_pago PICTURE '@E 9,999,999.99'
	       READ
	       mvr_pago = mvr_pago + calc
	       IF mvr_pago > mvr_nominal
		  IF confirma("Valor pagado no puede ser mayor que el nominal, continua?") = 2
		     mvr_pago = calc
		     LOOP
		  ENDIF
	       ENDIF
	  OTHERWISE
	       @13,58 GET mpagamento PICTURE 'DD/DD/DD'
	       @15,58 GET mvr_pago PICTURE '@E 9,999,999.99'
	       READ
      ENDCASE
   ELSE
      mensagem(23,10,"Factura no registrada")
      LOOP
   ENDIF
   IF confirma("Confima abono a esta factura?") = 1
      REPLACE pagamento WITH mpagamento
      REPLACE vr_pago WITH mvr_pago
   ELSE
      LOOP
   ENDIF
ENDDO
CLOSE ALL
voltatela()
RETURN





STATIC PROCEDURE inicvar
mcodfat = SPACE(5)
mcodcli = SPACE(4)
mvencimento = CTOD('  /  /  ')
mpagamento = CTOD('  /  /  ')
mvr_nominal = 0
mvr_pago = 0
RETURN

STATIC PROCEDURE mostratexto
SET COLOR TO w/n
@05,02 CLEAR TO 17,74
@11,02 TO 17,74
@11,34 TO 17,74
@05,02 TO 17,74 DOUBLE
@07,04 SAY "NUMERO......:"
@09,04 SAY "COD. CLIENTE:"
@13,04 SAY "VENCIMIENTO.:"
@13,38 SAY "FECHA DE PAGO....:"
@15,04 SAY "VALOR ......:"
@15,38 SAY "VALOR PAGO.......:"
RETURN

STATIC PROCEDURE mostravar
SET COLOR TO w/n
@07,19 SAY mcodfat
@09,19 SAY mcodcli
@09,28 SAY clientes->nomecli
@13,19 SAY mvencimento PICTURE 'DD/DD/DD'
@13,58 SAY mpagamento PICTURE 'DD/DD/DD'
@15,19 SAY mvr_nominal PICTURE '@E 9,999,999.99'
@15,58 SAY mvr_pago PICTURE '@E 9,999,999.99'
RETURN

STATIC PROCEDURE getvar
SET COLOR TO w/n,n/w
@09,19 GET mcodcli PICTURE "9999";
VALID clientes->(pesqcli(@mcodcli,9,28))
@13,19 GET mvencimento PICTURE 'DD/DD/DD'
@15,19 GET mvr_nominal PICTURE '@E 9,999,999.99'
@13,58 GET mpagamento PICTURE 'DD/DD/DD'
@15,58 GET mvr_pago PICTURE '@E 9,999,999.99'
RETURN

STATIC PROCEDURE igualavar
STORE codfat TO mcodfat
STORE codcli TO mcodcli
STORE vencimento TO mvencimento
STORE pagamento TO mpagamento
STORE vr_nominal TO mvr_nominal
STORE vr_pago TO mvr_pago
RETURN

STATIC PROCEDURE replvar
REPLACE codfat WITH mcodfat
REPLACE codcli WITH mcodcli
REPLACE vencimento WITH mvencimento
REPLACE pagamento WITH mpagamento
REPLACE vr_nominal WITH mvr_nominal
REPLACE vr_pago WITH mvr_pago
RETURN

STATIC PROCEDURE publvar
PUBLIC mcodfat, mcodcli, mvencimento, mpagamento, mvr_nominal
PUBLIC mvr_pago
RETURN

STATIC PROCEDURE relevar
RELEASE mcodfat, mcodcli, mvencimento, mpagamento, mvr_nominal
RELEASE mvr_pago
RETURN



STATIC PROCEDURE pesquisa
SET COLOR TO w/n,n/w
DO mostratext
mcodfat = 0
@07,19 GET mcodfat PICTURE "99999"
READ
mcodfat = STRZERO(mcodfat,5)
SETCOLOR("N/W")
@07,19 SAY mcodfat
SETCOLOR("W/N")
SEEK mcodfat
RETURN


FUNCTION pesqcli
PARAMETERS mcodcli, lin, col
mcodcli = STRZERO(VAL(mcodcli),4)
SETCOLOR("N/W")
@09,19 SAY mcodcli
SETCOLOR("W/N")
SEEK mcodcli
IF FOUND()
   @lin,col SAY nomecli
   achou = .T.
ELSE
   @lin,col SAY "No se encuentra..."
   INKEY(2)
   achou = .F.
ENDIF
RETURN(achou)

* Fin: MODFAT.PRG