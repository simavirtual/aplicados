*******************************************************************************
*  G_EXAM35.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the low-level graph building    *
*        functions to create a customized graph.                              *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(32,0)
SET_SAYERR(1)

CLEAR SCREEN
*
M_side=1
M_adjust=0
M_color=1
M_color1=2
M_percent=0.25
M_style=3
M_y=3
M_x=450
*
DO WHILE .T.
   @ 17,0 SAY 'Side (1,2)  'GET M_side PICT '9'
   @ 18,0 SAY 'Adjustment  'GET M_adjust PICT '9'
   @ 20,0 say 'Bar percent 'GET M_percent PICT '9.99'
   @ 21,0 SAY 'Bar Color   'GET M_color1 PICT '99'
   @ 22,0 say 'Bar Style   'GET M_style PICT '9'
   @ 23,0 say 'Bar Y (1-6) 'GET M_y PICT '9'
   @ 24,0 say 'Bar X       'GET M_x PICT '999'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
* Draw scale to graphics screen
*
   INITDATA(2)
*
   STORE_DATA( 100, 1 )
   STORE_DATA( 500, 6 )
*
   SET_YSIZE( 13, M_side )       && Set Y label size to largest text label
   SET_YGONE(1, M_side)          && Set Y axis labels gone
   SET_TYPE( 1, 1 )              && Set column 1 type to 1 so it will scale
   SET_YSIDE( 1, M_side )        && Set side to M_side variable
*
   PLOT(2)                       && Say graph frame only
*
* Place Y labels on scale
*
   Y_SCALE("Portland",1)
   Y_SCALE("Boston",2)
   Y_SCALE("Atlanta",3)
   Y_SCALE("San Francisco",4)
   Y_SCALE("Los Angles",5)
   Y_SCALE("Washington DC",6)
*
* Draw various bars to scale
*
   HORZ_BAR( ATX(100,1), ATX(250,1), ATY(M_y,1), M_style, M_color1, M_percent)
   HORZ_BAR(ATX(250,1)+1, ATX(350,1), ATY(M_y,1), M_style, M_color1, M_percent)
   VERT_BAR( ATY(3,1), ATY(6,1), ATX(M_x,1), M_style, M_color1, M_percent)
   VERT_LINE(300)
*
* Draw lines and points to scale
*
   SAY_MARK( ATX(100,1), ATY(1,1), 1, 4)
   FLINE( ATX(100,1), ATY(1,1), ATX(300,1), ATY(5,1), 4, 0)
   SAY_MARK( ATX(300,1), ATY(5,1), 1, 4)
   FLINE( ATX(300,1), ATY(5,1), ATX(400,1), ATY(3,1), 4, 0)
   SAY_MARK( ATX(400,1), ATY(3,1), 1, 4)
   inkey(0)
*
   TEXTMODE()
ENDDO
