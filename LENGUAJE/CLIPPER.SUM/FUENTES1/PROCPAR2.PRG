**** PROGRAMA: PROCPAR2.PRG
CLEAR
sombra(1,1,10,10)
sombra(5,40,20,70)
sombra(12,4,14)
sombra(17)
sombra(16,3)
INKEY(0)

**************************************************
PROCEDURE sombra(ls,cs,li,ci)
DO CASE
   CASE PCOUNT() < 2
	error = SAVESCREEN(23,0,23,79)
	@23,10 SAY "Numero de parametros invalidos..."
        INKEY(3)
	RESTSCREEN(23,0,23,79,error)
        RETURN
   CASE PCOUNT() < 3
        ci = MAXCOL() - 1
        li = MAXROW() - 2
   CASE PCOUN() < 4
        ci = MAXCOL() - 1
ENDCASE
@ls+1,cs+1,li+1,ci+1 BOX REPL(CHR(219),9)
@ls,cs,li,ci BOX CHR(201)+CHR(205)+CHR(187)+CHR(186)+;
                 CHR(188)+CHR(205)+CHR(200)+CHR(186)+CHR(32)