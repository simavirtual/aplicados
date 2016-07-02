*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : COLORPAL.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 11/20/90
* Author      : Lothar Bongartz, Michael Peters
* Description : Program for setting color palettes on EGA/VGA
* Compiling   : CLIPPER COLORPAL
* Linking     : RTLINK FI COLORPAL, CTUS LIB CT
* Remarks     : /
*
*********************************************************************

lEgaEmulation := .F.  // emulate EGA ?

* CGA80(.T.)          // black/white representation

DO CASE
 CASE ISMCGA() .AND. .NOT. lEgaEmulation  // MCGA emulates VGA palettes
   lVGA    := .T.
   nStep   :=  1
   nMaxPal := 63                          // 64 values: 0 to 63

   cSaveTab := FILESTR("_VGA_PAL.SAV")    // file with former values

   IF LEN(cSaveTab) = 48                  // 3 values for all 16 colors
     FOR i = 0 TO 15
       VGAPALETTE(i, ASCPOS(cSaveTab, i *3 +1 ),;
                     ASCPOS(cSaveTab, i *3 +2 ),;
                     ASCPOS(cSaveTab, i *3 +3 ))
     NEXT i
   ELSE
     cSaveTab := ""
   ENDIF

 CASE ISEGA()
   VGAPALETTE()                   // at EGA emulation back to VGA
   lVGA    := .F.
   nStep   := 21                  // coarser raster for EGA
   nMaxPal := 63                  // the 4 values: 0, 21, 42, 63

  * With EGA adapters, the color values can not be read.
  * Therefore, a little "book-keeping" is neccessary

   DECLARE aDefPal[16], aPalette[16]    // palettes for 16 colors
   DECLARE Red[4], Green[4], Blue[4]    // 4 levels for basic colors
   PUBLIC  EGA_RGB[3], EGA_RGBsum       // level for the 3 basic colors,
                                        // and their sum

   nColorCode := "rgbRGB"               // 6 Bit color coding
                                        // r =red, b =blue, g =green
                                        // large:primary,small:secondary

   aDefPal[01] :=  0                    // CTOBIT("      ", nColorCode)
   aDefPal[02] :=  1                    // CTOBIT("     B", nColorCode)
   aDefPal[03] :=  2                    // CTOBIT("    G ", nColorCode)
   aDefPal[04] :=  3                    // CTOBIT("    GB", nColorCode)
   aDefPal[05] :=  4                    // CTOBIT("   R  ", nColorCode)
   aDefPal[06] :=  5                    // CTOBIT("   R B", nColorCode)
   aDefPal[07] := 20                    // CTOBIT(" g R  ", nColorCode)
   aDefPal[08] :=  7                    // CTOBIT("   RGB", nColorCode)
   aDefPal[09] := 56                    // CTOBIT("rgb   ", nColorCode)
   aDefPal[10] := 57                    // CTOBIT("rgb  B", nColorCode)
   aDefPal[11] := 58                    // CTOBIT("rgb G ", nColorCode)
   aDefPal[12] := 59                    // CTOBIT("rgb GB", nColorCode)
   aDefPal[13] := 60                    // CTOBIT("rgbR  ", nColorCode)
   aDefPal[14] := 61                    // CTOBIT("rgbR B", nColorCode)
   aDefPal[15] := 62                    // CTOBIT("rgbRG ", nColorCode)
   aDefPal[16] := 63                    // CTOBIT("rgbRGB", nColorCode)

   Red[    1]  :=  0                    // CTOBIT("      ", nColorCode)
   Red[    2]  := 32                    // CTOBIT("r     ", nColorCode)
   Red[    3]  :=  4                    // CTOBIT("   R  ", nColorCode)
   Red[    4]  := 36                    // CTOBIT("r  R  ", nColorCode)

   Green[  1]  :=  0                    // CTOBIT("      ", nColorCode)
   Green[  2]  := 16                    // CTOBIT(" g    ", nColorCode)
   Green[  3]  :=  2                    // CTOBIT("    G ", nColorCode)
   Green[  4]  := 18                    // CTOBIT(" g  G ", nColorCode)

   Blue[   1]  :=  0                    // CTOBIT("      ", nColorCode)
   Blue[   2]  :=  8                    // CTOBIT("  b   ", nColorCode)
   Blue[   3]  :=  1                    // CTOBIT("     B", nColorCode)
   Blue[   4]  :=  9                    // CTOBIT("  b  B", nColorCode)


   cSaveTab := FILESTR("_EGA_PAL.SAV")  // file with former values

   IF LEN(cSaveTab) = 16
     FOR i = 1 TO 16
       aPalette[i] := ASCPOS(cSaveTab, i)
       EGAPALETTE(i -1, aPalette[i])
     NEXT i
   ELSE
     cSaveTab := ""
     EGAPALETTE()                       // set to default value
     FOR i = 1 TO 16
       aPalette[I] := aDefPal[I]        // start current value with default
     NEXT i
   ENDIF
 OTHERWISE                              // neither MCGA, VGA, EGA
   ? "screen adapter does not have any color palette"
   QUIT
 ENDCASE

 IF KBDTYPE() < 2                       // if no separate cursor block,
  KSETNUM(.F.)                          // switch off Num Lock
 ENDIF

