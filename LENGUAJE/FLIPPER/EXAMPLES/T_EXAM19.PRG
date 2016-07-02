*
* T_EXAM19.PRG
*                 *** Parsing the buffer ***
*                 *** Optional PLOT() parameters ***
*                 *** Making seperate graphs for seperate columns ***
*
FLIP_INIT(6000)
SET_SAYERR(1)

nFont1 = FONT_OPEN("\FLIPPER\FONTS\SS2_42.@")
nFont2 = FONT_OPEN("\FLIPPER\FONTS\OE2_38.@")
nFont3 = FONT_OPEN("\FLIPPER\FONTS\SS2_22.@")
nFont4 = FONT_OPEN("\FLIPPER\FONTS\SCR3_19.@")


INITDATA(4)

USE T_EXAM18
DO WHILE .NOT. EOF()
   STORE_DATA( XCOLUMN, YCOLUMN1, YCOLUMN2, YCOLUMN3 )
   SKIP
ENDDO

SET_G_FONT(nfont1)
SET_L_FONT(nFont2)
G_LABEL("PARSING THE BUFFER")
X_LABEL("X Axis")
Y_LABEL("Y Axis")

SET_AREA(1,1,100,50)
DO plot_it WITH 1

SET_AREA(1,50,50,100)
SET_G_FONT(nFont3)
SET_L_FONT(nFont4)
G_LABEL("AND GRAPHING EACH")
DO plot_it WITH 2

SET_AREA(50,50,100,100)
G_LABEL("Y COLUMN SEPERATELY")
DO plot_it WITH 3

TEXTMODE()
RETURN

PROCEDURE plot_it
   PARAMETER X
   DO CASE
      CASE X = 1
         SET_TYPE(1,1)
         SET_TYPE(2,0)
         SET_TYPE(3,0)
      CASE X = 2
         SET_TYPE(1,0)
         SET_TYPE(2,1)
         SET_TYPE(3,0)
      CASE X = 3
         SET_TYPE(1,0)
         SET_TYPE(2,0)
         SET_TYPE(3,1)
   ENDCASE

   PLOT(2)                       && Axis only to scale for entire buffer

   SET_LN_PAT(X,0)
   SET_STYLE(X,1)
   BUFF_LIMIT(1,6)
   PLOT(1)
   INKEY(0)

   SET_LN_PAT(X,1)
   BUFF_LIMIT(7,12)
   PLOT(1)
   INKEY(0)

   SET_LN_PAT(X,2)
   SET_STYLE(X,3)
   BUFF_LIMIT(13,18)
   PLOT(1)
   INKEY(0)
RETURN
