*
* T_EXAM14.PRG
*                 *** Point Graphs ***
*                 *** POLYSHOW() / POLYFIT() ***
*
FLIP_INIT(6000)
SET_SAYERR(1)

nFont1 = FONT_OPEN("\FLIPPER\FONTS\RMN7_25.@")
nFont2 = FONT_OPEN("\FLIPPER\FONTS\SS2_22.@")

INITDATA(2)

USE T_EXAM11
DO WHILE .NOT. EOF()
   STORE_DATA(XCOLUMN, YCOLUMN3)
   SKIP
ENDDO

SET_TYPE(1,5)
SET_STYLE(1,6)

SET_G_FONT(nfont1)
SET_L_FONT(nFont2)

G_LABEL("POINT SCALE WITH POLYPLOT")
X_LABEL("X Scale")
Y_LABEL("Y Scale")

M_degree = 3

DO WHILE .T.

   PLOT()
   POLY_FIT( 1, M_degree )

   SAY_TEXT(ATX(12,1), ATY(10,2), "RET_R2() = "+LTRIM(STR(RET_R2())))
   SAY_TEXT(ATX(12,1), ATY(13,2), "RET_DF() = "+LTRIM(STR(RET_DF())))
   SAY_TEXT(ATX(12,1), ATY(16,2), "RET_NUM() = "+LTRIM(STR(RET_NUM())))
   Y = 21
   FOR X = 1 to M_degree
      Y = Y + 3
      IF RET_BCOEF(X) = 0
         M_coef      = 0
         M_exponent  = 0
      ELSE
         M_coef      = SCI_NOT(RET_BCOEF(X))
         M_exponent  = RET_EXPON()
      ENDIF
      SAY_TEXT(ATX(12,1),ATY(Y,2),"RET_BCOEF("+LTRIM(STR(X));
         +") = "+LTRIM(STR(M_coef))+" EXP "+LTRIM(STR(M_exponent)))
   NEXT X

   INKEY(0)
   TEXTMODE()
   @ 10,10 SAY "Enter the degrees of freedom "
   @ 10,40 GET M_degree PICTURE "@K 9" RANGE 2,8
   READ
   IF LASTKEY() = 27
      EXIT
   ENDIF

ENDDO
