SET DATE BRIT
CLEAR
MODFECHA()
INKEY(0)

CLEAR
DATA=DATE()
@ 10,10 SAY "FECHA : " GET DATA VALID BUSCAFECHA(DATA)
READ
INKEY(0)

CLEAR
? "FECHATEX()"
@ 10,10 SAY FECHATEX(DATE())
@ 11,10 SAY FECHATEX(CTOD("07/09/91"),"RIO DE JANEIRO")
@ 12,10 SAY FECHATEX(DATE()+3)
INKEY(0)

CLEAR
? "DIATEX()"
@ 10,10 SAY DIATEX(DATE())
@ 11,10 SAY DIATEX(CTOD("07/09/91"))
@ 12,10 SAY DIATEX(DATE()+3)
INKEY(0)

CLEAR
? "FIESTAS()"
@ 10,10 SAY FIESTAS(DATE())
@ 11,10 SAY FIESTAS(CTOD("07/09/91"))
@ 12,10 SAY FIESTAS(DATE()+3)
INKEY(0)

CLEAR
? "FINANO()"
@ 10,10 SAY FINANO(DATE())
@ 11,10 SAY FINANO(CTOD("07/09/61"))
@ 12,10 SAY FINANO(DATE()+3)
DATA=CTOD("10/12/91")
@ 13,10 SAY FINANO(DATA+30)
INKEY(0)

CLEAR
? "INIANO"
@ 10,10 SAY INIANO(DATE())
@ 11,10 SAY INIANO(CTOD("07/09/61"))
@ 12,10 SAY INIANO(DATE()+3)
DATA=CTOD("10/12/91")
@ 13,10 SAY INIANO(DATA+30)
INKEY(0)

CLEAR
? "FINMES()"
@ 10,10 SAY FINMES(DATE())
@ 11,10 SAY FINMES(CTOD("07/09/61"))
@ 12,10 SAY FINMES(DATE()+3)
DATA=CTOD("10/12/91")
@ 13,10 SAY FINMES(DATA+30)
@ 14,10 SAY FINMES(CTOD("07/02/91"))
INKEY(0)


CLEAR
? "INIMES()"
@ 10,10 SAY INIMES(DATE())
@ 11,10 SAY INIMES(CTOD("07/09/61"))
@ 12,10 SAY INIMES(DATE()+3)
DATA=CTOD("10/12/91")
@ 13,10 SAY INIMES(DATA+30)
@ 14,10 SAY INIMES(CTOD("07/02/91"))
INKEY(0)

CLEAR
? "FINSEM()"
@ 10,10 SAY FINSEM(DATE())    //
@ 11,10 SAY FINSEM(CTOD("07/09/61"))
@ 12,10 SAY FINSEM(CTOD("18/09/91")-4)
DATA=CTOD("21/04/91")         // DOMINGO
@ 13,10 SAY FINSEM(DATA)
@ 14,10 SAY FINSEM(DATA-1)    // SABADO
INKEY(0)

CLEAR
? "INISEM"
@ 10,10 SAY INISEM(DATE())    //
@ 11,10 SAY INISEM(CTOD("07/09/61"))
@ 12,10 SAY INISEM(CTOD("18/09/91")-4)
DATA=CTOD("21/04/91")         // DOMINGO
@ 13,10 SAY INISEM(DATA)
@ 14,10 SAY INISEM(DATA-1)    // SABADO
INKEY(0)

CLEAR
? "INIMESSIG()"
@ 10,10 SAY INIMESSIG(DATE())           // 18/04/91
@ 11,10 SAY INIMESSIG(CTOD("07/09/61"))
@ 12,10 SAY INIMESSIG(DATE()+3)
DATA=CTOD("10/12/91")
@ 13,10 SAY INIMESSIG(DATA+30)
INKEY(0)

CLEAR
? "MESTEX"
@ 10,10 SAY MESTEX(DATE())
@ 11,10 SAY MESTEX(CTOD("07/09/91"))
@ 12,10 SAY MESTEX(DATE()+3)
INKEY(0)

CLEAR
? "SABDOM()"
DATAREC=CTOD("")
@ 10,10 SAY "FECHA DEL RECIBO..: " GET DATAREC ;
             VALID .NOT. SABDOM(DATAREC)
READ
? SABDOM(CTOD("31/03/91"))   // .T.
? SABDOM(CTOD("01/04/91"))   // .F.
INKEY(0)

CLEAR
? "LUNES()"
?
? LUNES(DATE())     // 18/04/91  JUEVES
? LUNES(DATE()+3)
? LUNES(DATE()+2)
INKEY(0)

CLEAR
? "VIERNES()"
?
? VIERNES(DATE())      //
? VIERNES(DATE()+3)
? VIERNES(DATE()+2)
INKEY(0)


CLEAR
? "SUMAMES()"
DATA=CTOD("21/04/91")
@ 13,10 SAY SUMAMES(DATA)
@ 14,10 SAY SUMAMES(DATA ,1)
@ 15,10 SAY SUMAMES(DATA ,12)
INKEY(0)


******************************************************
FUNCTION INIMESSIG(data1)
ano= YEAR(data1 )
mes= MONTH(data1 )+1
dia= "01"
IF mes=13
   ano=ano+1
   mes=1
ENDIF
ano=STR(ano-1900,2)
mes=STR(mes,2)
final=CTOD((dia+"/"+mes+"/"+ano))
RETURN ( final)

******************************************************
FUNCTION FINMES(data1)
ano= YEAR(data1 )
mes= MONTH(data1 )+1
dia= "01"
IF mes=13
   ano=ano+1
   mes=1
ENDIF
ano=STR(ano-1900,2)
mes=STR(mes,2)
final=CTOD((dia+"/"+mes+"/"+ano))
RETURN ( final-1)

