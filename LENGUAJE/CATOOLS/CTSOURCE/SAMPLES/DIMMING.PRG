*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : DIMMING.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 08/10/90
* Author      : Lothar Bongartz / Michael Peters
* Description : Bright and dark on VGA-adapters
* Compiling   : CLIPPER DIMMING
* Linking     : RTLINK FI DIMMING LIB CT
* Remarks     : /
*
*******************************************************************

 PUBLIC red, blue, green  // former palette setting for 1 color

 COLOROUT("w")            // white becomes black
 SET COLOR TO             // output = white on black
 ? "HELLO"                // for former and future outputs

 COLORLIGHT("w", 2000)    // turn on color white within 2 seconds
 INKEY(1)
 COLORDARK("w", 2000)     // turn off color white within 2 seconds
 INKEY(1)

 COLORON("w")             // color white is white again
                          // otherwise VGAPALETTE("w") for default white

RETURN

*-------------------------

FUNCTION COLOROUT(cColor)

 red   := _RED(cColor)        // save former settings
 green := _GREEN(cColor)
 blue  := _BLUE(cColor)

 VGAPALETTE(cColor, 0, 0, 0)  // now black
RETURN(NIL)

*-------------------------

FUNCTION COLORON(cColor)
 VGAPALETTE(cColor, red, green, blue)   // former settings
RETURN(NIL)

*-------------------------

FUNCTION COLORDARK(cColor, nMilliSecs)
LOCAL i, n

 FOR i = 62 TO 0 STEP -1                // former value=63
  n := i /63
  VGAPALETTE(cColor, n *red, n *green, n *blue)
  MILLISEC(nMilliSecs /63)
 NEXT i
RETURN(NIL)

*-------------------------

FUNCTION COLORLIGHT(cColor, nMilliSecs)
LOCAL i, n

 FOR i = 1 TO 63                        // former value=0
   n := i /63
   VGAPALETTE(cColor, n *red, n *green, n *blue)
   MILLISEC(nMilliSecs /63)
 NEXT i
RETURN(NIL)