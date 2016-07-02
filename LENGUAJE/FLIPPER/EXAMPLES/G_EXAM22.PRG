*******************************************************************************
*  G_EXAM22.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*       This is a simple example of a using the mouse with a graph. The mouse *
*       is used to mark a beginning and ending X axis value. Click the left   *
*       mouse button and pull a cut box. Click left button again to erase the *
*       box. The edges of the box are return with RET_STR_X(), RET_END_X().   *
*       If no value is passed, the coordinate is in world system. If a value  *
*       is passed, then it return absolute mouse position.                    *
*******************************************************************************
FLIP_INIT(6000)
*
M_buttons=MS_RESET()             && Setup mouse driver
IF M_buttons=0                   && Check button number not zero
   @ 22,0 SAY 'No mouse driver. >Tap any key to quit<'
   inkey(0)
   quit
ENDIF
REGN_INIT(1)
*
USE TEST
INITDATA(2)
*
SET_TYPE(1,1)
*
DO WHILE .NOT. EOF()
   @ 23,0 SAY STORE_DATA(XNUMBER,NUMBER1)
   SKIP
ENDDO
*
FSCREEN()
MS_CURON()
G_LABEL("Button 1: mark start & end,  Button 2: return to original,  Escape to quit")
DO WHILE .T.
   PLOT()
   REGN_SET( 1, ABS_XMIN(), ABS_YMIN(), ABS_XMAX(), ABS_YMAX(), 2 )
   MS_WINDOW( ABS_XMIN(), ABS_YMIN(), ABS_XMAX(), ABS_YMAX() )

   M_event=KEY_PRESS()
   DO CASE
      CASE KP_BUTTON() = 1
         M_result = MS_OBJECT(1,7,-1,2)
         SAY_FIXED( 10,3,2,15,1,'X Start:'+STR(ABS_TO_X(RET_STR_X(1),1),6,2);
                             +', X End:'+STR(ABS_TO_X(RET_END_X(1),1),6,2))
         AUTO_SCALE( 1, ABS_TO_X(RET_STR_X(1),1), ABS_TO_X(RET_END_X(1),1) )
         CLS_SCREEN()
      CASE KP_BUTTON()=2
         AUTO_SCALE( 0 )                   && turn off X limit
         CLS_SCREEN()
      CASE KP_ASCII()=27
         EXIT
   ENDCASE
ENDDO
*
MS_HALT()                        && End mouse interupt routine
TEXTMODE()