* The keyboard speed could be modified with KBDSPEED().
* But as the former state can not be saved and not be reset at the end
* of the program, the KBDSPEED() function has been marked with '*'!
*
* KBDSPEED(1, 2)                        // reduce keyboard delay

 _BLINK(.F.)                            // prevents blinking
                                        // at bright background
 DSETKBIOS(.T.)                         // keyboard via bios
 SETCANCEL(.F.)                         // no Alt-C
 SETKXLAT(3, 27)                        // Ctrl-C (not PgDn!) ==> Esc
 SETKXLAT(301, 27)                      // Alt-X ==> Esc

 CSETSNOW(.F.)                          // no 'snow' slow down
 SET CURSOR OFF                         // hardware cursor off
 SETPAGE(0)                             // 1st screen page active
 PAGECOPY(0, 1)                         // save 1st screen page

 SETCLEARB(" ")                         // byte for all CLEAR operations
 CLEAR                                  // clear screen completely

 ColorSet := 7                          // default color for window 0

 PUBLIC nPanel[3]                       // one red,one green and one
                                        // blue controller

 Block := 219                           // full block char. (a.o. controller)
 Line  := 196                           // character for controller lines
 Frame := CHR(Block)                    // mark box

 cUpArrow    := CHR(24)                 // arrows for marking on screen
 cDnArrow    := CHR(25)
 cRightArrow := CHR(26)
 cLeftArrow  := CHR(27)

 @ 0,0 SAY CENTER("CA-Clipper Tools - palette setting via " +;
           IIF(lVGA, "VGA", "EGA") +"PALETTE()")

 SETCLEARB(Block)                       // byte for all CLEAR operations
                                        // all pixel set for
                                        // foreground color

* layout of 16 color areas
*
 FOR i = 0 TO 7                                  // upper row
   WOPEN(3, (i +1) * 8, 6, (i +1) * 8 +7)        // one window per color
   cColor := NTOCOLOR(i) + "," + NTOCOLOR(15 -i) // for STANDARD(),ENHANCED()
   SET COLOR TO &cColor                          // window saves its color
   CLEAR
 NEXT i

 FOR i = 8 TO 15                                 // lower row
   WOPEN(8, (i -7) * 8,11, (i -7) * 8 +7)        // one window per color
   cColor := NTOCOLOR(i) + "," + NTOCOLOR(15 -i) // for STANDARD(), ENHANCED()
   SET COLOR TO &cColor                          // window saves its color
   CLEAR
 NEXT i

 WSELECT(0)                             // total screen for output
 SET COLOR TO                           // standard color setting (N/W)
 SETCLEARB(" ")                         // byte for all CLEAR operations

 @ 14,08 SAY "Color:"                   // 0 to 16
 @ 14,28 SAY "SET COLOR TO:"            // 1st parameter for xxxPALETTE()
 @ 14,62 SAY "Parameter:"               // 2nd (EGA) / 2nd ot 4th Parameter


