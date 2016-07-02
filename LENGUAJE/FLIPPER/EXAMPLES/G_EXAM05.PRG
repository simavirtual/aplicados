*
* T_EXAM05  ( Page 1-13 )
*
FLIP_INIT(1000)
SET_SAYERR(1)
CLEAR SCREEN
mFont1 = FONT_OPEN("\FLIPPER\FONTS\TTL8_48.@")
mFont2 = FONT_OPEN("\FLIPPER\FONTS\OE3_22.@")
mFont3 = FONT_OPEN("\FLIPPER\FONTS\SSD1_20.@")

M_x = 68                            && Position in %
M_y = 18                            && Position in %
M_orient = 1                        && 0-horizontal, 1-vertical
M_just   = 0                        && horizontal: 0-start, 1-center, 2-end
M_align  = 0                        && vertical: 0-start, 1-center, 2-end
M_dist   = 0                        && box distance from legend
M_legdist= 0                        && in addition to default between labels
M_pat    = 1                        && pattern for column one
m_bk     = -1                       && legend box inside color

DO WHILE .T.
   @ 14,0 SAY 'X position (0-100%):     'GET M_x PICT '999'
   @ 15,0 SAY 'Y position (0-100%):     'GET M_y PICT '999'
   @ 16,0 SAY 'Column 1 pattern: (1-10) 'GET M_pat PICT '99'
   @ 17,0 SAY 'Background color:        'GET M_bk PICT '99'
   @ 18,0 SAY 'Orientation:   0,1:      'GET M_orient PICT '9'
   @ 19,0 SAY 'Justification: 0,1,2: 'GET M_just PICT '9'
   @ 20,0 SAY 'Alignment:     0,1,2: 'GET M_align PICT '9'
   @ 21,0 SAY 'Frame distance:       'GET M_dist PICT '99'
   @ 22,0 SAY 'Legend distance:      'GET M_legdist PICT '99'
   READ

   IF LASTKEY()=27
      EXIT
   ENDIF

   INITDATA(7)
   GRF_COLORS(.f.,.f.,.f.,.f.,.f.,M_bk)

   SET_TYPE(1,1)

   SET_STYLE(1,0)
   SET_LN_PAT(1,M_pat)

   SET_TYPE(2,1)
   SET_TYPE(3,1)
   SET_TYPE(4,1)
   SET_TYPE(5,1)
   SET_TYPE(6,1)

   STORE_DATA("IBM",    10, 200, 100, 76, .58, 24)
   STORE_DATA("MAC",    9,  180, 90,  69, .63, 21)
   STORE_DATA("COMPAQ", 5,  125, 60,  48, .41, 13)
   STORE_DATA("AMIGA",  7,  105, 50,  45, .22, 10)
   STORE_DATA("EPSON",  4,  40,  34,  -5, .24, 11)

   G_LABEL("COMPUTER SALES")
   X_LABEL("Computer Company")
   Y_LABEL("in Millions")
   LEGEND_SET(1,"Computers Sold")
   LEGEND_SET(2,"Computer Sales")
   LEGEND_SET(3,"Overhead minus wages")
   LEGEND_SET(4,"Profits")
   LEGEND_SET(5,"No. of workers")
   LEGEND_SET(6,"Total wages")

   SET_G_FONT(mFont1)
   SET_L_FONT(mFont2)
   SET_S_FONT(mFont3)

   PLOT()

   SET_S_FONT(1)
   LEGEND_SAY( ATX(M_x,2), ATY(M_y,2), M_orient, M_just, M_align, M_dist, M_legdist)

   INKEY(0)
   TEXTMODE()

ENDDO