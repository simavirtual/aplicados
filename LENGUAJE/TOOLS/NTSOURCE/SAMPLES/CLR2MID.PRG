*********** Sample programs for Nantucket Tools II / 5.01 ********
*
* Program     : CLR2MID.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 12/12/90
* Author      : Lothar Bongartz
* Description : Clear to the middle of the screen
* Compiling   : CLIPPER CLR2MID
* Linking     : RTLINK FI CLR2MID, NT2US50 LIB NT250
* Remarks     : /
*
*******************************************************************

CLEAR SCREEN

 FOR i = 1 TO MAXROW() -2
  ? "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
 NEXT i

 ClearToMid(15, 3, 5, 20, 66)

 @ MAXROW(), 0 SAY CENTER("screen has been cleared to the middle  Ù")
 INKEY(0)
 CLEAR SCREEN
RETURN

***************************
* Funktion Clear To Middle
*
FUNCTION ClearToMid
PARAMETERS nDelay, nTop, nLeft, nBottom, nRight

 DO WHILE nLeft <= nRight
  CLEARWIN(nTop, nLeft, nBottom, nLeft)
  CLEARWIN(nTop, nRight, nBottom, nRight)
  MILLISEC(nDelay)
  nLeft  = nLeft  +1
  nRight = nRight -1
 ENDDO

RETURN("")