* The three lines
*
 @ 16,02 SAY "R"                        // red
 @ 18,02 SAY "G"                        // green
 @ 20,02 SAY "B"                        // blue

 @ 16,08 SAY REPLICATE(CHR(Line), nMaxPal +1)
 @ 18,08 SAY REPLICATE(CHR(Line), nMaxPal +1)
 @ 20,08 SAY REPLICATE(CHR(Line), nMaxPal +1)


* The HELP line
*
 @ 22,00 SAY "ColorSelect  : Pg" +cUpArrow +cDnArrow
 @ 23,00 SAY "Default color: F2"
 @ 24,00 SAY "Default all  : F3"

 @ 22,20 SAY "R/G/B Select:" + cUpArrow +cDnArrow
 @ 23,20 SAY "Start color : F4"
 @ 24,20 SAY "Start all   : F5"

 @ 22,38 SAY "R/G/B: " +cLeftArrow +" " +cRightArrow  +" home end "
 @ 23,38 SAY "Copy of   color: F6"
 @ 24,38 SAY "Mix  with color: F7"

 @ 22,61 SAY "all  R/G/B: Alt " +cLeftArrow +" "+cRightArrow
 @ 23,61 SAY "HELP window : F1"
 @ 24,61 SAY "EndOfProgram: Esc"


* The color selection arrow
*
 nColor      := 0                        // starts at 'black'
 nColorLine  := 2
 cColorArrow := cDnArrow


* The arrow for R G B
*
 cRGB_Arrow := CHR(16)                   // delta character

 RGB := 1
 nRGB_Line := 16
 @ nRGB_Line, 5 SAY cRGB_Arrow

 DO load_RGB WITH nColor                // determine RGB setting

 nNewColor := nColor
 DO DoSetColor


