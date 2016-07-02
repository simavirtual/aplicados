*********** Sample programs for Nantucket Tools II / 5.01 *********
*
* Program     : DISPFONT.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 10/23/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Display of the bit pattern within a font string
*               character per character
* Compiling   : CLIPPER DISPFONT
* Linking     : RTLINK FI DISPFONT LIB NT250
* Remarks     : /
*
*******************************************************************


CLS

 ?  "Pixel height of font     ", NTOC(CHARPIX(), 10, 2)
 ?
 WAIT "Press any key to continue ....."

 cVar = GETFONT()

 j := 0
 nKey   = INKEY()

 DO WHILE j <= 255 .AND. nKey  <> 27
  CLS

  ? ; ? "Character: ", CHR(j) ; ?
  ? " First byte of character ", NTOC(j * CHARPIX() +1)
  ?

  FOR i = 1 TO CHARPIX()
  cChar = SUBSTR(cVar, j*CHARPIX() +i, 1)
  ? SPACE(10) + "Byte", NTOC(i, 10, 2), "   ", NTOC(ASC(cChar), 2, 8, "0")
  NEXT I

  ? ; ? "Press any key to continue - Esc to cancel"
  nKey := INKEY(0)

  ++j
 ENDDO
RETURN
