
***********************************************************
** PROGRAMA  : PRUEBA1.PRG
** FINALIDAD:  PROBAR FUNCIONES DE MODIFICACION DE PANTALLA
***********************************************************

CLEAR
SET SCORE OFF
EMPRESA="MEGATRON" ; PROGRAMA= "MENU" ; SISTEMA="PRUEBA"

@ 0,0 TO 24,79
LOGO("MEGATRON",1,10)
LOGO("ASSESSORIA",7,04)
LOGO("      E   ",13,04)
LOGO("TREINAMENTO",19,02)
INKEY(0)


SAVSTRV()
TELAPADRAO(PROGRAMA)
RECSTRV()
INKEY(0)


SAVSTRH()
TELAPADRAO(PROGRAMA)
RECSTRH()
INKEY(0)


SAVZOOM5()
TELAPADRAO(PROGRAMA)
RECZOOM5()
INKEY(0)


SAVSQR16()
TELAPADRAO(PROGRAMA)
INKEY(0)
RECSQR16(1)
INKEY(0)
TELAPADRAO(PROGRAMA)
INKEY(0)
RECSQR16(2)
INKEY(0)


SAVSQR8()
TELAPADRAO(PROGRAMA)
INKEY(0)
RECSQR8(1)
INKEY(0)
TELAPADRAO(PROGRAMA)
INKEY(0)
RECSQR8(2)
INKEY(0)


SAVSQR4()
TELAPADRAO(PROGRAMA)
INKEY(0)
RECSQR4(1)
INKEY(0)
TELAPADRAO(PROGRAMA)
INKEY(0)
RECSQR4(2)
INKEY(0)


SAVHOR2()
TELAPADRAO(PROGRAMA)
INKEY(0)
RECHOR2(1)
INKEY(0)
TELAPADRAO(PROGRAMA)
INKEY(0)
RECHOR2(2)
INKEY(0)
TELAPADRAO(PROGRAMA)
INKEY(0)
RECHOR2(3)
INKEY(0)

SAVVER2()
TELAPADRAO(PROGRAMA)
INKEY(0)
RECVER2(1)
INKEY(0)
TELAPADRAO(PROGRAMA)
INKEY(0)
RECVER2(2)
INKEY(0)


*************************************************************
*TIPO......:  FUNCION                                       *
*SINTAXIS...: LOGO(<expC>)                                  *
*PARAMETROS: EXPC  - TEXTO A SER EXPANDIDO                  *
*UTILIDAD : GENERA LETRAS GIGANTES CON EL TEXTO PASADO, EN  *
*           80 COLUMNAS PUEDEN APARECER HASTA 12 CARACTERES *
*************************************************************
FUNCTION  LOGO(TEXTO,LIN,COL)
LOCAL L1,L2,L3,L4,L5,g[6,36]

IF LEN(TEXTO) >11
   @ 23,10 SAY "HASTA 11 CARACTERES SON PERMITIDOS EN EL TEXTO"
   INKEY(3)
   RETURN(.F.)
ENDIF
IF LIN=NIL
   LIN=10
ENDIF
IF COL=NIL
   COL=1
ENDIF

G[1,1]="A"
G[2,1]="пллллп "
G[3,1]="л    л "
G[4,1]="лллллл "
G[5,1]="л    л "
G[6,1]="л    л "

G[1,2]="B"
G[2,2]="лллллп "
G[3,2]="л    л "
G[4,2]="ллллл  "
G[5,2]="л    л "
G[6,2]="лллллм "

g[1,3]="C"
G[2,3]="лллллл "
G[3,3]="л      "
G[4,3]="л      "
G[5,3]="л      "
G[6,3]="лллллл "

G[1,4]="D"
G[2,4]="лллллп "
G[3,4]="л    л "
G[4,4]="л    л "
G[5,4]="л    л "
G[6,4]="лллллм "

