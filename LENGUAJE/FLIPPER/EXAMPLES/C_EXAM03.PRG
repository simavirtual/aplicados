*******************************************************************************
*  C_EXAM03.PRG                                                               *
*  Requirements: Microsoft Compatible Mouse                                   *
*  Description:                                                               *
*        Below is a list of the functions demonstrated in this program.  They *
*        represent most of the mouse interface, and can also be used to scan  *
*        for keys pressed on the key-board.                                   *
*                                                                             *
*  MS_RESET()                      Set mouse driver on                        *
*  MS_CURSOR( cursor_type )        Cursor shape                               *
*  MS_CURON()                      Turn cursor on                             *
*  MS_CUROFF()                     Turn cursor off                            *
*  MS_HALT()                       Halt mouse driver (IMPORTANT before exit)  *
*                                                                             *
*  POS_SIZE( size, decimals )      Decimal precison of cursor position        *
*  POS_ATTR( horz, vert, font )    Cursor position placement                  *
*  POS_COLOR( fg_color, bg_color)  Cursor position color                      *
*  POS_REFER( [ horz, vert ] )     Cursor reference coordinates               *
*                                     No parameters set reference to origin   *
*  POS_ONOFF( on_or_off, region )  Set position on or off and active region   *
*                                                                             *
*  KEY_MACRO("123")                Send key presses (like KEYBOARD in Clipper)*
*  TIME_SET( time, repeat )        Set a timer event to occur every           *
*                                  (Second*18.2) and repeat every (sec.*18.2) *
*  MS_REPEAT( Delay, additional )  When holding mouse button repeat last press*
*                                                                             *
*  KEY_PRESS()                     Waits for event to occur                   *
*                                                                             *
* Functions to determine what event caused key press to release               *
*-----------------------------------------------------------------------------*
*  KP_BUTTON()                     Which button pressed                       *
*  KP_SCAN()                       Key scan code                              *
*  KP_ASCII()                      Key ascii code                             *
*  KP_ABS_X()                      X Cursor position at time of event         *
*  KP_ABS_Y()                      Y Cursor position at time of event         *
*  KP_SCALE_X()                    X scaled cursor position at key press      *
*  KP_SCALE_Y()                    Y scaled cursor position at key press      *
*                                                                             *
*  KP_FLAGS(1)                     Right shift pressed?                       *
*  KP_FLAGS(2)                     Left shift pressed?                        *
*  KP_FLAGS(3)                     Crtl shift pressed?                        *
*  KP_FLAGS(4)                     Alt pressed?                               *
*  KP_FLAGS(5)                     Scroll lock on?                            *
*  KP_FLAGS(6)                     Num lock on?                               *
*  KP_FLAGS(7)                     Caps lock on?                              *
*  KP_FLAGS(8)                     Insert on?                                 *
*                                                                             *
*  KP_MSTATE(1)                    Location change?                           *
*  KP_MSTATE(2)                    Left button press?                         *
*  KP_MSTATE(3)                    Left button release?                       *
*  KP_MSTATE(4)                    Right button press?                        *
*  KP_MSTATE(5)                    Right button release?                      *
*  KP_MSTATE(6)                    Middle button press?                       *
*  KP_MSTATE(7)                    Middle button release?                     *
*                                                                             *
*  KP_TIME()                       Time last timer event occurred             *
*  Chapter 12, Using a Mouse
*******************************************************************************
FLIP_INIT(1)
CLEAR SCREEN
SET_SAYERR(1)
FSCREEN()
*
M_buttons=MS_RESET()
IF M_buttons=0
   @ 22,0 SAY 'No mouse driver'
   inkey(0)
   quit
