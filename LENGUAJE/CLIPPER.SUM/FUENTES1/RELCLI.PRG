* NOMBRE DEL ARCHIVO: RELCLI.PRG
* POR: JOSE ANTONIO RAMALHO
* NOTA:
* FECHA: 02/21/91
* DESC:
* LLAMADO POR
* ARCHIVOS DE DATOS:
LOCAL op
telavelha = SAVESCREEN(04,01,21,79)
moldura(16,26,20,40,.T.,"Listar por")
@23,10 SAY SPACE(60)
DO WHILE .T.
   @17,27 PROMPT "NOMBRE       " MESSAGE "Listado por orden alfabetico"
   @18,27 PROMPT "CODIGO       " MESSAGE "Listado por orden de codigo"
   @19,27 PROMPT "REGRESA      " MESSAGE "Regrese al menu anterior"
   MENU TO op
   DO CASE
      CASE op = 1
	   relnome()
      CASE op = 2
	   relcod()
      CASE op = 3
	   RESTSCREEN(04,01,21,79,telavelha)
	   RETURN
   ENDCASE
ENDDO

PROCEDURE relnome
IF .NOT. abrearq("clientes","indnomcl")
   mensagem(23,10,"El archivo de clientes no encontrado...rutina terminada")
ENDIF
titulo = "REPORTE DE CLIENTES POR ORDEN ALFABETICO"
nr = "CR-001"
listacli()

PROCEDURE relcod
IF .NOT. abrearq("clientes","indcodcl")
   mensagem(23,10,"El archivo de clientes no se encuentra... rutina terminada")
ENDIF
titulo = "REPORTE DE CLIENTES POR ORDEN DE CODIGO"
nr = "CR-002"
listacli()


PROCEDURE listacli(titulo,nr)
p = 0; lin = 61
@23,10 SAY "Listado de archivo de clientes...             "
SET DEVICE TO PRINTER
DO WHILE .NOT. EOF()
   nr = "CR-002"
   IF lin > 60
      cabecger(titulo,nr)
      cabeccli()
   ENDIF
   detalhecli()
   SKIP
ENDDO
final()
SET DEVICE TO SCREEN
mensagem(23,10,"Final del reporte de clientes",2)




PROCEDURE cabeccli
@04,02 SAY "CODIGO        NOMBRE"
@05,10 SAY "DIRECCION"
@06,02 SAY "CIUDAD                   ESTADO       CEP"
@06,48 SAY "ULTIMA COMPRA       SITUACION"
@07,00 SAY REPLICATE("=",80)
lin = 8
RETURN

PROCEDURE detalhecli
@lin  ,03 SAY codcli
@lin  ,14 SAY nomecli
@lin+1,03 SAY endereco
@lin+2,03 SAY cidade
@lin+2,30 SAY estado
@lin+2,39 SAY cep
@lin+2,49 SAY ultcompra PICTURE 'DD/DD/DD'
@lin+2,66 SAY IF(situacao,"PUNTUAL","CON ATRASOS")
@lin+3,00 SAY REPLICATE("- ",40)
lin += 4
RETURN


* Fin: RELCLI.PRG