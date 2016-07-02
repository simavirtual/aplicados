
CLEAR
hora=left(time(),5)
@ 10,10 SAY "HORA : " GET HORA PICT "@R99:99" ;
     VALID BUSCAHORA(HORA)
READ
? HORA
run TIME &HORA
? TIME()
INKEY(0)

CLEAR
INICIO=TIME()
? DIFTIEMPO("14:00:00","19:00:00")
? DIFTIEMPO("14:00:00","12:00:00")
? DIFTIEMPO("14:00:00","09:00:00")
INKEY(2)
FIM=TIME()
? DIFTIEMPO(INICIO,FIM)
? DIFTIEMPO("14:00:00","00:35:10")
INKEY(0)

CLEAR
? SEGUNDOS(TIME())
? SEGUNDOS("01:00:00")
? SEGUNDOS("14:00:00")
? SEGUNDOS("14:35:00","12:10:50")
INKEY(0)

CLEAR
? HORAAMPM(TIME())
? HORAAMPM("12:45")
? HORAAMPM("00:43")
? HORAAMPM("09:23")
? HORAAMPM("21:23")
INKEY(0)

CLEAR
VER_HORA()
VER_HORA(23,10)
VER_HORA(ROW(),40)
VER_HORA(10,COL())
VER_HORA(42,10)   // EMITE UN PITIDO INDICANDO UN ERROR.
INKEY(0)


ALTHORA()
INKEY(0)



? SEGUNDOS(TIME())
? SEGUNDOS("14:00:00")
? SEGUNDOS("14:35:00","12:00:00")




*  FILE NAME: FUNCHORA.PRG
*  BY: Jose antonio Ramalho
*  NOTICE: Megatron Assessoria e Treinamento ltda.
*  DATE:
*  DESC:
**************************************************
FUNCTION HORAAMPM(tempo)
hora=VAL(LEFT(tempo,2))
minuto=SUBSTR(tempo,4,2)
DO CASE
CASE hora>=12
   hora=hora-12
   sinal=" pm"
CASE hora<12
   sinal=" am"
ENDCASE
hora=STR(hora,2)
final= hora+":"+minuto+sinal
RETURN (final)

**************************************************
FUNCTION VER_HORA(LIN,COL)
IF LIN=NIL
   LIN=0
ENDIF
IF COL=NIL
 COL=70
ENDIF
IF LIN>MAXROW() .OR. COL > MAXCOL()
 TONE(3000,1) ;TONE(2000,1) ; TONE(1000,1)
 RETURN .F.
ENDIF
@ LIN,COL SAY LEFT(TIME(),5)
RETURN NIL

**************************************************
FUNCTION ALTHORA
SAVE SCREEN
CLEAR
IF .NOT. FILE("C:\COMMAND.COM")
   @ 09,19,14,63 BOX REPL(chr(219),8)+" "
   @ 11,21 SAY "IMPOSIBLE EJECUTAR. EL ARCHIVO COMMAND.COM"
   @ 12,21 SAY "NO ESTA EN EL DIRECTORIO ESPECIFICADO"
   INKEY(2)
   RESTORE SCREEN
   RETURN(.F.)
ENDIF
IF MEMORY(2)<100
   @ 09,19,14,61 BOX REPL(CHR(219),8)+" "
   @ 11,21 SAY "IMPOSIBLE EJECUTAR. MEMORIA INSUFICIENTE"
   @ 12,21 SAY "100 kB SON NECESARIOS. EXISTEN: "+STR(MEMORY(2),3)
   INKEY(2)
   RESTORE SCREEN
   RETURN(.F.)
ENDIF
RUN time
RESTORE SCREEN
RETURN (.T.)
**************************************************
FUNCTION BUSCAHORA(TEMPO,LIN1,COL1)
VARIAVEL=READVAR()
IF TEMPO=NIL
  TEMPO=TIME()
ENDIF
hora=(LEFT(tempo,2))
minuto=(SUBSTR(tempo,4,2))
hora=hora+minuto   && CONCATENA CARACTERES
hora=VAL(hora)
IF LIN1=NIL
   lin1=ROW()
ENDIF
IF COL1=NIL
   col1=COL()
ENDIF
SET cursor OFF
teste=0
DO WHILE .T.
   HORA=STRZERO(HORA,4)
   @ lin1,col1 GET hora PICT "@R 99:99"
   CLEAR GETS
   teste=INKEY(0)
   IF teste=13 .OR. teste=27
      EXIT
   ENDIF
   HORA=VAL(HORA)
   IF teste=5 .OR. teste = 24   //CURSOR ARRIBA Y CURSOR ABAJO
      hora= hora+IF(teste=5,1,-1)
      teste1= VAL(SUBS(STR(HORA,4),3,2))
      IF HORA<0
       HORA=2359
      ENDIF
      IF teste1=60
         hora=(hora+40)
      ENDIF
      IF TESTE1=99
       HORA=HORA-40
      ENDIF
      IF HORA=2400
          hora=0
      ENDIF
   LOOP
   ENDIF
   IF TESTE=18 .OR. TESTE=3   // PGUP /PGDN
      TESTE1= VAL(SUBS(STR(HORA,4),3,2))
      HORA=HORA+IF(TESTE=18,+100,IF(HORA<=59,-HORA+2300+TESTE1 ,-100))
      IF HORA>2400
       HORA=HORA-2400
      ENDIF
      IF HORA=2400
          hora=0
      ENDIF
   ENDIF
ENDDO
SET cursor ON
hora=left(hora,2)+":"+SUBS(HORA,3,2)
&VARIAVEL=HORA
RETURN (.T.)

**************************************************
FUNCTION SEGUNDOS(tempo,INICIO)
IF INICIO<>NIL
  HORAS=VAL(LEFT(TEMPO,2))-VAL(LEFT(INICIO,2))
  MINUTOS=VAL(SUBS(TEMPO,4,2))-VAL(SUBS(INICIO,4,2))
  s1=VAL(SUBS(TEMPO,7,2))
  s2=VAL(SUBS(INICIO,7,2))
  IF S2<=S1
    SEGS=S1-S2
   ELSE
    SEGS=S1+(60-S2)
  ENDIF
  TEMPO=STUFF(TEMPO,1,2,str(horas,2))
  TEMPO=STUFF(TEMPO,4,2,STR(MINUTOS,2))
  TEMPO=STUFF(TEMPO,7,2,STR(SEGS,2))
ENDIF
final= VAL(LEFT(tempo,2))*3600 + VAL(SUBSTR(tempo,4,2))*60 + ;
   VAL(SUBSTR(tempo,7,2))
RETURN (final)


**************************************************
FUNCTION DIFTIEMPO(hora1,hora2)
totsegdia=86400         && total de segundos de 1 dia
hora1=segundos(hora1)
hora2=segundos(hora2)
IF hora2<hora1   && mudou de dia
   hora2=hora2+totsegdia
ENDIF
final=hora2-hora1

final=STR(INT(MOD(final/3600,24)),2,0)+":"+;
   STR(INT(MOD(final/60,60)),2,0)+":"+;
   STR(INT(MOD(final,60)),2,0)

IF LEFT(final,1)=" "
   final=STUFF(final,1,1,"0")
ENDIF
IF SUBSTR(final,4,1)=" "
   final=STUFF(final,4,1,"0")
ENDIF
IF SUBSTR(final,7,1)=" "
   final=STUFF(final,7,1,"0")
ENDIF
RETURN (final)