ENDIF
MS_CURSOR(7)                     && Starting cursor
MS_CURON()
*
FONT_NEW(1)
i=0
pressed=0
*
* Placement and attributes for current position of mouse
*
POS_SIZE()                       && No parameters - automatic sizing
POS_ATTR(0,45,1)                 && x, y, font
POS_COLOR(15,0)                  && fg, bg
POS_REFER()                      && Cursor reference coordinates
*                                   No parameters set reference to origin
POS_ONOFF(1,0)                   && Set on_or_off, position region
*
KEY_MACRO("123")                 && Send key presses
TIME_SET(10*18.2,1)              && TIMER_SET(time, repeat) Time=Seconds*18.2
MS_REPEAT( 9, 5 )                && Delay before first repeat, additional delay
*
DO WHILE KP_ASCII() != 27
   M_event=KEY_PRESS()
   MS_CUROFF()
   SAY_FIXED(1, 1, 1, 7, 0, 'Event type =   '+STR(M_event,3,0) )
   SAY_FIXED(2, 1, 1, 7, 0, 'Mouse Button = '+STR(KP_BUTTON(),3,0) )
   SAY_FIXED(3, 1, 1, 7, 0, 'Scan code =    '+STR(KP_SCAN(),3,0) )
   SAY_FIXED(4, 1, 1, 7, 0, 'Ascii code =   '+STR(KP_ASCII(),3,0) )
   SAY_FIXED(5, 1, 1, 7, 0, 'Absolute x,y = '+STR(KP_ABS_X(),3,0)+','+STR(KP_ABS_Y(),3,0) )
   SAY_FIXED(6, 1, 1, 7, 0, 'Scaled x,y =   '+STR(KP_SCALE_X(),5,1)+','+STR(KP_SCALE_Y(),5,1) )

   SAY_FIXED(7, 1, 1, 7, 0, 'Right shift =  '+STR(KP_FLAGS(1),6,0))
   SAY_FIXED(8, 1, 1, 7, 0, 'Left shift =   '+STR(KP_FLAGS(2),6,0))
   SAY_FIXED(9, 1, 1, 7, 0, 'Crtl shift =   '+STR(KP_FLAGS(3),6,0))
   SAY_FIXED(10, 1, 1, 7, 0, 'Alt =          '+STR(KP_FLAGS(4),6,0))
   SAY_FIXED(11, 1, 1, 7, 0, 'Scroll lock =  '+STR(KP_FLAGS(5),6,0))
   SAY_FIXED(12, 1, 1, 7, 0, 'Num lock =     '+STR(KP_FLAGS(6),6,0))
   SAY_FIXED(13, 1, 1, 7, 0, 'Caps lock =    '+STR(KP_FLAGS(7),6,0))
   SAY_FIXED(14, 1, 1, 7, 0, 'Insert =       '+STR(KP_FLAGS(8),6,0))

   SAY_FIXED(7, 41, 1, 7, 0, 'Location change =       '+STR(KP_MSTATE(1),6,0))
   SAY_FIXED(8, 41, 1, 7, 0, 'Left button press =     '+STR(KP_MSTATE(2),6,0))
   SAY_FIXED(9, 41, 1, 7, 0, 'Left button release =   '+STR(KP_MSTATE(3),6,0))
   SAY_FIXED(10, 41, 1, 7, 0, 'Right button press =    '+STR(KP_MSTATE(4),6,0))
   SAY_FIXED(11, 41, 1, 7, 0, 'Right button release =  '+STR(KP_MSTATE(5),6,0))
   SAY_FIXED(12, 41, 1, 7, 0, 'Middle button press =   '+STR(KP_MSTATE(6),6,0))
   SAY_FIXED(13, 41, 1, 7, 0, 'Middle button release = '+STR(KP_MSTATE(7),6,0))
   IF M_event = 16
      SAY_FIXED(16, 1, 1, 7, 0, 'Timer Hit!! = '+STR(KP_TIME(),6,0) )
   ENDIF
   MS_CURON()
ENDDO
*
MS_CUROFF()
MS_HALT()
*
TEXTMODE()