G[1,5]="E"
G[2,5]="лллллл "
G[3,5]="л      "
G[4,5]="ллллл  "
G[5,5]="л      "
G[6,5]="лллллл "

G[1,6]="F"
G[2,6]="лллллл "
G[3,6]="л      "
G[4,6]="ллл    "
G[5,6]="л      "
G[6,6]="л      "

G[1,7]="G"
G[2,7]="лллллл "
G[3,7]="л    м "
G[4,7]="л  ллл "
G[5,7]="л    л "
G[6,7]="лллллл "

G[1,8]="H"
G[2,8]="л    л "
G[3,8]="л    л "
G[4,8]="лллллл "
G[5,8]="л    л "
G[6,8]="л    л "

G[1,9]="I"
G[2,9]="  ллл  "
G[3,9]="   л   "
G[4,9]="   л   "
G[5,9]="   л   "
G[6,9]="  ллл  "

g[1,10]="J"
G[2,10]="     л "
G[3,10]="     л "
G[4,10]="     л "
G[5,10]="л    л "
G[6,10]="лллллл "

G[1,11]="K"
G[2,11]="л    л "
G[3,11]="л  пм  "
G[4,11]="ллл    "
G[5,11]="л  мп  "
G[6,11]="л    л "

G[1,12]="L"
G[2,12]="л      "
G[3,12]="л      "
G[4,12]="л      "
G[5,12]="л    л "
G[6,12]="лллллл "

G[1,13]="M"
G[2,13]="ллнолл "
G[3,13]="л но л "
G[4,13]="л но л "
G[5,13]="л лл л "
G[6,13]="л    л "

G[1,14]="N"
G[2,14]="лн   л "
G[3,14]="лон  л "
G[4,14]="л он л "
G[5,14]="л  онл "
G[6,14]="л   ол "

G[1,15]="O"
G[2,15]="лллллл "
G[3,15]="л    л "
G[4,15]="л    л "
G[5,15]="л    л "
G[6,15]="лллллл "

G[1,16]="P"
G[2,16]="лллллп "
G[3,16]="л    л "
G[4,16]="лллллм "
G[5,16]="л      "
G[6,16]="л      "

G[1,17]="Q"
G[2,17]="лллллл "
G[3,17]="л    л "
G[4,17]="л    л "
G[5,17]="л    л "
G[6,17]="мммммл "

G[1,18]="R"
G[2,18]="лллллп "
G[3,18]="л    л "
G[4,18]="лллллм "
G[5,18]="л  ллп "
G[6,18]="л    л "

G[1,19]="S"
G[2,19]="лллллл "
G[3,19]="л      "
G[4,19]="лллллл "
G[5,19]="     л "
G[6,19]="лллллл "

G[1,20]="T"
G[2,20]="лллллл "
G[3,20]="  лл   "
G[4,20]="  лл   "
G[5,20]="  лл   "
G[6,20]="  лл   "

G[1,21]="U"
G[2,21]="л    л "
G[3,21]="л    л "
G[4,21]="л    л "
G[5,21]="л    л "
G[6,21]="лллллл "
     
G[1,22]="V"
G[2,22]="л    л "
G[3,22]="л    л "
G[4,22]="л    л "
G[5,22]=" л  л  "
G[6,22]="  он   "

G[1,23]="X"
G[2,23]="л    л "
G[3,23]="он  он "
G[4,23]="  лл   "
G[5,23]="он  он "
G[6,23]="л    л "

G[1,24]="Y"
G[2,24]="л    л "
G[3,24]="л    л "
G[4,24]=" л  л  "
G[5,24]="  лл   "
G[6,24]="  лл   "
      
G[1,25]="W"
G[2,25]="л    л "
G[3,25]="л лл л "
G[4,25]="л но л "
G[5,25]="л но л "
G[6,25]="ллнолл "
      
G[1,26]="Z"
G[2,26]="лллллл "
G[3,26]="     л "
G[4,26]="лллллм "
G[5,26]="л      "
G[6,26]="лллллл "

