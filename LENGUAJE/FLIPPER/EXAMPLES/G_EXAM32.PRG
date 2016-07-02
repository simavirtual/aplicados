*******************************************************************************
*  G_EXAM32.PRG                                                               *
*  Requirements: None                                                         *
*  Description:                                                               *
*        This program demonstrates the rotation of a pie chart using the      *
*        PIE_ROTATE() command.                                                *
*  Chapter 3, Customizing the Graph                                           *
*******************************************************************************
FLIP_INIT(600)
SET_SAYERR(1)
*
INITDATA(2)
M_out=0
*
STORE_DATA("< 1",83)
STORE_DATA("1-5",124)
STORE_DATA("6-10",89)
STORE_DATA("11-18",45)
STORE_DATA("19-55",34)
STORE_DATA("> 55",125)
*
M_rotate=83/2  && half of the first value, Flipper calculates the radians
DO WHILE .T.
   CLEAR SCREEN
   TEXT

          Data Values     Accumulated   Center of Slice
          -----------     -----------   ---------------
              83              83             42.5
             124             207            145
              89             296            251.5
              45             341            318.5
              34             375            358
             125             500            437.5

   ENDTEXT
   @ 22,0 SAY 'Rotation (data value): 'GET M_rotate PICT '999.9'
   READ
*
   IF LASTKEY()=27
      EXIT
   ENDIF

   PIE_ROTATE(M_rotate)   && Enter as a data value
   PIE(1)
*
   inkey(0)
*
   TEXTMODE()
ENDDO