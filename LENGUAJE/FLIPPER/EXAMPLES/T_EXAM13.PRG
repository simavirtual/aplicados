*
* T_EXAM13.PRG
*                 *** Point Graphs ***
*                   *** SPLINE() ***
*
FLIP_INIT(6000)
SET_SAYERR(1)

nFont1 = FONT_OPEN("\FLIPPER\FONTS\RMN7_25.@")
nFont2 = FONT_OPEN("\FLIPPER\FONTS\SS2_22.@")

INITDATA(4)

USE T_EXAM11
DO WHILE .NOT. EOF()
   STORE_DATA(XCOLUMN, YCOLUMN1, YCOLUMN2, YCOLUMN3)
   SKIP
ENDDO

SET_STYLE(1,6)
SET_STYLE(2,6)
SET_STYLE(3,6)

SET_G_FONT(nfont1)
SET_L_FONT(nFont2)

G_LABEL("POINT SCALE WITH SPLINE CURVES")
X_LABEL("X Scale")
Y_LABEL("Y Scale")

M_col = 1
M_begin = 0
M_end = 0

DO WHILE .T.
   SET_TYPE(M_col,5)

   PLOT()

   SPLINE( M_col )

   INKEY(0)
   TEXTMODE()

   BUFF_LIMIT( @M_begin, @M_end )

   @ 11,10 SAY "Enter the column to use "
   @ 12,10 SAY "Enter the beginning row - current "+str(M_begin) GET M_begin PICTURE "@K 99" RANGE 0, RET_COUNT()-1
   @ 13,10 SAY "Enter the end row       - current "+str(M_end) GET M_end PICTURE "@K 99" RANGE 2, RET_COUNT()
   READ

   IF LASTKEY() = 27
      EXIT
   ENDIF

   BUFF_LIMIT( M_begin, M_end )

ENDDO
