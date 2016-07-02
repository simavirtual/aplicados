*
*  Testing scroll bar
*
FLIP_INIT(1000)
SET_SAYERR(1)
*
M_buttons = MS_RESET()
IF M_buttons = 0
   @ 10,10 SAY 'No mouse driver!'
   INKEY(0)
   QUIT
ENDIF
*
FSCREEN()
MS_WINDOW(0,0,ATX(100,2),ATY(100,2))
SCROLL_BAR( 0, 100, 200, 200, 6, 12, 10 )
SCROLL_BAR( 1, 100, 200, 400, 7, 12, 10 )
MS_CURON()
FONT_COLOR(1,1,0)
DO WHILE .T.
   KEY_PRESS()
   IF KP_ASCII()=27
      EXIT
   ENDIF
   M_but1=SCROLL_HOT(0)
   M_but2=SCROLL_HOT(1)
   IF M_but1 > 0
      SAY_TEXT(10,30,STR( M_but1, 2 ) )
   ENDIF
   IF M_but2 > 0
      SAY_TEXT(10,60,STR( M_but2, 2 ) )
   ENDIF
ENDDO
MS_HALT()
TEXTMODE()