**************************************************************************
*************************      MAIN LOOP     *****************************
**************************************************************************

 DO WHILE .T.
   nKey := INKEY(0)

   DO CASE
   CASE nKey = 19                               // left arrow
     DO res_shift                              // reset shift controller

      nPanel[RGB] := IIF(nPanel[RGB] > 0,nPanel[RGB] -nStep, nMaxPal)

     DO set_shift                              // set shift controller

   CASE nKey = 4                                // right arrow
     DO res_shift                              // reset shift controller

      nPanel[RGB] := IIF(nPanel[RGB] < nMaxPal, nPanel[RGB] +nStep, 0)

     DO set_shift                              // set shift controller

   CASE nKey =411                               // Alt left arrow
     DO res_RGB_shift                          // reset RGB shift contr.

      FOR i = 1 TO 3
        nPanel[i] := IIF(nPanel[i] > 0,nPanel[i] -nStep, 0)
      NEXT i

     DO set_RGB_shift                          // set RGB shift contr.

   CASE nKey = 413                              // Alt right arrow
     DO res_RGB_shift                          // reset RGB shift contr.

      FOR i = 1 TO 3
        nPanel[i] := IIF(nPanel[i] < nMaxPal, nPanel[i] +nStep, nMaxPal)
      NEXT i

     DO set_RGB_shift                          // set RGB shift contr.

   CASE nKey = -7                              // F8 key =random
     DO res_RGB_shift                          // reset RGB shift contr.

      FOR i = 1 TO 3
        nPanel[i] := (RANDOM() % (nMaxPal /nStep +1)) *nStep
      NEXT i

     DO set_RGB_shift                          // set RGB shift contr.

   CASE nKey = 1                               // home
     DO res_shift                              // reset shift controller
     nPanel[RGB] := 0                          // starting position
     DO set_shift                              // set shift controller

   CASE nKey = 6                               // End
     DO res_shift                              // reset shift controller
     nPanel[RGB] := nMaxPal                    // End position
     DO set_shift                              // set shift controller

   CASE nKey = 5                                // up arrow
     @ nRGB_Line, 5 SAY " "                     // reset former arrow
     RGB := IIF(RGB = 1, 3, RGB -1)             // 1 3 2 1 ...
     nRGB_Line := 14 + 2 * RGB                  // 16, 18 or 20
     @ nRGB_Line, 5 SAY cRGB_Arrow              // set new arrow

   CASE nKey = 24                               // down arrow
     @ nRGB_Line, 5 SAY " "                     // reset former arrow
     RGB := IIF(RGB = 3, 1, RGB +1)             // 3 1 2 3 ...
     nRGB_Line := 14 + 2 * RGB                  // 16, 18 or 20
     @ nRGB_Line, 5 SAY cRGB_Arrow              // set new arrow

   CASE nKey =  2 .OR. nKey =  3                 // Ctrl -> or page down
     nNewColor := IIF(nColor < 15, nColor +1, 0) // 0 1 2 ... 15 0
     DO DoSetColor

   CASE nKey = 26 .OR. nKey = 18                 // Ctrl <- or page up
     nNewColor := IIF(nColor > 0, nColor -1, 15) // 0 15 14 ... 2 1
     DO DoSetColor

   CASE nKey = -1 .OR. nKey = -2 .OR.;           // F2 key or F3 key
      ((nKey = -3 .OR. nKey = -4) .AND. EMPTY(cSaveTab))
     DO res_RGB_shift                           // reset RGB shift controller

     IF nKey = -1
       IF lVGA
         VGAPALETTE(nColor)                      // reset single colors
       ELSE
         EGAPALETTE(nColor)
         aPalette[nColor +1] := aDefPal[nColor +1]  // current value=default
       ENDIF
     ELSE
       IF lVGA
         VGAPALETTE()                            // reset all colors
       ELSE
         EGAPALETTE()
         FOR i = 1 TO 16                         // all 16 colors
           aPalette[i] := aDefPal[i]             // current values = default
         NEXT i
       ENDIF
     ENDIF

     DO load_RGB WITH nColor                  // determine RGB settings
     DO set_RGB_shift                        // set RGB shift controller

   CASE nKey = -3 .OR. nKey = -4              // F4 key or F5 key
     DO res_RGB_shift                        // reset RGB shift controller

     IF nKey = -3                             // reset single colors
       IF lVGA
         VGAPALETTE(nColor, ASCPOS(cSaveTab, nColor *3 +1 ),;
                    ASCPOS(cSaveTab, nColor *3 +2 ),;
                    ASCPOS(cSaveTab, nColor *3 +3 ))
       ELSE
         aPalette[nColor +1] := ASCPOS(cSaveTab, nColor +1)
         EGAPALETTE(nColor, aPalette[nColor +1])
       ENDIF
     ELSE                                     // reset all colors
       IF lVGA
         FOR i = 0 TO 15                      // all 16 colors
           VGAPALETTE(i, ASCPOS(cSaveTab, i *3 +1 ),;
                         ASCPOS(cSaveTab, i *3 +2 ),;
                         ASCPOS(cSaveTab, i *3 +3 ))
         NEXT i
       ELSE
         FOR i = 1 TO 16                      // all 16 colors
           aPalette[i] := ASCPOS(cSaveTab, i)
           EGAPALETTE(i -1, aPalette[i])
         NEXT i
       ENDIF
     ENDIF

     DO load_RGB WITH nColor                  // determine RGB settings
     DO set_RGB_shift                        // set RGB shift controller

   CASE nKey = -5 .OR. nKey = -6              // F6 key or F7 key
     DO res_RGB_shift                        // reset RGB shift controller

     FOR i = 0 TO 7                           // upper row
       @ 2, (i +1) * 8 +1 SAY STR(i, 2)
     NEXT i

     FOR i = 8 TO 15                          // lower row
       @12, (i -7) * 8 +1 SAY STR(i, 2)
     NEXT i

     WOPEN(14, 20, 22, 59)                    // adjusted to scoreboard
     SET COLOR TO R+/B
     WBOX()

     SET CURSOR ON
     nNewColor := nColor
     @ 4,1 SAY "                      (0 - 15)"
     @ 3,1 SAY "Please enter color :" GET nNewColor RANGE 0, 15
     READ

     WCLOSE()
     WSELECT(0)                               // complete screen

     FOR i = 0 TO 7                           // upper row
       @ 02, (i +1) * 8 +1 SAY "  "
     NEXT i

     FOR i = 8 TO 15                          // lower row
       @ 12, (i -7) * 8 +1 SAY "  "
     NEXT i

     IF nKey = -5                             // copy
       IF lVGA
         VGAPALETTE(nColor, GETVGAPAL(nNewColor, "R"),;
                            GETVGAPAL(nNewColor, "G"),;
                            GETVGAPAL(nNewColor, "B"))
       ELSE
         aPalette[nColor +1] := aPalette[nNewColor +1]
         EGAPALETTE(nColor, aPalette[nColor +1])
       ENDIF
     ELSE                                     // mix
       IF lVGA
         VGAPALETTE(nColor, (GETVGAPAL(nColor, "R") +;
                             GETVGAPAL(nNewColor, "R")) /2 +0.5,;
                            (GETVGAPAL(nColor, "G") +;
                             GETVGAPAL(nNewColor, "G")) /2 +0.5,;
                            (GETVGAPAL(nColor, "B") +;
                             GETVGAPAL(nNewColor, "B")) /2 +0.5)
       ELSE
         nOldPan_1 := nPanel[1]
         nOldPan_2 := nPanel[2]
         nOldPan_3 := nPanel[3]

         DO load_RGB WITH nNewColor           // determine RGB settings

         nPanel[1] := INT(((nOldPan_1 +nPanel[1]) /2) /nStep +0.5) *nStep
         nPanel[2] := INT(((nOldPan_2 +nPanel[2]) /2) /nStep +0.5) *nStep
         nPanel[3] := INT(((nOldPan_3 +nPanel[3]) /2) /nStep +0.5) *nStep

         DO panel_to_EGA

         EGAPALETTE(nColor, EGA_RGBsum)
         aPalette[nColor +1] := EGA_RGBsum    // keep current value
       ENDIF
     ENDIF

     DO load_RGB WITH nColor                  // determine RGB settings
     DO set_RGB_shift                        // set RGB shift contr.

   CASE nKey = -8 .OR. nKey = -9              // F9 key or F10 key

     IF nKey = -8                             // foreground
       ColorSet := NUMAND(ColorSet, 15 *16) +nColor
                                              // default color for window 0
     ELSE                                     // background
       ColorSet := NUMAND(ColorSet, 15) +nColor *16

       WSELECT(nColor +1)                     // select current color window
       SETCLEARB(Block)                       // byte for all CLEAR operations
       WOPEN(0, 0, 24, 79, .T.)               // clear screen completely
       FOR i = 0 TO 15
         cTextColor := NTOCOLOR(i +nColor *16)
         SET COLOR TO &cTextColor
         ? "   ∞∞∞±±±≤≤≤€€€" +STR(i, 5) +"/" +STR(nColor, 2) +"  Text test   "
       NEXT i

       SETCLEARB(" ")                         // byte for all CLEAR operations
       INKEY(0)
       WCLOSE()
       WSELECT(0)                             // total screen
     ENDIF
     @ 0, 75 SAY NTOCOLOR(Colorset)
     COLORWIN(0, 0, 1, 79, Colorset)
   CASE nKey = 28                             // F1
     DO ShowHelp

   CASE nKey = 27                             // Esc exits program
     WOPEN(10, 25 ,14, 54)
     SET COLOR TO R+/B
     WBOX()

     SET CURSOR ON
     ? " Exit program   (Y/N) ?  "

     cChoice := ""
     DO WHILE .NOT. cChoice $ "YN"
       cChoice := UPPER(CHR(INKEY(0)))
     ENDDO

     WCLOSE()
     WSELECT(0)                               // total screen

     IF cChoice = "Y"
        ?? "Y"
        EXIT
     ENDIF
   ENDCASE
 ENDDO