G[1,27]="1"      
G[2,27]="  лл   "
G[3,27]="   л   "
G[4,27]="   л   "
G[5,27]="   л   "
G[6,27]="  ллл  "

G[1,28]="2"      
G[2,28]="лллллл "
G[3,28]="     л "
G[4,28]="лллллл "
G[5,28]="л      "
G[6,28]="лллллл "

G[1,29]="3"      
G[2,29]="лллллп "
G[3,29]="     л "
G[4,29]="ллллл  "
G[5,29]="     л "
G[6,29]="лллллм "

G[1,30]="4"      
G[2,30]="л    л "
G[3,30]="л    л "
G[4,30]="лллллл "
G[5,30]="     л "
G[6,30]="     л "

G[1,31]="5"      
G[2,31]="лллллл "
G[3,31]="л      "
G[4,31]="лллллл "
G[5,31]="     л "
G[6,31]="лллллл "

G[1,32]="6"      
G[2,32]="лл     "
G[3,32]="л      "
G[4,32]="лллллл "
G[5,32]="л    л "
G[6,32]="лллллл "

G[1,33]="7"      
G[2,33]="лллллл "
G[3,33]="     л "
G[4,33]="     л "
G[5,33]="     л "
G[6,33]="     л "

G[1,34]="8"      
G[2,34]="лллллл "
G[3,34]="л    л "
G[4,34]="лллллл "
G[5,34]="л    л "
G[6,34]="лллллл "

G[1,35]="9"      
G[2,35]="лллллл "
G[3,35]="л    л "
G[4,35]="лллллл "
G[5,35]="     л "
G[6,35]="    лл "

G[1,36]="0"      
G[2,36]="лллллл "
G[3,36]="л  л л "
G[4,36]="л л  л "
G[5,36]="лл   л "
G[6,36]="лллллл "

L1:= L2:= L3:= L4:= L5:=""

Z=1
DO WHILE Z<=LEN(TEXTO)
   LETRA=upper(SUBS(TEXTO,Z,1))
   IF LETRA=" "
      L1=L1+SPACE(5)
      L2=L2+SPACE(5)
      L3=L3+SPACE(5)
      L4=L4+SPACE(5)
      L5=L5+SPACE(5)
   ELSE
      indice=ASCAN(g[1],letra)
      IF INDICE<>0
         L1+=g[2,INDICE]
         L2+=G[3,INDICE]
         L3+=G[4,INDICE]
         L4+=G[5,INDICE]
         L5+=G[6,INDICE]
      ENDIF
   ENDIF
   Z=Z+1
ENDDO
@ LIN++,COL SAY L1
@ LIN++,COL SAY L2
@ LIN++,COL SAY L3
@ LIN++,COL SAY L4
@ LIN++,COL SAY L5
RETURN NIL






FUNCTION SAVHOR2
PUBLIC mT[2]
mT[1]=SAVESCREEN(0,0,11,79)
mT[2]=SAVESCREEN(12,0,24,79)
RETURN NIL

FUNCTION RECHOR2(nMOV)
IF nMOV=NIL
   nMOV=1
ENDIF
DO CASE
CASE nMOV=1
   FOR I=0 TO 79
      RESTSCREEN(0,0,11,I,mT[1])
   NEXT
   FOR I = 79 TO 0 STEP -1
      RESTSCREEN(12,I,24,79,mT[2])
   NEXT
CASE nMOV=2
   FOR I=0 TO 11
      RESTSCREEN(0,0,I,79,mT[1])
      INKEY(.05)
   NEXT
   FOR I = 24 TO 12 STEP -1
      RESTSCREEN(I,0,24,79,mT[2])
      INKEY(.05)
   NEXT
CASE nMOV=3
   FOR I=11 TO 0 STEP -1
      RESTSCREEN(I,0,11,79,mT[1])
      INKEY(.05)
   NEXT
   FOR I = 12 TO 24
      RESTSCREEN(12,0,I,79,mT[2])
      INKEY(.05)
   NEXT
