SET KEY -1 TO NOTAS     && F2
SET KEY -2 TO DISPSTRU  && F3
SET key -3 TO SHOWDIR   && F4
SET KEY -4 TO IRADOS   && F5

BOXa=CHR(201)+CHR(205)+CHR(187)+CHR(186)+;
     CHR(188)+CHR(205)+CHR(200)+CHR(186)+CHR(176)
DO WHILE .T.
CLEAR
@ 1,1,24,79 box boxa
NOME1=SPACE(30)
SET= SPACE(1)
CAR=SPACE(1)
sal=0
MCOD="   "
OBS=SPACE(10)

IRAPROG("CHKDSK /F")
IRAPROG("FR C: /SAVE")   // PROGRAMA DE NORTON UTILITIES

@ 08,10 say "codigo : " geT MCOD
READ
IF mCOD="FIN"
 EXIT
ENDIF
@ 12,10 SAY "CARGO : " GET CAR PICT "@!"
@ 13,10 SAY "SECTOR : " GET SET PICT "@!"
READ
@ 17,10 SAY " OBS " GET OBS
READ
NADA=INKEY(0)
ENDDO
set cursor on


*********************************************************
FUNCTION NOTAS
BOXnot1=repl(CHR(219),8)+CHR(176)
BOXnot2=CHR(201)+CHR(205)+CHR(187)+CHR(186)+;
     CHR(188)+CHR(205)+CHR(200)+CHR(186)+CHR(32)
save screen to t_not_in

@ 1,0,24,79 BOX BOXnot1

