*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : FALLING.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 12/13/90
* Author      : Lothar Bongartz
* Description : Screen effects with rows
* Compiling   : CLIPPER FALLING
* Linking     : RTLINK FI FALLING, CTUS LIB CT
* Remarks     : /
*
*******************************************************************

 CLS
 FOR i = 0 TO 24 STEP 2
  SAYTOP("Row  : " + STR(i, 2), i, 5)
 NEXT i

  INKEY(0)

 CLS
 FOR i = 24 TO 0 STEP -2
  SAYTOP("Row  : " + STR(i, 2), i, 5)
 NEXT i
RETURN

 FUNCTION SAYTOP
 PARAMETERS cRowText, nRow, nCol
  LOCAL i
  nNumCol := LEN(cRowText)

  FOR i = 0 TO nRow -1
   cOldRowText := SCREENSTR(i, nCol, nNumCol)
   @ i, nCol SAY cRowText
   MILLISEC(MAXROW() -i)
   STRSCREEN(cOldRowText, i, nCol)
  NEXT i

  @ nRow, nCol SAY cRowText
 RETURN(.T.)
