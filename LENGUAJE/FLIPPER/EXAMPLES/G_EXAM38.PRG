*******************************************************************************
*  G_EXAM38.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the use of the PAINTAREA() function.  This *
*        function is used to fill a shape on the screen with a certain color. *
*  Chapter 10, Special Drawing Functions                                      *
*******************************************************************************
FLIP_INIT(500)
SET_SAYERR(1)
M_pat=1
M_bound=2
DO WHILE .T.
   CLEAR
   TEXT
   *************************************************************************
   *  PAINTAREA(x,y,color,boundary)                                        *
   *                                                                       *
   *     x -        X Axis location                                        *
   *     y -        Y Axis location                                        *
   *     color -    Fill color                                             *
   *     boundary - Fill color                                             *
   *************************************************************************
   ENDTEXT
   @ 22,0 SAY 'Pattern #: 'GET M_pat pict '9' RANGE 0,15
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
   FSCREEN()
   FBOX( 100, 100, 200, 200, M_bound )
   PAT_SETFILL( M_pat )
   FILLAREA( 160, 160, 14, M_bound)
   PAT_SETFILL( 0 )
   INKEY(0)
   TEXTMODE()
ENDDO