DECLARE arqtex[adir("*.TXT")]
ADIR("*.TXT",arqtex)
IF LEN(arqTEX)=0 .OR. TYPE("ARQTEX[1]")="U"
  OK_NOTA=CONFIRMA ("NO EXITEN ARCHIVOS DE TEXTO EN DIRECTORIO, CREAR UNO
NUEVO ?")
  IF OK_NOTA=2  && NEGATIVE
     RESTORE SCREEN FROM T_NOT_IN
     RETURN
   ELSE
     ARQ_NOVO=SPACE(8)
     @ 3,3,5,44 BOX BOXNOT2
     CLEAR GETS
     @ 4,4 SAY "TECLEE EL NOMBRE DEL ARCHIVO--> "
     @ 4,34 GET ARQ_NOVO PICT "@!"
     READ
     ARQ_NOVO=ALLTRIM(ARQ_NOVO)+".TXT"
     @ 4,30 SAY ARQ_NOVO
     MOLDURA(9,4,21,76,.F.,"&ARQ_NOVO")
     TEXTO=SPACE(1)
     TEXTO=MEMOEDIT(TEXTO,10,5,20,75,.T.)
     OK_NOTA=CONFIRMA("CONFIRME EL GUARDAR EL ARCHIVO  &ARQ_NOVO. ")
       IF OK_NOTA=1
        MEMOWRIT("&ARQ_NOVO.",TEXTO)
       ENDIF
     RESTORE SCREEN FROM t_NOT_IN
  ENDIF
ELSE
  DO WHILE .T.
   @ 2,2 CLEAR TO 10,15
   MOLDURA(2,2,10,15,.F.,"ARCHI.TEXTO")
   opc=ACHOICE(3,3,9,14,arqTEX)
   IF opc=0
     ok_nota=confirma("ABANDONA (S) o EDITA uno nuevo (N)")
     IF ok_nota=1  && positive
        RESTORE SCREEN FROM T_NOT_IN
        EXIT
     ENDIF
     IF OK_NOTA=2
       ARQ_NOVO=SPACE(8)
       @ 3,3,5,44 BOX BOXNOT2
       CLEAR GETS
       @ 4,4 SAY "TECLEE EL NOMBRE DEL ARCHIVO--> "
       @ 4,32 GET ARQ_NOVO PICT "@!"
       READ
       ARQ_NOVO=TRIM(ARQ_NOVO)+".TXT"
       @ 4,32 SAY ARQ_NOVO
       MOLDURA(9,4,21,76,.F.,"&ARQ_NOVO.")
       TEXTO=SPACE(3)
       TEXTO=MEMOEDIT(TEXTO,10,5,20,75,.T.)
       OK_NOTA=CONFIRMA("CONFIRME EL GUARDAR EL ARCHIVO  &ARQ_NOVO. ")
       IF OK_NOTA=1
          MEMOWRIT("&ARQ_NOVO.",TEXTO)
       ENDIF
       RESTORE SCREEN FROM t_NOT_IN
       RETURN
     ENDIF
   ELSE
      arq_NOVO=arqTEX[opc]
      MOLDURA(9,4,21,76,.F.,"&ARQ_NOVO.")
      TEXTO=MEMOREAD("&ARQ_NOVO.")
      TEXTO=MEMOEDIT(TEXTO,10,5,20,75,.T.)
      OK_NOTA=CONFIRMA("CONFIRMA A GRAVACAO DO ARQUIVO  &ARQ_NOVO. ")
      IF OK_NOTA=1
      MEMOWRIT("&ARQ_NOVO.",TEXTO)
      RESTORE SCREEN FROM t_NOT_IN
    ENDIF
  ENDIF
  ENDDO
ENDIF
RETURN

FUNCTION CONFIRMA(texto)
largjan=LEN(texto)+2
IF largjan<16
   largjan=16
ENDIF
CES=(80-LARGJAN)/2
LES=19
telavelha=SAVESCREEN(les,0,les+4,79)
corantig=SETCOLOR()
cornova="W/B,N/W"
SET COLOR TO &CORNOVA
@ les,ces CLEAR TO les+3,ces+largjan
@ les,ces TO les+3,ces+largjan double
@ les+1,ces+2  SAY texto
coluna=(largjan-9)/2
@ les+2,ces+coluna  PROMPT "Si"
@ les+2,ces+coluna+6 PROMPT "No"
MENU TO CONFIRM
SET COLOR TO &CORANTIG
RESTSCREEN(les,0,les+4,79,telavelha)
RETURN (CONFIRM )



FUNCTION MOLDURA(topo,esq,dir ,baixo,duplo,texto)
IF PCOUNT()<6
   @ 23,10 SAY "NUMERO DE PARAMETROS NO VALIDOS"
   RETURN (.F.)
ENDIF
IF DUPLO
   @ topo,esq TO DIR ,baixo double
ELSE
   @ topo,esq TO DIR ,baixo
ENDIF
IF LEN(texto)>0
   tam=baixo-esq
   novapos=(tam-LEN(texto))/2
   @ topo,esq+novapos SAY texto
ENDIF
RETURN (.T.)


**************************************************************
FUNCTION DISPSTRU
ABERTOS=.T.
J_ANTERIOR=SAVESCREEN(00,00,24,79)
ARQ_ATUAL=STR(SELECT())  &&PARA VOLVER AL AREA ACTUAL

@ 0,0,24,79 box CHR(219)+CHR(219)+CHR(219)+CHR(219)+CHR(219);
   +CHR(219)+CHR(219)+CHR(219)+CHR(176)
IF ABERTOS
 C=1
 DECLARE ARQ[15]
 FOR I = 1 TO 15
  SELECT (I)
  IF LEN(ALIAS()) <> 0
   ARQ[C]=ALIAS()
   C=C+1
  ENDIF
 NEXT
ELSE
 DECLARE arq[ADIR("*.DBF")]
 ADIR("*.DBF",arq)
 IF LEN(arq)=0
   @ 23,10 SAY "NO EXITEN ARCHIVOS DE DATOS EN ESTE DIRECTORIO"
   INKEY(3)
   RETURN
 ENDIF
ENDIF
DO WHILE .T.
   @ 2,2 CLEAR TO 10,15
   MOLDURA(2,2,10,15,.F.,"ARCHIVOS")
   opc=ACHOICE(3,3,9,14,arq)
   IF opc=0
    SELECT &ARQ_ATUAL
    RESTSCREEN(00,00,24,79,J_ANTERIOR)
    EXIT
   ENDIF
  IF ABERTOS
   SELECT (ARQ[OPC])
  ELSE
   arquivo=arq[opc]
   USE &ARQUIVO. NEW
  ENDIF
   c=FCOUNT()
   DECLARE nomes[c],tipo[c],tam[c],dec[c],resumo[c]
   AFIELDS(nomes,tipo,tam,dec)
   FOR i = 1 TO c
      nomes[i]=nomes[i]+REPLICATE(" ",(10-LEN(nomes[i])))
      resumo[i]=nomes[i]+" | " +tipo[i]+"  |"+STR(tam[i],3)+" | "+ ;
      STR(dec[i],2)
   NEXT
   SAVE SCREEN TO TELAINI
   @ 02,17 say "&arquivo."
   @ 12,2 CLEAR TO 22,30
   @ 12,2 TO 22,30
   @ 12,6 SAY "NOMBRE"
   @ 12,15 SAY "TIPO"
   @ 12,20 SAY "TAM"
   @ 12,26 SAY "DEC"
   ACHOICE(13,3,21,29,resumo)
   @ 2,33 CLEAR TO 22,77
   MOLDURA(2,33,22,77,.T.,"CONTENIDO DEL ARCHIVO")
   DBEDIT(3,34,21,76,"","TESTATECLA")
   RESTORE SCREEN FROM telaini
   IF .NOT. ABERTOS
    USE
   ENDIF
ENDDO
SELECT &ARQ_ATUAL
RESTSCREEN(00,00,24,79,J_ANTERIOR)


FUNCTION TESTATECLA      //USADA POR DISPSTRU()
PARAMETERS MODE,COUNTER
SET cursor ON
DO CASE
CASE mode=0
   IF DELETED()
      @ 23,70 SAY "BORRADO"
   ELSE
      @ 23,70 SAY REPLICATE(CHR(176),9)
   ENDIF
   RETURN (1)      && NADA ES MODIFICADO
CASE mode =1
   @ 23,55 SAY "INICIO DE ARCHIVO"  && Fue pulsado ReP g o
   INKEY(.5)                        && cursor arriba al 1 reg.
   @ 23,55 SAY REPLICATE(CHR(176),20)
   RETURN (1)
CASE mode =2                        && Fue pulsado AvP g o
   @ 23,55 SAY "FIN DE ARCHIVO"     && cursor abajo al £ltimo
   INKEY(.5)                        && registro
   @ 23,55 SAY REPLICATE(CHR(176),20)
   RETURN (1)
CASE mode= 3
   @ 23,10 SAY "ARCHIVO SIN CONTENIDO"
   INKEY(1)
   RETURN (0)
   **** comprueba la £ltima tecla pulsada
CASE LASTKEY()=27  && Fue presionado ESC
    SELECT &ARQ_ATUAL
    RESTSCREEN(00,00,24,79,J_ANTERIOR)
   RETURN (0)      && ABANDONA DBEDIT
CASE LASTKEY()=13  && fue presionado ENTER
   campo=FIELDNAME(counter)
   IF TYPE("&CAMPO")="M"
      memotela=SAVESCREEN(9,44,21,76)
      MOLDURA(9,44,21,76,.F.,"CAMPO MEMO")
      MEMOEDIT(&CAMPO,10,45,20,75,.F.)
      RESTSCREEN(9,44,21,76,memotela)
     RETURN (1)
   ELSE
     RETURN(1)
   ENDIF
OTHERWISE
   RETURN (1)
ENDCASE


*******************************************************
FUNCTION showdir
LOCAL SHOWDIRSCR:=SAVESCREEN(00,00,24,79), getlist:={}
SET SCORE OFF
P="C:\"+CURDIR("C")
P1=P                 // GUARDA EL DIRECTORIO ACTUAL
DO WHILE .T.
@ 0,0,24,79 BOX REPL(CHR(219),8)+CHR(176)
SET COLOR TO W/N
@ 01,02 TO 04,78
@ 02,03,03,77 BOX REPL(" ",9)
@ 02,03 SAY "PATH :"
@ 02,44 SAY "PLANTILLA..: "
@ 06,04 TO 23,19 DOUBLE
@ 07,05,22,18 BOX REPL(" ",9)
SET COLOR TO W/N, N/W
P="C:\"+CURDIR("C")
P=P+SPACE(30-LEN(P))
M="*.*"
M=M+SPACE(12-LEN(M))
@ 02,12 GET P PICTURE "@K40"
READ
IF LASTKEY()=27
 RUN CD &P1
 EXIT
ENDIF
@ 02,56 GET M PICTURE "@K"
READ
RUN CD &P
DIR1={} ; TOT:=0
DIRET1=DIRECTORY(M)
ASORT(DIRET1,,,{|A,B| A[1]<B[1]})
AEVAL(DIRET1, {|ARQ| AADD(DIR1,ARQ[1]) , TOT+=ARQ[2]})
@ 02,62 SAY LEN(DIR1) PICT "   9999 Archivos"
@ 03,62 SAY TOT       PICT "99,999,999 BYTES"
KEYBOARD CHR(24)+CHR(5)
OPC=ACHOICE(07,05,22,18,DIR1,.T.,"SHOWFILE")
ENDDO
CLEAR
RUN CD &P1
RESTSCREEN(00,00,24,79,SHOWDIRSCR)
RETURN

FUNCTION SHOWFILE
PARAMETERS MODO,ELEM,POSI
DO CASE
CASE MODO = 0
   @ 03,03 say space(52)
   @ 03,03 SAY DIRET1[ELEM,1]
   @ 03,16 SAY DIRET1[ELEM,2] PICTURE "@ER 999,999 bytes"
   @ 03,35 SAY DIRET1[ELEM,3]
   @ 03,45 SAY DIRET1[ELEM,4]
   @ 03,55 SAY DIRET1[ELEM,5]
   return(2)
CASE MODO=3
      DO CASE
      CASE LASTKEY()=27
       RETURN(0)
      CASE LASTKEY()=13
       TELAEDITA:=SAVESCREEN(8,07,23,76)
       SET CURSOR ON
       arq_NOVO=DIR1[ELEM]
       IF DIRET1[ELEM,2]>(MEMORY(2)*1024)
        MOLDURA(8,21,12,76,.F.,"A T E N C A O")
        @ 10,22 SAY "MEMORIA INSUFICIENTE PARA EDITAR ARCHIVO"
        @ 11,22 SAY "PRESIONE UNA TECLA PARA CONTINUAR..."
        INKEY(3)
        RESTSCREEN(8,07,23,76,TELAEDITA)
        RETURN(2)
       ENDIF
       MOLDURA(8,07,23,76,.F.,"&ARQ_NOVO.")
       TEXTO=MEMOREAD("&ARQ_NOVO.")
       EDITA=SUBS("&ARQ_NOVO.",AT(".","&ARQ_NOVO.")+1,3)
       IF EDITA <> "PRG" .AND. EDITA <> "TXT" .AND. EDITA <> "BAT"
        TEXTO=MEMOEDIT(TEXTO,09,08,22,75,.F.,"",132)
       ELSE
        TEXTO=MEMOEDIT(TEXTO,09,08,22,75,.T.,"",132)
        OK_NOTA=CONFIRMA("CONFIRME EL GUARDAR EL ARCHIVO  &ARQ_NOVO. ")
        IF OK_NOTA=1
        MEMOWRIT("&ARQ_NOVO.",TEXTO)
        ENDIF
        SET CURSOR OFF
       ENDIF
       RESTSCREEN(8,07,23,76,TELAEDITA)
       RETURN(2)
     ENDCASE
  OTHERWISE
      RETURN(2)
ENDCASE



********************************************************
FUNCTION IRADOS
SET cursor ON
SAVE SCREEN
@ 0,0 CLEAR
@ 1,0 SAY "Para volver al programa teclee EXIT y pulse <intro>"
IF MEMORY(2) < 45     && comprueba la memoria para ejecutar el COMMAND.COM
   moldura(10,10,14,60,.T.," A T E N C I O N ")
   SET COLOR TO w+/g
   @ 11,11 CLEAR TO 13,59
   @ 11,12 SAY "Falta memoria para ejecutar ese procedimento..."
   @ 12,12 SAY "Verifique se existen programas residentes o el  "
   @ 13,12 SAY "tama¤o de este programa. La memoria libre es "+;
      STR(MEMORY(2),3)+ " K"
   INKEY(4)
ELSE
   RUN c:COMMAND.COM  && colocar el PATH correcto del programa
ENDIF
SET COLOR TO
RESTORE SCREEN
RETURN NIL

***************************************************************
FUNCTION IRAPROG
PARAMETERS programa
IF TYPE("PROGRAMA")="U"
   RETURN .F.
ENDIF
SET cursor ON
SAVE SCREEN
@ 0,0 CLEAR
IF MEMORY(2) < 80   && ajustar para el tama¤o ideal
   moldura(10,10,14,65,.T.," A T E N C I O N " )
   SET COLOR TO w+/g
   @ 11,11 CLEAR TO 13,64
   @ 11,12 SAY "Falta memoria para ejecutar el "+ "&programa"
   @ 12,12 SAY "Verifique si existen programas residentes o el  "
   @ 13,12 SAY "tama¤o del programa atual. La memoria libre es "+;
      STR(MEMORY(2),3)+ " K"
   INKEY(4)
ELSE
   RUN &programa
ENDIF
SET COLOR TO
RESTORE SCREEN
RETURN NIL