ENDCASE
*******RELEASE mT
RETURN NIL
  
FUNCTION SAVVER2
PUBLIC mT[2]
mT[1]=SAVESCREEN(0,0,24,39)
mT[2]=SAVESCREEN(0,40,24,79)
RETURN NIL
  
  
FUNCTION RECVER2(nMOV)
IF nMOV=NIL
   nMOV=1
ENDIF
DO CASE
CASE nMOV=1
   FOR I=0 TO 39
      RESTSCREEN(0,0,24,I,mT[1])
   NEXT
   FOR I = 79 TO 40 STEP -1
      RESTSCREEN(0,I,24,79,mT[2])
   NEXT
CASE nMOV=2
   FOR I=0 TO 24
      RESTSCREEN(0,0,I,39,mT[1])
      INKEY(.01)
   NEXT
   FOR I = 24 TO 0 STEP -1
      RESTSCREEN(I,40,24,79,mT[2])
      INKEY(.01)
   NEXT
ENDCASE
*** RELEASE MT
RETURN NIL
  
FUNCTION SAVSQR4()
PUBLIC mT[4]
mT[1]=SAVESCREEN(00,00,11,39)
mT[2]=SAVESCREEN(00,40,11,79)
mT[3]=SAVESCREEN(12,00,24,39)
mT[4]=SAVESCREEN(12,40,24,79)
  
FUNCTION RECSQR4(nMOV)
IF nMOV=NIL
   nMOV=1
ENDIF
DO CASE
CASE nMOV=1
   RESTSCREEN(00,00,11,39,mT[1])
   INKEY(.25)
   RESTSCREEN(00,40,11,79,mT[2])
   INKEY(.25)
   RESTSCREEN(12,00,24,39,mT[3])
   INKEY(.25)
   RESTSCREEN(12,40,24,79,mT[4])
CASE nMOV=2
   RESTSCREEN(00,00,11,39,mT[1])
   INKEY(.25)
   RESTSCREEN(12,40,24,79,mT[4])
   INKEY(.25)
   RESTSCREEN(12,00,24,39,mT[3])
   INKEY(.25)
   RESTSCREEN(00,40,11,79,mT[2])
   INKEY(.25)
ENDCASE
*** RELEASE mT
RETURN NIL

FUNCTION SAVSQR8()
PUBLIC mT[8]
mT[1]=SAVESCREEN(00,00,11,19)
mT[2]=SAVESCREEN(00,20,11,39)
mT[3]=SAVESCREEN(00,40,11,59)
mT[4]=SAVESCREEN(00,60,11,79)
mT[5]=SAVESCREEN(12,00,24,19)
mT[6]=SAVESCREEN(12,20,24,39)
mT[7]=SAVESCREEN(12,40,24,59)
mT[8]=SAVESCREEN(12,60,24,79)

FUNCTION RECSQR8(nMOV)
IF nMOV=NIL
   nMOV=1
ENDIF
DO CASE
CASE nMOV=1
   RESTSCREEN(00,00,11,19,mT[1])
   INKEY(.25)
   RESTSCREEN(00,40,11,59,mT[3])
   INKEY(.25)
   RESTSCREEN(00,20,11,39,mT[2])
   INKEY(.25)
   RESTSCREEN(00,60,11,79,mT[4])
   INKEY(.25)
   RESTSCREEN(12,00,24,19,mT[5])  
   INKEY(.25)
   RESTSCREEN(12,40,24,59,mT[7])
   INKEY(.25)
   RESTSCREEN(12,20,24,39,mT[6])
   INKEY(.25)
   RESTSCREEN(12,60,24,79,mT[8])
