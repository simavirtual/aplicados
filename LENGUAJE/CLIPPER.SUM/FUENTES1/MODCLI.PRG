* NOMBRE DEL ARCHIVO: MODCLI.PRG
* POR: JOSE ANTONIO RAMALHO
* NOTA:
* FECHA: 02/21/91
* DESC:
* LLAMADO POR:
* ARCHIVOS DE DATOS:
LOCAL op
SAVE SCREEN
DO WHILE .T.
   @02,42 SAY procname()
   menumanut(09,13,"clientes")
   menu TO op
   telavelha = SAVESCREEN(04,01,21,79)
   publvar()
   DO CASE
      CASE op = 1
	   DO inccli
      CASE op = 2
	   DO altcli
      CASE op = 3
	   DO concli
      CASE op = 4
	   DO exccli
      CASE op = 5
	   relevar()
	   RETURN
	   RESTORE SCREEN
   ENDCASE
ENDDO


PROCEDURE inccli
IF .NOT. abrearq("clientes","indcodcl","indnomcl")
   RETURN
ENDIF
DO WHILE .T.
   publvar()
   inicvar()
   mostratexto()
   pesquisa()
   IF VAL(mcodcli) = 0
      EXIT
   ENDIF
   IF .NOT. FOUND()
      getvar()
      READ
   ELSE
      mensagem(23,10,"Cliente ya registrado")
      LOOP
   ENDIF
   IF confirma("Graba este registro?") = 1
      APPEND BLANK
      replvar()
   ELSE
      LOOP
   ENDIF
ENDDO
USE
voltatela()
relevar()
RETURN

PROCEDURE altcli
IF .NOT. abrearq("clientes","indcodcl","indnomcl")
   RETURN
ENDIF
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodcli) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      getvar()
      READ
   ELSE
      mensagem(23,10,"Cliente no registrado              ")
      LOOP
   ENDIF
   IF confirma("Altera este registro?") = 1
      replvar()
   ELSE
      LOOP
   ENDIF
ENDDO
USE
voltatela()
RETURN

PROCEDURE concli
IF .NOT. abrearq("clientes","indcodcl")
   RETURN
ENDIF
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodcli) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      mostravar()
      READ
   ELSE
      mensagem(23,10,"Cliente no registrado            ")
      LOOP
   ENDIF
   mensagem(23,10,"Presione <Espacio> para continuar ")
ENDDO
USE
voltatela()
RETURN

PROCEDURE exccli
IF .NOT. abrearq("clientes","indcodcl","indnomcl")
   RETURN
ENDIF
DO WHILE .T.
   mostratexto()
   pesquisa()
   IF VAL(mcodcli) = 0
      EXIT
   ENDIF
   IF FOUND()
      igualavar()
      mostravar()
      READ
   ELSE
      mensagem(23,10,"Cliente no registrado")
      LOOP
   ENDIF
   IF confirma("Elimina ese registro?") = 1
      DELETE
   ELSE
      LOOP
   ENDIF
ENDDO
USE
voltatela()
RETURN






PROCEDURE inicvar
mcodcli = SPACE(4)
mnomecli = SPACE(40)
mendereco = SPACE(40)
mcep = SPACE(5)
mcidade = SPACE(20)
mestado = SPACE(2)
multcompra = CTOD('  /  /  ')
msituacao = .F.
RETURN

PROCEDURE mostratexto
SET COLOR TO w/n
@06,05 CLEAR TO 17,65
@06,05 TO 17,65
@08,09 SAY "CODIGO...:"
@09,09 SAY "NOMBRE...:"
@10,09 SAY "DIRECCION:"
@11,09 SAY "CEP......:"
@12,09 SAY "CIUDAD...:"
@13,09 SAY "ESTADO...:"
@15,09 SAY "ULTIMA COMPRA:"
@16,09 SAY "SITUACION....:"
RETURN

PROCEDURE voltatela
RESTSCREEN(04,01,21,79,telavelha)

PROCEDURE mostravar
SET COLOR TO w/n
@08,21 SAY mcodcli
@09,21 SAY mnomecli
@10,21 SAY mendereco
@11,21 SAY mcep
@12,21 SAY mcidade
@13,21 SAY mestado
@15,25 SAY multcompra PICTURE 'DD/DD/DD'
@16,25 SAY IF(msituacao,"Cliente al dia","Cliente moroso")
RETURN

PROCEDURE getvar
SET COLOR TO w/n,n/w,,n/b
@09,21 GET mnomecli PICTURE "@!X"
@10,21 GET mendereco PICTURE "@!X"
@11,21 GET mcep PICTURE "99999" VALID completa()
@12,21 GET mcidade PICTURE "@A!"
@13,21 GET mestado PICTURE "AA"
@15,25 GET multcompra PICTURE 'DD/DD/DD'
@16,25 GET msituacao PICTURE 'L'
RETURN


PROCEDURE igualavar
STORE codcli TO mcodcli
STORE nomecli TO mnomecli
STORE endereco TO mendereco
STORE cep TO mcep
STORE cidade TO mcidade
STORE estado TO mestado
STORE ultcompra TO multcompra
STORE situacao TO msituacao
RETURN

PROCEDURE replvar
REPLACE codcli WITH mcodcli
REPLACE nomecli WITH mnomecli
REPLACE endereco WITH mendereco
REPLACE cep WITH mcep
REPLACE cidade WITH mcidade
REPLACE estado WITH mestado
REPLACE ultcompra WITH multcompra
REPLACE situacao WITH msituacao
RETURN

PROCEDURE publvar
PUBLIC mcodcli, mnomecli, mendereco, mcep, mcidade
PUBLIC mestado, multcompra, msituacao
RETURN

PROCEDURE relevar
RELEASE mcodcli, mnomecli, mendereco, mcep, mcidade
RELEASE mestado, multcompra, msituacao
RETURN

PROCEDURE pesquisa
mcodcli = 0
@08,21 GET mcodcli PICTURE "9999"
READ
mcodcli = STRZERO(mcodcli,4)
SETCOLOR("N/W")
@08,21 SAY mcodcli
SEEK mcodcli
SETCOLOR("W/N")
RETURN


FUNCTION completa
IF VAL(mcep) <= 5999
   mestado = "SP"
   mcidade = "SAO PAULO          "
   KEYBOARD CHR(13)+CHR(13)
ENDIF
RETURN(.T.)

* Fin: MODCLI.PRG