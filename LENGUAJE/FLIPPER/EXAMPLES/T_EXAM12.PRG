*
* T_EXAM12.PRG
*                 *** Point Graphs ***
*                 *** Regression Lines with Log Scales ***
*
FLIP_INIT(6000)
SET_SAYERR(1)

nFont1 = FONT_OPEN("\FLIPPER\FONTS\OE2_38.@")
nFont2 = FONT_OPEN("\FLIPPER\FONTS\SS2_22.@")

INITDATA(2)

USE T_EXAM11
DO WHILE .NOT. EOF()
   STORE_DATA(XCOLUMN, YCOLUMN1)
   SKIP
ENDDO

SET_TYPE(1,5)
SET_STYLE(1,3)

SET_G_FONT(nfont1)
SET_L_FONT(nFont2)

G_LABEL("LINEAR SCALE")
X_LABEL("X Scale")
Y_LABEL("Y Scale")

SET_AREA(1,1,50,100)
PLOT()

REGRESS(1)
cYInter = ltrim(str(RET_YINTER()))         && Y interupt
cYCoef  = ltrim(str(RET_COEF()))           && correlation coefficient r squared
cCoefR  = ltrim(str(RET_R()))              && correlation coefficient r
cSlope  = ltrim(str(RET_SLOPE()))          && slope of the line

SAY_TEXT(ATX(13,1),ATY(14,2), "Y interupt : "+cYInter)
SAY_TEXT(ATX(13,1),ATY(16,2), "R Squared  : "+cYCoef )
SAY_TEXT(ATX(13,1),ATY(18,2), "R          : "+cCoefR )
SAY_TEXT(ATX(13,1),ATY(20,2), "Slope      : "+cSlope )

SET_AREA(50,1,100,100)
G_LABEL("LOG SCALE")
SET_YLOG(1)
PLOT()

REGRESS(1)
cYInter = ltrim(str(RET_YINTER()))         && Y interupt
cYCoef  = ltrim(str(RET_COEF()))           && correlation coefficient r squared
cCoefR  = ltrim(str(RET_R()))              && correlation coefficient r
cSlope  = ltrim(str(RET_SLOPE()))          && slope of the line

SAY_TEXT(ATX(13,1),ATY(14,2), "Y interupt : "+cYInter )
SAY_TEXT(ATX(13,1),ATY(16,2), "R Squared  : "+cYCoef  )
SAY_TEXT(ATX(13,1),ATY(18,2), "R          : "+cCoefR  )
SAY_TEXT(ATX(13,1),ATY(20,2), "Slope      : "+cSlope  )

INKEY(0)
TEXTMODE()