CASE nMOV=2
   RESTSCREEN(00,00,11,19,mT[1])
   INKEY(.25)
   RESTSCREEN(12,20,24,39,mT[6])
   INKEY(.25)
   RESTSCREEN(00,40,11,59,mT[3])
   INKEY(.25)
   RESTSCREEN(12,60,24,79,mT[8])
   INKEY(.25)
   RESTSCREEN(00,60,11,79,mT[4])
   INKEY(.25)
   RESTSCREEN(12,40,24,59,mT[7])
   INKEY(.25)
   RESTSCREEN(00,20,11,39,mT[2])
   INKEY(.25)
   RESTSCREEN(12,00,24,19,mT[5])  
ENDCASE
*** RELEASE mT
RETURN NIL 

FUNCTION SAVSQR16()
PUBLIC mT[16]
mT[01]=SAVESCREEN(00,00,05,19)
mT[02]=SAVESCREEN(00,20,05,39)
mT[03]=SAVESCREEN(00,40,05,59)
mT[04]=SAVESCREEN(00,60,05,79)
mT[05]=SAVESCREEN(00,00,12,19)
mT[06]=SAVESCREEN(00,20,12,39)
mT[07]=SAVESCREEN(00,40,12,59)
mT[08]=SAVESCREEN(00,60,12,79)
mT[09]=SAVESCREEN(13,00,18,19)
mT[10]=SAVESCREEN(13,20,18,39)
mT[11]=SAVESCREEN(13,40,18,59)
mT[12]=SAVESCREEN(13,60,18,79)
mT[13]=SAVESCREEN(19,00,24,19)
mT[14]=SAVESCREEN(19,20,24,39)
mT[15]=SAVESCREEN(19,40,24,59)
mT[16]=SAVESCREEN(19,60,24,79)


FUNCTION RECSQR16(nMOV)
IF nmov=nil
   nmov=1
ENDIF
DO CASE   
CASE nMOV=1
  RESTSCREEN(00,60,05,79,mT[4])
  INKEY(.1)
  RESTSCREEN(00,40,05,59,mT[3])
  INKEY(.1)
  RESTSCREEN(06,60,12,79,mT[8])
  INKEY(.1)
  RESTSCREEN(00,20,05,39,mT[2])
  INKEY(.1)
  RESTSCREEN(06,40,12,59,mT[7])
  INKEY(.1)
  RESTSCREEN(13,60,18,79,mT[12])
  INKEY(.1)
  RESTSCREEN(00,00,05,19,mT[1])
  INKEY(.1)
  RESTSCREEN(06,20,12,39,mT[6])
  INKEY(.1)
  RESTSCREEN(13,40,18,59,mT[11])
  INKEY(.1)
  RESTSCREEN(19,60,24,79,mT[16])
  INKEY(.1)
  RESTSCREEN(06,00,12,19,mT[5])
  INKEY(.1)
  RESTSCREEN(13,20,18,39,mT[10])
  INKEY(.1)
  RESTSCREEN(19,40,24,59,mT[15])
  INKEY(.1)
  RESTSCREEN(13,00,18,19,mT[9])
  INKEY(.1)
  RESTSCREEN(19,20,24,39,mT[14])
  INKEY(.01)
  RESTSCREEN(19,00,24,19,mT[13])
CASE nMOV=2
  INKEY(.1)
  RESTSCREEN(00,00,05,19,mT[1])
  INKEY(.1)
  RESTSCREEN(00,20,05,39,mT[2])
  INKEY(.1)
  RESTSCREEN(00,40,05,59,mT[3])
  INKEY(.1)
  RESTSCREEN(00,60,05,79,mT[4])
  INKEY(.1)
  RESTSCREEN(06,60,12,79,mT[8])
  INKEY(.1)
  RESTSCREEN(13,60,18,79,mT[12])
  INKEY(.1)
  RESTSCREEN(19,60,24,79,mT[16])
  INKEY(.1)
  RESTSCREEN(19,40,24,59,mT[15])
  INKEY(.1)
  RESTSCREEN(19,20,24,39,mT[14])
  INKEY(.1)
  RESTSCREEN(19,00,24,19,mT[13])
  INKEY(.1)
  RESTSCREEN(13,00,18,19,mT[9])
  INKEY(.1)
  RESTSCREEN(06,00,12,19,mT[5])
  INKEY(.1)
  RESTSCREEN(06,20,12,39,mT[6])
  INKEY(.1)
  RESTSCREEN(06,40,12,59,mT[7])
  INKEY(.1)
  RESTSCREEN(13,40,18,59,mT[11])
  INKEY(.1)
  RESTSCREEN(13,20,18,39,mT[10])
