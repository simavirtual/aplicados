*
* T_EXAM11.PRG
*                 *** Point Graphs ***
*                 *** Regression Lines ***
*
FLIP_INIT(6000)
SET_SAYERR(1)

nFont1 = FONT_OPEN("\FLIPPER\FONTS\RMN7_25.@")
nFont2 = FONT_OPEN("\FLIPPER\FONTS\SS2_22.@")

INITDATA(2)

USE T_EXAM11
DO WHILE .NOT. EOF()
   STORE_DATA(XCOLUMN, YCOLUMN2)
   SKIP
ENDDO

SET_TYPE(1,5)
SET_STYLE(1,3)

SET_G_FONT(nfont1)
SET_L_FONT(nFont2)

G_LABEL("POINT SCALE WITH REGRESSION LINE")
X_LABEL("X Scale")
Y_LABEL("Y Scale")

PLOT()

REGRESS(1)
cYInter = ltrim(str(RET_YINTER()))         && Y intecept
cYCoef  = ltrim(str(RET_COEF()))           && correlation coefficient r squared
cCoefR  = ltrim(str(RET_R()))              && correlation coefficient r
cSlope  = ltrim(str(RET_SLOPE()))          && slope of the line

FONT_NEW(2)
SAY_TEXT(ATX(12,2),ATY(14,2), "Y intercept : "+cYInter)
SAY_TEXT(ATX(12,2),ATY(18,2), "R Squared   : "+cYCoef )
SAY_TEXT(ATX(12,2),ATY(22,2), "R           : "+cCoefR )
SAY_TEXT(ATX(12,2),ATY(26,2), "Slope       : "+cSlope )

INKEY(0)
TEXTMODE()