************************* End of program *********************************

 SET CURSOR OFF                               // hardware cursor off
 PAGECOPY(1, 0)                               // rest. 1st screen page

* A program generator with the neccessary palette commands
*

 CLEAR SCREEN
 SETRC(10, 0)

 crlf     := CHR(13) + CHR(10)                // new line
 cSaveTab := ""                               // all palette values

 IF lVGA
   ? CENTER("color settings will be saved to file _VGA_PAL.PRG")

   cProgText := ""

   FOR i = 0 TO 15                            // 16 colors
     cSaveTab := cSaveTab + CHR(GETVGAPAL(i, "R")) +;
                 CHR(GETVGAPAL(i, "G")) + CHR(GETVGAPAL(i, "B"))

     cProgText := cProgText + "VGAPALETTE(" +NTOC(i)  +",";
                            + NTOC(GETVGAPAL(i, "R")) +",";
                            + NTOC(GETVGAPAL(i, "G")) +",";
                            + NTOC(GETVGAPAL(i, "B")) +")" + crlf
   NEXT i

   STRFILE(cProgText, "_VGA_PAL.PRG")
   STRFILE(cSaveTab,  "_VGA_PAL.SAV")
 ELSE
   ? CENTER("color settings will be saved to file _EGA_PAL.PRG")

   cProgText := "EGAPALETTE()" + crlf         // defaults

   FOR i = 1 TO 16                            // 16 colors
     cSaveTab := cSaveTab +CHR(aPalette[i])
     IF aPalette[i] <> aDefPal[i]              // current value=default?
        cProgText := cProgText + "EGAPALETTE(" + NTOC(i -1) +;
                     "," + NTOC(aPalette[i]) +")" + crlf
     ENDIF
   NEXT i

   STRFILE(cProgText, "_EGA_PAL.PRG")
   STRFILE(cSaveTab,  "_EGA_PAL.SAV")
 ENDIF

