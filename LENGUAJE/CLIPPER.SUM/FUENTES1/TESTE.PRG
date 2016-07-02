**** PROGRAMA: TESTE.PRG
PARAMETERS usuario, nivel
IF PCOUNT() = 0
   @23,10 SAY " Se necesita la identificacion del usuario "
   INKEY(3)
   QUIT
ENDIF
IF PCOUNT() = 1
   nivel = 0
ENDIF
entrada = TIME()
CLEAR
@0,0,MAXROW(),MAXCOL() BOX REPL(CHR(219),8)
@MAXROW(),30 SAY " Accedido por &usuario. "
INKEY(0)

*** RESTO DEL PROGRAMA

salida = TIME()
GRAVALOG(entrada,salida)
PROCEDURE GRAVALOG(entrada,salida)
tiempo = ELAPTIME(entrada,salida)
IF FILE("LOG.TXT")
   texto = MEMOREAD("LOG.TXT")
ELSE
   texto = ""
ENDIF
texto += "USUARIO &usuario. ACTIVO DURANTE &tiempo."+CHR(13)+CHR(10)
texto += "FECHA  : "+DTOC(DATE())+CHR(13)+CHR(10)
texto += "INICIO : "+entrada+CHR(13)+CHR(10)
texto += "TERMINO: "+salida+CHR(13)+CHR(10)
texto += REPLICATE("-",50)+CHR(13)+CHR(10)
MEMOWRIT("LOG.TXT",texto)