*********** Sample programs for Nantucket Tools II / 5.01 ************
*
* Program     : FONTROTA.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 10/22/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Rotation of characters on the screen
* Compiling   : CLIPPER FONTROTA
* Linking     : RTLINK FI FONTROTA,NT2US50 LIB NT250
* Bemerkungen : Demonstration of the function FONTROTATE()
*
*******************************************************************

CLS

 CSETREF(.T.)         // Optimizing of the reference method

 IF .NOT. ISVGA()
  ?
  ? "The program can only be used with VGA-adapters!"
  ?
 ELSE
  nOldMode := GETSCRMODE()

   VGA50()

   FOR I = 0 TO MAXROW() -1
    @ I, 80 SAY CENTER("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890")
   NEXT i

   ? CENTER("press ESC to exit program")

   nPixel := CHARPIX()
   cFont  := GETFONT()

   nKey   := 0

   DO WHILE nKey   <> 27
    nMode  := RANDOM() %4 +1
    FONTROTATE(@cFont, nMode, nPixel, (nPixel-8)/2)
    SETFONT(cFont)

    nKey   := INKEY(0.5)
  ENDDO
  SETSCRMODE(nOldMode)
 ENDIF
RETURN
