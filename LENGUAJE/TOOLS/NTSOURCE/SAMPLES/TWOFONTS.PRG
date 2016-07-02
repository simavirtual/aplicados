*********** Sample programs for Nantucket Tools II / 5.0 ************
*
* Program     : TWOFONTS.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 12/22/90
* Author      : Michael Peters / Lothar Bongartz
* Description : Up to 512 different characters (2 Fonts) on the
*               screen at the same time.
* Compiling   : CLIPPER TWOFONTS
* Linking     : RTLINK FI TWOFONTS LIB NT250
*
* Remarks     :
*
* Using two fonts up to 512 different characters can be
* presented on the screen AT THE SAME TIME.
* That is possible, because a font for intensive output and
* a font for normal output can be active at the same time.
*
* In the following example standard-characters for selection
* of a 'non-highlighted' color and ITALIC-characters for
* selection of a 'highlighted' color will be used.
*
*********************************************************************

CLS

 * loading another font in an additional font area and
 * select as a font for intensive screen output.
 *
  IF ISVGA(.T.)
    IF "" = FILESEEK("ITALIC.016")
     ? ; ? "Please copy font file ITALIC.016 into current directory!"
    ELSE
     FONTLOAD("ITALIC.016", 2)
     FONTSELECT(1, 2)
     SHOWIT()
    ENDIF
  ELSE
   IF ISEGA(.T.)
    IF "" = FILESEEK("ITALIC.016")
     ? ; ? "Please copy font file ITALIC.014 into current directory!"
    ELSE
     FONTLOAD("ITALIC.014", 2)
     FONTSELECT(1, 2)
     SHOWIT()
    ENDIF
   ELSE
    ?
    ?
    ? "Can only be used on EGA- and VGA-adapters ! - Press key to continue!"
    INKEY(0)
   ENDIF
  ENDIF
 RETURN


 STATIC FUNCTION SHOWIT()
  *
  * To avoid the 'highlighted' presentation of the second font, the
  * equalization of the colors "W" and "W+" with the functions
  * EGA/VGAPALETTE() is not sufficient. An adaption of all colors
  * should be done!
  * With a special call of the function EGAPALETTE() the color plane
  * enable register of the attribute controller can be adjusted to
  * ignore the brightness bit.
  * Nevertheless the character generator is still accepting both
  * character sets.
  *
   EGAPALETTE("B+", "B")

    * Use of  'usual' characters
     SET COLOR TO R
     ? ; ? "font area 1   : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    * Use of  'highlighted' characters
     SET COLOR TO +B
     ? ; ? "font area 2   : ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

   * Using the first font again
    INKEY(5)
     SET COLOR TO B
     ? ; ? "font 2 highlighted again!"
     EGAPALETTE("B+")

  * Using font 1 for the highlighted output again
   INKEY(5)
    ? ; ? "same font for usual and highlighted !"
    FONTSELECT(1, 1)

   ?
   WAIT
 RETURN(Nil)