ENDCASE
*** RELEASE mT
RETURN NIL

FUNCTION SAVZOOM5()
PUBLIC mT[5]
mT[1]=SAVESCREEN(00,00,24,79)
mT[2]=SAVESCREEN(03,10,21,70)
mT[3]=SAVESCREEN(06,20,18,60)
mT[4]=SAVESCREEN(09,30,15,50)
mT[5]=SAVESCREEN(11,35,13,45)

FUNCTION RECZOOM5
  RESTSCREEN(11,35,13,45,mT[5])
  INKEY(.25)
  RESTSCREEN(09,30,15,50,mT[4])
  INKEY(.25)
  RESTSCREEN(06,20,18,60,mT[3])
  INKEY(.25)
  RESTSCREEN(03,10,21,70,mT[2])
  INKEY(.25)
  RESTSCREEN(00,00,24,79,mT[1])
*** RELEASE mT
RETURN NIL

FUNCTION SAVSTRH()
PUBLIC mT[5]
mT[1]=SAVESCREEN(00,00,04,79)
mT[2]=SAVESCREEN(05,00,09,79)
mT[3]=SAVESCREEN(10,00,14,79)
mT[4]=SAVESCREEN(15,00,19,79)
mT[5]=SAVESCREEN(20,00,24,79)

FUNCTION RECSTRH
  RESTSCREEN(20,00,24,79,mT[5])
  INKEY(.25)
  RESTSCREEN(10,00,14,79,mT[3])
  INKEY(.25)
  RESTSCREEN(00,00,04,79,mT[1])
  INKEY(.25)
  RESTSCREEN(05,00,09,79,mT[2])
  INKEY(.25)
  RESTSCREEN(15,00,19,79,mT[4])
*** RELEASE mT
RETURN NIL

FUNCTION SAVSTRV()
PUBLIC mT[5]
mT[1]=SAVESCREEN(00,00,24,16)
mT[2]=SAVESCREEN(00,17,24,32)
mT[3]=SAVESCREEN(00,33,24,48)
mT[4]=SAVESCREEN(00,49,24,64)
mT[5]=SAVESCREEN(00,65,24,79)

FUNCTION RECSTRV
FOR I = 0 TO 24
   RESTSCREEN(00,00,I,16,mT[1])
   INKEY(.01)
NEXT
FOR I= 24 TO 0 STEP -1
   RESTSCREEN(I,17,24,32,mT[2])
   INKEY(.01)
NEXT
FOR I = 0 TO 24
   RESTSCREEN(00,33,I,48,mT[3])
   INKEY(.01)
NEXT
FOR I = 24 TO 0  STEP -1
   RESTSCREEN(I,49,24,64,mT[4])
   INKEY(.01)
NEXT
FOR I = 0 TO 24
   RESTSCREEN(00,65,I,79,mT[5])
   INKEY(.01)
NEXT
*** RELEASE mT
RETURN NIL



FUNCTION TELAPADRAO(PROGRAMA)
CLEAR
@0,0 TO 3,39 double
@0,40 TO 3,79 double
@4,0,21,79 box REPLICATE(CHR(176),9)
@4,0 TO 21,79
@22,0 TO 24,79 double
@1,1 SAY empresa
@1,41 SAY sistema
@1,73 SAY LEFT(TIME(),5)
@2,41 SAY programa
@2,70 SAY DATE()
@23,1 SAY "MENSAJE:"

RETURN nil




