FUNCTION ENTER_PNT
M_x=KP_SCALE_X()
M_y=KP_SCALE_Y()
VIEW_SWAP(0,0)
SET CURSOR ON
@ M_rows-1,10 SAY 'Enter Point: 'GET M_x PICT '999.9'
@ M_rows-1,col()+2 SAY ', 'GET M_y PICT '999.9'
READ

SET CURSOR OFF
@ M_rows-1,10 SAY SPACE(66)
VIEW_SWAP(vh,0)

DO CASE
   CASE LASTKEY() = 3
      ENTER_FLAG( 0 )         && Continue with no affect
   CASE LASTKEY() = 18
      ENTER_FLAG( 2 )         && Snap to closest object or grid
   CASE LASTKEY() = 27
      ENTER_FLAG( 3 )         && Cancel last add and exit
   OTHERWISE                  && 1 is equal to the default
      MOV_TO_PNT(M_x, M_y)
ENDCASE