******************************************************
FUNCTION INIMES(data1)
RETURN (data1 - DAY(data1 )+1)

******************************************************
FUNCTION INISEM(data1)
IF DOW(data1 )=1    &&  SI FUERA DOMINGO RESTAR 6 DIAS
   final=data1 -6
ELSE
   final= data1 -(DOW(data1 )-2)
ENDIF
RETURN (final)

****************************************************
FUNCTION FINSEM(data1)
IF DOW(data1 )=2
   final = data1 +4
ELSE
   final=data1 + (6-DOW(data1 ))
ENDIF
RETURN (final)

***************************************************
FUNCTION FINANO(data1)
ano=YEAR(data1 )-1900
final=CTOD("31/12/"+STR(ano,2))
RETURN (final)

**************************************************
FUNCTION INIANO(data1)
ano=YEAR(data1 )-1900
final=CTOD("01/01/"+STR(ano,2))
RETURN (final)

**************************************************
FUNCTION DIATEX(data1)
dia=DOW(data1 )
SEMANA={"Domingo","Lunes","Martes","Miercoles",;
        "Jueves","Viernes","Sabado"}
RETURN (SEMANA[DIA])

*************************************************
FUNCTION FECHATEX(data1,cidade)
IF CIDADE=NIL
   CIDADE="SAO PAULO"
ENDIF
mes=MONTH(data1 )
m:={"Enero","Febrero","Marzo","Abril","Mayo",;
    "Junio","Julio","Agosto","Septiembre","Octubre","Noviembre",;   
    "Diciembre"}                                                    
RETURN (cidade+", "+STR(DAY(data1 ),2)+" de "+m[mes]+" de ";
   +STR(YEAR(data1 ),4))

***********************************************************
FUNCTION MESTEX(data1)
mes=MONTH(data1)
m:={"Enero","Febrero","Marzo","Abril","Mayo",;
    "Junio","Julio","Agosto","Septiembre","Octubre","Noviembre",;   
    "Diciembre"}                                                    
RETURN (m[mes])

********************************************************
FUNCTION LUNES(data1)
IF DOW(data1 )=7
   data1=data1 +2
ENDIF
IF DOW(data1 )=1
   data1=data1 +1
ENDIF
RETURN (DTOC(data1))

***********************************************************
FUNCTION VIERNES(data1)
IF DOW(data1 )=7
   data1=data1 -1
ENDIF
IF DOW(data1 )=1
   data1=data1 -2
ENDIF
RETURN (DTOC(data1))

*************************************************
FUNCTION FIESTAS(data1 ,aumenta)
IF AUMENTA=NIL
   aumenta=.F.
ENDIF
feriados=ARRAY(10)
ano=RIGHT(DTOC(DATA1),2)
feriados[1]=CTOD("01/01/"+ano)
feriados[2]=CTOD("07/09/"+ano)
feriados[3]=CTOD("15/11/"+ano)
feriados[4]=CTOD("12/10/"+ano)
feriados[5]=CTOD("21/04/"+ano)
IF ascan(feriados,data1 )=0
   datanova=data1
ELSE
   datanova=data1 +IIF(aumenta,1,-1)
ENDIF
RETURN (datanova)


**********************************************
FUNCTION SABDOM(data1)
IF DOW(data1)= 1 .OR. DOW(data1 )=7
   RETURN (.T.)
ELSE
   RETURN (.F.)
ENDIF

*********************************************************
FUNCTION MODFECHA
SAVE SCREEN
CLEAR
IF .NOT. FILE("C:\COMMAND.COM")
   @ 09,19,14,68 BOX REPL(chr(219),8)+" "
   @ 11,21 SAY "IMPOSIBLE EJECUTAR, FALTA EL ARCHIVO"
   @ 12,21 SAY "COMMAND.COM NO ESTA DIRECTORIO ESPECIFICADO"
   INKEY(2)
   RESTORE SCREEN
   RETURN(.F.)
ENDIF
IF MEMORY(2)<100
   @ 09,19,14,61 BOX REPL(CHR(219),8)+" "
   @ 11,21 SAY "IMPOSIBLE EJECUTAR, FALTA MEMORIA"
   @ 12,21 SAY "100 kB SON NECESARIOS. EXISTEN: "+STR(MEMORY(2),3)
   INKEY(2)
   RESTORE SCREEN
   RETURN(.F.)
ENDIF
RUN DATE
RESTORE SCREEN
RETURN (.T.)
***************************************
FUNCTION BUSCAFECHA(data1 ,lin1,col1)
IF LIN1=NIL
   lin1=ROW()
ENDIF
IF COL1=NIL
   col1=COL()
ENDIF
SET cursor OFF
teste=0
DO WHILE .T.
   @ lin1,col1 GET data1
   CLEAR GETS
   teste=INKEY(0)
   IF teste=13 .OR. teste=27
      EXIT
   ENDIF
   IF teste=5 .OR. teste = 24
      data1= data1 +IF(teste=5,1,-1)
   ENDIF
   IF TESTE=18 .OR. TESTE=3
      DATA1=DATA1+IF(TESTE=18,30,-30)
   ENDIF
ENDDO
SET cursor ON
VARIAVEL=READVAR()
&VARIAVEL=DATA1
RETURN .T.
  
********************************************
FUNCTION SUMAMES(data1 ,meses)
IF MESES=NIL
   MESES = 0
ENDIF
mes=MONTH(data1 ) + meses
dia= DAY(data1 )
ano=YEAR(data1 )
DO WHILE mes>12
   mes=mes-12
   ano=ano+1
ENDDO
novadata=CTOD(STR(dia,2)+'/'+STR(mes,2)+'/'+STR(ano,4))
RETURN (novadata)
           
           



                                                                                            