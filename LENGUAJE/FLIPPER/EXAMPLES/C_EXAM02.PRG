*******************************************************************************
*  C_EXAM02.PRG                                                               *
*  Requirements: Microsoft Mouse                                              *
*  Description:                                                               *
*        This example demonstrates various mouse functions.  It demonstrates  *
*        mouse regions and changing the mouse pointer when it enters another  *
*        mouse region.  It demonstrates how to display mouse coordinates and  *
*        edit the attributes for the text that will display the attributes.   *
*        It also demonstrates a use for KEY_PRESS().                          *
*  Chapter 12, Using a Mouse                                                  *
*******************************************************************************
FLIP_INIT(1,1)                   && Initialize flipper
CLEAR SCREEN
*
M_display = RET_DISPLY()
M_mode = RET_CARD()
*
DO WHILE .T.
   @ 20,0 SAY 'Display: 'GET M_display PICT '9'
   @ 21,0 SAY 'Mode:    'GET M_mode PICT '99'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   SET_DISPLY(M_display)
   GRAPHMODE(M_mode)
*
   FSCREEN()                        && To graphics mode
*
   vh=SETUP_MAP()                   && Setup program
*
   KEY_PRESS()                      && Get some keyboard or mouse event
*
   UN_SETUP(vh)                     && Restore back to pre-setup
   TEXTMODE()
ENDDO

****************************************************************
*
*  Setup program to handle mouse and display cursor position
*
****************************************************************

FUNCTION SETUP_MAP

M_buttons=MS_RESET()             && Setup mouse driver
IF M_buttons=0                   && Check button number not zero
   @ 22,0 SAY 'No mouse driver'
   inkey(0)
   quit
ENDIF
*
CLS_SCREEN(15)                    && Clear graphics screen to white
*
vw_handle=VIEW_OPEN(ATX(11,2), ATY(10,2), ATX(95,2), ATY(95,2) , 0, 0)
SET_WORLD(1000,0,0,0,1,-1)   && setup square coordinate system
*
* Placement and attributes for current position of mouse
*
POS_SIZE()                       && No parameters - automatic sizing
POS_ATTR( 0, 0, 1 )              && x, y, font
POS_COLOR(0,15)                  && fg, bg
POS_REFER()                      && Cursor reference coordinates
*                                   No parameters set reference to origin
POS_ONOFF(1,1)                   && Set position and region on or off
*
* Set up cursor regions
*
MS_CURSOR(7)                     && Starting cursor
REGN_INIT(1)
REGN_SET( 1, ATX(0,2), ATY(0,2), ATX(100,2), ATY(100,2), 0, 8)
*
MS_SETXY( 200, 200)              && Set cursor positioning
MS_CURON()                       && Turn mouse cursor on
*
RETURN(vw_handle)                && Return from function

FUNCTION UN_SETUP
PARAMETER vw_handle
VIEW_CLOSE(vw_handle)            && Close viewport
MS_HALT()                        && End mouse interupt routine