RETURN                                        // QUIT

****************************************************************************

PROCEDURE DoSetColor

 DO res_RGB_shift                            // reset RGB shift contr.
 @ nColorLine, (nColor %8) * 8 +12 SAY " "    // reset arrow

 WSELECT(nColor +1)                           // select color window
 WBOX(Frame)                                  // reset mark box
 WFORMAT(-1, -1, -1, -1)                      // undo formatting

 nColor := nNewColor

 WSELECT(nColor +1)                           // select new color window
 ENHANCED()                                   // enhanced color parameter
  WBOX(Frame)                                 // mark box
  WFORMAT(-1,-1,-1,-1)                        // undo formatting
 STANDARD()                                   // standard color parameter

 WSELECT(0)                                   // back to physical screen

 cColorStr := ATREPL("RGB", BITTOC(nColor, "+RGB") + ", " +;
              BITTOC(15 -nColor, "+RGB")    , "W")

 @ 14,15 SAY STR(nColor, 2) +"/" +STR(15 -nColor, 2)  // "color:"  0 to 15
 @ 14,42 SAY PADRIGHT(cColorStr, 8)                   // "SET COLOR:" 1st Par.
                                                      //  for xxxPALETTE()

 IF nColor <= 7
   nColorLine  := 2
   cColorArrow := cDnArrow
 ELSE
   nColorLine  := 12
   cColorArrow := cUpArrow
 ENDIF

 @ nColorLine, (nColor %8) * 8 +12 SAY cColorArrow   // new color arrow

 DO load_RGB WITH nColor                // determine RGB settings
 DO set_RGB_shift                      // set RGB shift controller
RETURN

****************************************************************************

PROCEDURE res_RGB_shift

* reset RGB shift controller
*
 @ 16, nPanel[1] +8 SAY CHR(Line)
 @ 18, nPanel[2] +8 SAY CHR(Line)
 @ 20, nPanel[3] +8 SAY CHR(Line)

RETURN

****************************************************************************

PROCEDURE set_RGB_shift

* set RGB shift controller
*
 @ 16, nPanel[1] +8 SAY CHR(Block)
 @ 18, nPanel[2] +8 SAY CHR(Block)
 @ 20, nPanel[3] +8 SAY CHR(Block)

 IF lVGA
   @ 16, 75 SAY STR(nPanel[1],2)
   @ 18, 75 SAY STR(nPanel[2],2)
   @ 20, 75 SAY STR(nPanel[3],2)

   VGAPALETTE(nColor, nPanel[1], nPanel[2], nPanel[3])
 ELSE
   DO panel_to_EGA
   @ 14, 75 SAY STR(EGA_RGBsum,2)
   @ 16, 75 SAY STR(EGA_RGB[1],2)
   @ 18, 75 SAY STR(EGA_RGB[2],2)
   @ 20, 75 SAY STR(EGA_RGB[3],2)

   EGAPALETTE(nColor, EGA_RGBsum)
   aPalette[nColor +1] := EGA_RGBsum           // keep current value
 ENDIF

