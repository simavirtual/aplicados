*
* T_EXAM22.PRG
*                 *** Manual Scaling Dates ***
*
FLIP_INIT(6000)
SET_SAYERR(1)

nFont1 = FONT_OPEN("\FLIPPER\FONTS\OE2_38.@")
nFont2 = FONT_OPEN("\FLIPPER\FONTS\SS2_22.@")

INITDATA(2)
SET_TYPE(1,1)
SET_STYLE(1,4)
SET_LN_PAT(1,4)

STORE_DATA( CTOD("01 20 89"), 240 )
STORE_DATA( CTOD("02 15 89"), 350 )
STORE_DATA( CTOD("03 12 89"), 760 )
STORE_DATA( CTOD("04 26 89"), 620 )
STORE_DATA( CTOD("05 24 89"), 540 )
STORE_DATA( CTOD("06 21 89"), 570 )
STORE_DATA( CTOD("07 29 89"), 200 )
STORE_DATA( CTOD("08 30 89"), 150 )
STORE_DATA( CTOD("09 14 89"), 210 )
STORE_DATA( CTOD("10 17 89"), 300 )
STORE_DATA( CTOD("11 18 89"), 440 )
STORE_DATA( CTOD("12 22 89"), 580 )

SET_G_FONT(nfont1)
SET_L_FONT(nFont2)

G_LABEL("MANUALLY SCALING DATES")
X_LABEL("Month")
Y_LABEL("Profits (thousands)")

SET_XGONE(1)
SET_XTICK(0)

PLOT()

DO Date_XScale

INKEY(0)
TEXTMODE()
RETURN

PROCEDURE Date_XScale
   FOR x = 2 to 13
      if x > 12
         nHold = x
         x = 1
         dDate = CTOD(ltrim(str(x)) + "/01/90")-1
         x = nHold
      else
         dDate = CTOD(ltrim(str(x)) + "/01/89")-1
      endif
      mMonth = SUBSTR(CMONTH(dDate),1,3) + ". " + LTRIM(STR(DAY(dDate)))
      xPos  = ATX(dDate,1)
      FLINE (xPos, ABS_YMAX(), xPos, ABS_YMAX() + 3, 15 )
      VERT_LINE( dDate )
      IF ROUND(X/2,0) = ROUND((X-1)/2,0)
         X_SCALE(mMonth,dDate)
      ENDIF
   NEXT X
RETURN
