* NOMBRE DEL ARCHIVO: MODUTI.PRG
* POR: JOSE ANTONIO RAMALHO
* NOTA:
* FECHA:02/21/91
* DESC:
* LLAMADO POR:
* ARCHIVOS DE DATOS
LOCAL op
SAVE SCREEN
DO WHILE .T.
   @02,41 SAY procname()
   menu = {{"REINDIZA         ","Reconstruye todos los indices de todos los archivos"},;
	   {"COMPACTA         ","Elimina registros marcados de los archivos         "},;
	   {"BACKUP           ","Crea copia de seguridad de los archivos            "},;
	   {"RESTORE          ","Recupera copia de seguridad                        "},;
	   {"ELIMINA FACTURAS ","Elimina facturas pagadas hasta la fecha dada       "},;
	   {"F I N            ","Regresa al menu anterior                           "}}

   montamenu(11,13,menu)
   menu TO op
   telavelha = SAVESCREEN(04,01,21,79)
   publvar()
   DO CASE
      CASE op = 1
	   DO utireindex
      CASE op = 2
	   DO uticompac
      CASE op = 3
	   DO utibecape
      CASE op = 4
	   DO utirestau
      CASE op = 5
	   DO delfatpag
      CASE op = 6
	   RETURN
	   RESTORE SCREEN
   ENDCASE
ENDDO



PROCEDURE utireindex
USE clientes
SET CURSOR OFF
moldura(10,40,14,65,.F.,"Archivo: CLIENTES")
@12,42 SAY "POR....:  CODIGO ÄÄÄÄÛ"
@13,42 SAY "          NOMBRE ÄÄÄÄÛ"
SETCOLOR("W*/N")
@12,63 SAY CHR(219)
INDEX ON codcli TO indcodcl
SETCOLOR("W/N")
@12,63 SAY CHR(251)
SETCOLOR("W*/N")
@13,63 SAY CHR(219)
INDEX ON nomecli TO indnomcl
SETCOLOR("W/N")
@13,63 SAY CHR(251)

USE faturas
SET CURSOR OFF
moldura(12,45,17,70,.F.,"Archivo: FACTURAS")
@14,47 SAY "POR.: Cod. factura ÄÄÛ"
@15,47 SAY "      Fecha/Cliente ÄÛ"
@16,47 SAY "      Cliente/Fecha ÄÛ"
SETCOLOR("W*/N")
@14,68 SAY CHR(219)
INDEX ON codfat TO indcodfa
SETCOLOR("W/N")
@14,68 SAY CHR(251)
SETCOLOR("W*/N")
@15,68 SAY CHR(219)
INDEX ON DTOS(vencimento)+codcli TO inddatcl
SETCOLOR("W/N")
@15,68 SAY CHR(251)
SETCOLOR("W*/N")
@16,68 SAY CHR(219)
INDEX ON codcli+DTOS(vencimento) TO indcldat
SETCOLOR("W/N")
@16,68 SAY CHR(251)
SET CURSOR ON
RESTSCREEN(04,01,21,79,telavelha)
CLOSE ALL
RETURN

PROCEDURE uticompac
IF .NOT. abrearq("clientes","indnomcl")
   mensagem(23,10,"Archiva de clientes no se encuentra...rutina terminada")
   RETURN
ENDIF
SET CURSOR OFF
moldura(10,40,14,65,.F.,"COMPACTANDO")
@12,42 SAY "Archivo: CLIENTESÄÄÄÄÛ"
@13,42 SAY "         FACTURASÄÄÄÄÛ"
SETCOLOR("W*/N")
@12,63 SAY CHR(219)
SETCOLOR("W/N")
PACK
@12,63 SAY CHR(251)
USE
IF .NOT. abrearq("faturas","indcodfa","inddatcl","indcldat")
   mensagem(23,10,"Archivo de clientes no encontrado...rutina terminada")
   RETURN
ENDIF
SETCOLOR("W*/N")
@13,63 SAY CHR(219)
PACK
SETCOLOR("W/N")
@13,63 SAY CHR(251)
USE
SET CURSOR ON
RESTSCREEN(04,01,21,79,telavelha)
RETURN


PROCEDURE utibecape
moldura(10,40,17,76,.F.," ATENCION! ")
@12,41 SAY "Esta  rutina  utiliza  el  programa"
@13,41 SAY "BACKUP.COM  del Sistema Operacional"
@14,41 SAY "DOS. Se necesitan 120 Kb de memoria"
@15,41 SAY "libre para ejecutarlo."
@16,41 SAY "La memoria libre actual es "+STR(MEMORY(2),3)+" Kb."
IF MEMORY(2) < 120
   IF confirma("El programa puede bloquearse por falta de memoria...continua?") = 2
      RESTSCREEN(04,01,21,79,telavelha)
      RETURN
   ENDIF
ENDIF
IF .NOT. FILE("c:\dos\backup.com")
   mensagem(23,10,"Archivo BACKUP.COM no encontrado...operacion cancelada")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
mensagem(23,10,"Coloque un disquete en el drive A: y tecle <Enter>")
RUN c:\dos\backup c:menu.exe a:
RUN c:\dos\backup c:*.dbf a:
SET CONSOLE ON
mensagem(23,10,"Copias ejecutadas..")
RESTSCREEN(04,01,21,79,telavelha)
RETURN

PROCEDURE utirestau
moldura(10,39,17,76,.F.," ATENCION! ")
@12,40 SAY "Esta   rutina  utiliza  el  programa"
@13,40 SAY "RESTORE.COM del Sistema  Operacional"
@14,40 SAY "DOS. Se necessitan 120 Kb de memoria"
@15,40 SAY "libre para ejecutarlo."
@16,40 SAY "La memoria libre actual es "+STR(MEMORY(2),3)+" Kb."
IF MEMORY(2) < 120
   IF confirma("El programa puede bloquearse por falta de memoria...continua?") = 2
      RESTSCREEN(04,01,21,79,telavelha)
      RETURN
   ENDIF
ENDIF
IF .NOT.FILE("c:\dos\restore.com")
   mensagem(23,10,"Archivo RESTORE.COM no encontrado...operacion cancelada")
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
SET CONSOLE OFF
mensagem(23,10,"Coloque un disquete en el drive A: y tecle <Enter>")
RUN restore a: c:\*.*   > NUL
SET CONSOLE ON
mensagem(23,10,"Restauracion completada")
RESTSCREEN(04,01,21,79,telavelha)
RETURN

PROCEDURE delfatpag
LOCAL limite := CTOD("")
IF .NOT. abrearq("faturas","indcodfa","inddatcl","indcldat")
   mensagem("Falta el archivo de facturas o indices")
   RETURN
ENDIF
moldura(15,09,17,40,.F.," Informe a  ")
@16,10 SAY "Fecha limite:" GET limite
READ
IF LASTKEY() = 27
   RESTSCREEN(04,01,21,79,telavelha)
   RETURN
ENDIF
DELETE ALL FOR pagamento <= limite .AND. vr_pago = vr_nominal
utireindex()
mensagem(23,10,"Eliminacion de registros efectuada",2)
USE
RETURN

* Fin: MODUTI.PRG