RETURN

****************************************************************************

PROCEDURE res_shift

 @ nRGB_Line, nPanel[RGB] +8 SAY CHR(Line)    // reset shift controller

RETURN

****************************************************************************

PROCEDURE set_shift

 @ nRGB_Line, nPanel[RGB] +8 SAY CHR(Block)   // set shift controller

 IF lVGA
   @ nRGB_Line, 75 SAY STR(nPanel[RGB], 2)
   VGAPALETTE(nColor, nPanel[1], nPanel[2], nPanel[3])
 ELSE
   DO panel_to_EGA
   @ 14       , 75 SAY STR(EGA_RGBsum, 2)
   @ nRGB_Line, 75 SAY STR(EGA_RGB[RGB], 2)
   EGAPALETTE(nColor, EGA_RGBsum)
   aPalette[nColor +1] := EGA_RGBsum           // keep current value
 ENDIF

RETURN

****************************************************************************

PROCEDURE load_RGB(nColor)

 * determining of current RGB settings

 IF lVGA
   * loading of RGB values for the selected color of VGA registers
   *
   nPanel[1] := GETVGAPAL(nColor, "R")
   nPanel[2] := GETVGAPAL(nColor, "G")
   nPanel[3] := GETVGAPAL(nColor, "B")
 ELSE
   RGB_String := BITTOC(aPalette[nColor +1], nColorCode, .T.)

   nPanel[1]  := SUBSTR(RGB_String, 4, 1) + SUBSTR(RGB_String, 1, 1)
   nPanel[2]  := SUBSTR(RGB_String, 5, 1) + SUBSTR(RGB_String, 2, 1)
   nPanel[3]  := SUBSTR(RGB_String, 6, 1) + SUBSTR(RGB_String, 3, 1)

   nPanel[1]  := CTOBIT(nPanel[1], "Rr") * nStep
   nPanel[2]  := CTOBIT(nPanel[2], "Gg") * nStep
   nPanel[3]  := CTOBIT(nPanel[3], "Bb") * nStep
 ENDIF
RETURN

****************************************************************************

PROCEDURE panel_to_EGA

 EGA_RGB[1] := Red[  1 +nPanel[1] / nStep]
 EGA_RGB[2] := Green[1 +nPanel[2] / nStep]
 EGA_RGB[3] := Blue[ 1 +nPanel[3] / nStep]

 EGA_RGBsum := EGA_RGB[1] + EGA_RGB[2] + EGA_RGB[3]

RETURN

****************************************************************************

PROCEDURE ShowHelp

 WOPEN(00, 00, 24, 79)
 SET COLOR TO R+/B
 WBOX()
 WFORMAT(00, 02, 01, 02)

 ? "ColorSelect With PgUP and PgDn key one of 16 colors will be selected"
 ?
 ? "R/G/B       With the keys UpArrow and DnArrow the basic color for the"
 ? "            horizontal shift controller is determined."
 ?
 ? "Controller  LeftArrow, RightArrow, Home and End set the current,"
 ? "            Alt-LeftArrow and Alt-RightArrow set all controllers."
 ?
 ? "Default     F2 resets the current, F3 all colors to basic setting."
 ?
 ? "Start       F4 resets the current, F5 all colors to starting values."
 ?
 ? "Copy        F6 copies from a color to be entered."
 ?
 ? "Mix         F7 mixes with a color to be entered."
 ?
 ? "Random      F8 sets a random color."
 ?
 ? "Setting     F9 sets foreground color, F10 sets background color."
 ?
 ? "End         Esc exits program and saves settings into a file."


 INKEY(0)
 WCLOSE()
 WSELECT(0)                              // total screen

RETURN

********************************  End of file  *****************************
