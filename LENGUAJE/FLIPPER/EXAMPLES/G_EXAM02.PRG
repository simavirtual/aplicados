*******************************************************************************
*  G_EXAM02.PRG                                                               *
*  Author: Gary Prothero                                                      *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the circle command of Flipper, and also the*
*        initialization of the graphics screen with FSCREEN().                *
*  Chapter 10, Special Drawing Functions                                      *
*******************************************************************************
FLIP_INIT(1000)
M_X = 100
M_Y = 100
M_RADIUS = 50
M_PATTERN = 0
DO WHILE .T.
   CLEAR
   @ 23,70 say 'Esc-exit'
   @ 10,10 SAY 'X:       'GET M_X PICT '999'
   @ 11,10 SAY 'Y:       'GET M_Y PICT '999'
   @ 12,10 SAY 'RADIUS:  'GET M_RADIUS PICT '999'
   @ 13,10 SAY 'PATTERN: 'GET M_PATTERN PICT '9'
   READ
   IF LASTKEY()=27
      EXIT
   ENDIF
*
   PAT_SETFIL( M_PATTERN )
   FSCREEN()
   FOR i = 1 to 10
      FCIRCLE(M_X+10*i,M_Y,M_RADIUS,i)
   NEXT
   INKEY(0)
*
   TEXTMODE()
ENDDO
