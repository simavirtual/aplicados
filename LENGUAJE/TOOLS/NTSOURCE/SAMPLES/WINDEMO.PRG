*********** Sample programs for Nantucket Tools II / 5.0 ************
*
* Program     : WINDEMO.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 10/01/91
* Author      : Lothar Bongartz
* Description : Demonstrating possibilities with windows
* Compiling   : CLIPPER WINDEMO
* Linking     : RTLINK FI WINDEMO, NT2US50 LIB NT250
* Remarks     : Most effects require EGA- or VGA-adapter.
*
*******************************************************************

#define MAXWIN   24
#define Char    157  // ù

#define cForeground " 0 0 1 1 1 1 2 2 4 5 5 6 6 8 914222526293337383838505059"
#define cBackground " 938 2 338583840383846 8125638324038295411 8294041 137 4"

LOCAL Top[MAXWIN], Left[MAXWIN], Bottom[MAXWIN], Right[MAXWIN]
LOCAL ScreenMode[10]
LOCAL nFontLine[64]

LOCAL cWinColor, cGrafColor, CardName, cNanFont, cFontChar
LOCAL Font, OldFont
LOCAL ChangeColor, NewColor

LOCAL Line, Line1, Line2
LOCAL SelectStr
LOCAL Height, OrgHeight, Font32, Font64

LOCAL NumRowPix, NumColPix, RowPix, ColPix

LOCAL NumModes, WinNum, i, j, k, Reverse, nCrtPort, OldWin, Offset

LOCAL r1, g1, b1, r2, g2, b2

LOCAL u, l, d, r, g, b

LOCAL bmax, bmin, bdir

LOCAL Temp

LOCAL nCurMode := 0
LOCAL cFontFile := ""



PRIVAT box_1 := "πªºπ∫ºπ∫ª Õ» Õºº» Õ…ÀÕªª…À»…Ã∫…Ã∫»Ã ÀÕŒ» ÀÃŒ…ÀÃŒπªÀŒπº Œπ∫ÃŒ"
PRIVAT box_2 := "∫∫∫ªªªºººººº»»»ÕÕÕªª………ÕÕÕ∫∫∫»»»………∫∫∫∫ªªªªªºººº»»»»…………Õ"
PRIVAT box_3 := "πππππππππ         ÀÀÀÀÀÀÀÀÃÃÃÃÃÃÃÃÃŒ"  // Overlay 1 + 2

PRIVAT ScreenVar :=""

PRIVAT GrafFont, NumCol, cBorderColor



SET KEY 27 TO ExitProc
SETCANCEL(.F.)                      // no Alt-C
SETKXLAT(3, 27)                     // Ctrl-C (not PgDn!) to Esc
SETKXLAT(301, 27)                   // Alt-X to Esc
SETKXLAT(302, 27)                   // Alt-C to Esc
CSETREF(.T.)

cBorderColor := IF(ISCOLOR(), "gr  /b, , r+", "w /n, , w")
cWinColor    := IF(ISCOLOR(), "r   /b"      , "w /n")
cGrafColor   := IF(ISCOLOR(), "w+  /n"      , "w+/n")

SETCLEARA(cBorderColor)
SETBOXGROW(15)

IF GETMODE() =IF(ISCOLOR(), "CGA80()", "MONOCHROME()") .AND.MAXROW() =24
  SAVE SCREEN TO ScreenVar
ENDIF

ScreenMode[1] :=IF(ISCOLOR(), 3, 7) // 25 rows CGA80() or MONOCHROME()
ScreenMode[2] :=43 +256             // 43 rows EGA43()
ScreenMode[3] :=28 +256             // 28 rows VGA28()
ScreenMode[4] :=50 +256             // 50 rows VGA50()


DO CASE
CASE ISVGA()
  CardName := "VGA"
  NumModes := 4
CASE ISEGA()
  CardName := "EGA " +NTOC(64 *MAXFONT()) +" KB"
  NumModes := 2
CASE ISMCGA()
  CardName := "MCGA"
  NumModes := 1
CASE ISHERCULES()
  CardName := "Hercules"
  NumModes := 1
CASE ISCGA()
  CardName := "CGA"
  NumModes := 1
OTHERWISE
  CardName := ""
  NumModes := 1
ENDCASE



CLS
@  1, 0 SAY CENTER("Window Demo Nantucket TOOLS II / 5.01")

WOPEN(8, (MAXCOL() -63) /2, 18, MAXCOL())

? "This demo program is self executing and will be repeated with"
? "other screen resolutions and character sets.                 "
?
? "Depending on the screen adapter up to 80 of about"
? "560 functions of Nantucket Tools II will be used."

Info("Screen adapter: " +CardName +" " +IF(ISCOLOR(), "Color" ,"Monochrome"))

SET COLOR TO
@ MAXROW(), MAXCOL() -16 SAY "<press any key>"

IF MAXFONT() >0
  FOR i =1 TO 22
    nFontLine[i] :=0
  NEXT i
  FOR i =0 TO 6
    nFontLine[6 *i +1 +22] :=    60
    nFontLine[6 *i +2 +22] :=MIN(60, 9 *i +35)
    nFontLine[6 *i +3 +22] :=MIN(60, 9 *i +20)
    nFontLine[6 *i +4 +22] :=MIN(60, 9 *i + 5)
    nFontLine[6 *i +5 +22] :=     0
    nFontLine[6 *i +6 +22] :=     0
  NEXT i
  nFontLine[62] :=60

  cNanFont :=""
  FOR i =0 TO 15
    k :=INT(i /8) *32
    FOR j =0 TO 31
      Line :=REPLICATE("1",     nFontLine[1 +k +j]);
            +REPLICATE("0", 64 -nFontLine[1 +k +j])
      cFontChar :=SUBSTR(Line, (i %8) *8 +1, 8)
      cNanFont :=cNanFont +CHR(CTON(cFontChar, 2))
    NEXT j
  NEXT i
ENDIF

Font :=SUBSTR(GETFONT(), Char *CHARPIX() +1, CHARPIX())
OldFont :=Font

WAITPERIOD(20000)

IF MAXFONT() >0 .AND. CHARPIX() >=8
  SET CURSOR OFF
  ?? CHR(Char)
  @ROW(), COL() -17 SAY CHR(Char)
ENDIF

DO WHILE WAITPERIOD() .AND. INKEY() =0
  IF MAXFONT() >0 .AND. CHARPIX() >=8
    FONTROTATE(@Font)
    SETFONT(Font, 1, Char, 1)
    MILLISEC(20)
  ENDIF
ENDDO

SETFONT(OldFont, 1, Char, 1)

WACLOSE()


DO WHILE .T.

  nCurMode++

  IF nCurMode >NumModes
    SETSCRMODE(ScreenMode[RANDOM() %NumModes +1])
    IF EMPTY(cFontFile)
      cFontFile :=FILESEEK("*.0??")
    ELSE
      cFontFile :=FILESEEK()
    ENDIF
    IF FONTLOAD(cFontFile, .T.) #0
      nCurMode :=0
      LOOP
    ENDIF
    IF MAXROW() <24
      LOOP
    ENDIF
  ELSE
    SETSCRMODE(ScreenMode[nCurMode])
  ENDIF

  SETBLINK(.F.)

  nCrtPort :=CTON(IF(ISCOLOR(), "3D4", "3B4"), 16)

  IF MAXFONT() =0
    cBorderColor :="+" +cBorderColor
    cWinColor    :="+" +cWinColor
  ELSE
    SET COLOR TO
    Font :=GETFONT()

    Height :=CHARPIX()
    OrgHeight :=CHARPIX()
    Font32 :=Font
    DO WHILE Height <=16
      Font32 :=CHARMIX(Font32, Font32)
      Height *= 2
    ENDDO

    IF Height <32
      Temp :=""
      FOR i =0 TO 255
         Temp += PADLEFT(SUBSTR(Font32, i *Height +1, Height), 32, CHR(0))
      NEXT i
      Font32 :=Temp
    ENDIF

    POSREPL(@Font32, cNanFont, 192 *32 +1)  // 192 first BlockGraphicCharacter

    SETFONT(Font32, .T.)
    Line2 := SUBSTR(CHARNOLIST(), 201, 8) +"     Nantucket"
    Line1 := SUBSTR(CHARNOLIST(), 193, 8) +REPLICATE(CHR(255), LEN(Line2) -8)
    @ MAXROW() /3,    1 SAY CENTER(Line1, .T.)
    @ MAXROW() /3 +1, 1 SAY CENTER(Line2, .T.)

    INFO("Nantucket Tools II")

    IF MAXFONT() >1
      FONTSELECT(1,2)               // norm. output: font 1, intensity: 2
      EGAPALETTE(18, 7)             // Intensity only for font selection
      SETCOLOR(cGrafColor)
      Temp := ""
      FOR i = 0 TO 255
         Temp += PADLEFT(SUBSTR(Font, i *OrgHeight +1, OrgHeight), 32, CHR(0))
      NEXT i
      SETFONT(Temp, 2)
      @ MAXROW(), 1 SAY CENTER("By Lothar Bongartz", MAXCOL() -1, .T.)
    ENDIF

    INKEYTRAP(5)
    CLS
    SETFONT(Font, .T.)

    EGAPALETTE(TOKEN(cBorderColor, 1), "+" +TOKEN(cBorderColor, 1))
    EGAPALETTE(TOKEN(cWinColor,    1), "+" +TOKEN(cWinColor,    1))
  ENDIF

  i :=0
  DO WHILE i -1 <MAXWIN
    Top[i+1]   :=  3 +i /2
    Left[i+1]  :=  1 +i *1.5
    Bottom[i+1]:=  7 +i
    Right[i+1] :=  9 +i *2.5

    Top[i+2]   :=  3 +i /2
    Left[i+2]  := MAXCOL() -i *2.5 - 9
    Bottom[i+2]:=  7 +i
    Right[i+2] := MAXCOL() -i *1.5 - 1

    IF Bottom[i+1] >MAXROW() -3 .OR. Right[i+1] >=Left[i+2]
      EXIT
    ENDIF
    i += 2
  ENDDO
  WinNum :=i

  * frame and header text

  SETCOLOR(cBorderColor)
  CLS

  @  1, 0 SAY CENTER("Window Demo Nantucket TOOLS II / 5.01")
  @  1, 2 SAY STR(MAXROW() +1, 3) +" x " +STR(MAXCOL() +1, 3)
  @  1, MAXCOL() -12 SAY "Esc = End"

  WBOX(5)      // whole screen, single line

  ** draw two lines and connect the ends with the frame
  @ 2           , 0 SAY "√" +REPLICATE("ƒ", MAXCOL() -1) +"¥"
  @ MAXROW()- 2 , 0 SAY "√" +REPLICATE("ƒ", MAXCOL() -1) +"¥"

  WBOARD(3, 1, MAXROW() -3, MAXCOL() -1)

  Info("You can open up to 255 windows per screen.") // -----------------

  SETCOLOR(cWinColor)

  FOR i =1 TO WinNum
    WOPEN(Top[i], Left[i], Bottom[i], Right[i])
    SETCLEARB(IF(ISBIT(i -1, 2), "@", "±"))
    WBOX()
    INKEYTRAP(0.2)
  NEXT i

  SETCLEARB(255)


  Info("The windows can be selected individually.") // ------------------

  SelectStr :=""
  DO WHILE LEN(SelectStr) <WinNum
    i := RANDOM() %WinNum +1

    IF AT(CHR(i), SelectStr) =0
      SelectStr += CHR(i)
      WSELECT(i)
      INKEYTRAP(0.2)
    ENDIF
  ENDDO


  Info("Each window is behaving like a screen.") // ----------------

  WOPEN(MAXROW(.T.)/2-4, MAXCOL(.T.)/2-16, MAXROW(.T.)/2+5, MAXCOL(.T.)/2+17)
  WBOX(12)
  FOR i = 1 TO 500
    ? "    row " + STR(i)
  NEXT i
  INKEYTRAP(1)


  IF MONISWITCH()
    Info("You can easily switch between two different screens.") // -

    WOPEN(MAXROW(.T.)/2-4, MAXCOL(.T.)/2-16, MAXROW(.T.)/2+5, MAXCOL(.T.)/2+17)
    WBOX(12)
    FOR i = 1 TO 1000
      ? STR(i)
      MONISWITCH()
    NEXT i
    WCLOSE()
    MONISWITCH()
  ENDIF

  OldWin := WSELECT()

  Info("After pressing 'Scroll' windows can be moved interactively.")

  WSELECT(OldWin)

  IF MAXFONT() > 1                  // graphic within a window is possible
    FONTSELECT( 1, 2)               // norm. output: font 1, intensity: 2
    EGAPALETTE(18, 7)               // intensity only for font selection

    GrafFont := REPLICATE(CHR(0), 256 *CHARPIX())

    NumCol    := MAXCOL() +1
    NumRowPix := CHARPIX() * (MAXROW() +1)
    NumColPix := 8         * NumCol

    FOR ColPix = 0 TO NumColPix -1     // sine curve
      RowPix := 4 *PI() /NumColPix *ColPix
      RowPix := (NumRowPix /2 -1) *SIN(RowPix)
      RowPix := NumRowPix /2 -RowPix
      GrafSet(RowPix, ColPix)
    NEXT ColPix

    SETFONT(GrafFont, 2)
    SETCOLOR(cGrafColor)

    _SAYWRAP(CHARNOLIST(), 0, 0)

    RowPix := NumRowPix /2
    FOR ColPix = 0 TO NumColPix -1  // horizontal line
      GrafSet(RowPix, ColPix)
    NEXT

    ColPix := NumColPix /2
    FOR RowPix = 0 TO NumRowPix -1  // vertical line
      GrafSet(RowPix, ColPix)
    NEXT

    SETFONT(GrafFont, 2)
    INKEYTRAP(2)

    FOR i = 1 TO MAXROW() +1
      _SAYWRAP( LEFT(REPLICATE(CHR(0), i *NumCol) +CHARNOLIST(), 256), 0, 0)
      INKEYTRAP(0.1)
    NEXT i

    FOR i = MAXROW() TO 0 STEP -1
      _SAYWRAP( LEFT(REPLICATE(CHR(0), i *NumCol) +CHARNOLIST(), 256), 0, 0)
      INKEYTRAP(0.1)
    NEXT i

    SETCOLOR(cBorderColor)
  ENDIF

  INKEYTRAP(2)
  WCLOSE()

  FONTSELECT(1,   1)                // reset
  EGAPALETTE(18, 15)                // reset


  IF MAXFONT() > 0
    Info("Characters can be changed easily.")

    Font64 := SUBSTR(GETFONT(), 64 *CHARPIX() +1, CHARPIX())
    IF CHARPIX() = 8
      FOR i = 127 TO 0 STEP -1
        FONTROTATE(@Font64)
        SETFONT(Font64, 1, 64, 1)
        MILLISEC(i)
      NEXT i
    ELSE
      FOR i = 63 TO 0 STEP -1
        FONTROTATE(@Font64, 2)
        SETFONT(Font64, 1, 64, 1)
        MILLISEC(i)
        FONTROTATE(@Font64, 3, CHARPIX())
        SETFONT(Font64, 1, 64, 1)
        MILLISEC(i)
      NEXT i
    ENDIF
  ENDIF


  Info("Windows can be moved anywhere.") // -------------------------

  FOR i = 1 to WinNum
    WSELECT(i)
    DO WHILE WLASTROW() < MAXROW(.T.) -3
      WMOVE(WROW() +1, WCOL())      // down
    ENDDO
    INKEYTRAP(0.2)
  NEXT i

  FOR i = WinNum to 1 step -1
    WSELECT(i)
    Reverse := 1 +WinNum -i

    IF WCOL() > Left[Reverse]
      DO WHILE WCOL() > Left[Reverse]
        WMOVE(WROW(), WCOL() -1)    // left
      ENDDO
    ELSE
      DO WHILE WLASTCOL() < Right[Reverse]
        WMOVE(WROW(), WCOL() +1)    // right
      ENDDO
    ENDIF

    DO WHILE WROW() > Top[Reverse]
      WMOVE(WROW()-1, WCOL())       // up
    ENDDO
    INKEYTRAP()
  NEXT i


  Info("Or centered..............") // ------------------------------------

  FOR i = WinNum to 1 step -1
    WSELECT(i)
    WCENTER(.T.)
    INKEYTRAP(0.2)
  NEXT i


  Info("And separated again.") // --------------------------

  FOR i = WinNum to 1 step -1
    WSELECT(i)
    WMOVE(Top[i], Left[i])
    INKEYTRAP(0.2)
  NEXT i

  FOR j = 1 TO 4
    FOR i = 1 TO WinNum
      WSELECT(i)
      INKEYTRAP()
    NEXT i

    FOR i = WinNum to 1 step -1
      WSELECT(i)
      INKEYTRAP()
    NEXT i
  NEXT j


  IF ISCOLOR()
    Info("Colors can be changed subsequently.")

    WSELECT(0)
    ChangeColor := cBorderColor
    FOR i = 0 TO 15
      NewColor := i *16
      ColorToMid(10, 3, 1, MAXROW() -3, MAXCOL() -1, NewColor, ChangeColor)
      ChangeColor := NewColor
      INKEYTRAP(0.2)
    NEXT i
    ColorToMid(10, 3, 1, MAXROW() -3, MAXCOL() -1, cBorderColor, ChangeColor)

    DO CASE
    CASE ISMCGA()
      Info("Or completely redefined.......")

      * ColorCyling of color blue

      r    := GETVGAPAL("B", "R")   // red share of blue
      g    := GETVGAPAL("B", "G")   // green share of blue
      b    := GETVGAPAL("B", "B")   // blue share of blue
      bmax := MIN(b +20, 63)        // upper range of blue share is > 20, max 63
      bmin := MAX(b -10,  0)        // lower range of blue share is < 10, min 0
      bdir := 1                     // changing of blue share

      FOR i = 1 TO 100
        IF b = bmax .OR. b = bmin
          bdir := -bdir             // change direction
        ENDIF

        b += bdir
        VGAPALETTE("B", r, g, b)
        MILLISEC(30)
        INKEYTRAP()
      NEXT i

      i := 0
      DO WHILE i < 25
        r1 := RANDOM() %64
        g1 := RANDOM() %64
        b1 := RANDOM() %64
        r2 := RANDOM() %64
        g2 := RANDOM() %64
        b2 := RANDOM() %64

        IF ABS((0.30 *r1 +0.59 *g1 +0.11 *b1);
              -(0.30 *r2 +0.59 *g2 +0.11 *b2)) >15      // contrast?
          i++
          VGAPALETTE(TOKEN(cWinColor, 1), r1, g1, b1)
          VGAPALETTE(TOKEN(cWinColor, 2), r2, g2, b2)
          INKEYTRAP(1)
        ENDIF
      ENDDO
      VGAPALETTE()    // reset

    CASE ISEGA()
      Info("Colors can be redefined.") // -------------------------

      FOR i = 1 TO LEN(cForeground) /2
        EGAPALETTE(TOKEN(cWinColor, 1), VAL(SUBSTR(cForeground, i *2 -1, 2)))
        EGAPALETTE(TOKEN(cWinColor, 2), VAL(SUBSTR(cBackground, i *2 -1, 2)))
        INKEYTRAP(1)
      NEXT i

      EGAPALETTE()    // reset
    ENDCASE
  ENDIF

  EGAPALETTE(TOKEN(cBorderColor, 1), 63)
  EGAPALETTE(TOKEN(cBorderColor, 2),  8)
  EGAPALETTE(TOKEN(cWinColor,    1), 38)
  EGAPALETTE(TOKEN(cWinColor,    2),  8)


  IF ISEGA() .OR. ISCGA()
    Info("Soon I will disappear ..........") // ----------------------------
    INKEYTRAP(2)

    FOR i =0 to SCREENSIZE() /2
      OUTWORD(nCrtPort, NUMHIGH(i) *256 +12)
      OUTWORD(nCrtPort, NUMLOW(i)  *256 +13)
    NEXT i

    Info("... and come back") // ---------------------------------------
    INKEYTRAP(1)

    FOR i = MAXROW() TO 0 STEP -1
      Offset := i *(MAXCOL() +1)
      OUTWORD(nCrtPort, NUMHIGH(Offset) *256 +12)
      OUTWORD(nCrtPort, NUMLOW(Offset)  *256 +13)
      MILLISEC(15)
    NEXT i
    INKEYTRAP(3)
  ENDIF

  IF ISEGA()
    IF MAXCOL() = 79
      Info("Special effects can also be implemented.") // --------
      INKEYTRAP(2)

      j := 12
      FOR i = 0 TO 40
        OUTWORD(nCrtPort,i *256 +19)
        MILLISEC(j *(40 -i) /3)
      NEXT i
    ENDIF
  ENDIF


  Info("Windows can be closed in any sequence.") // --

  FOR i = 1 TO WinNum
    WSELECT(ASCPOS(SelectStr, i))
    WCLOSE()
    INKEYTRAP(0.2)
  NEXT i


  Info("Boxes can be fused easily.") // -----------------------

  SETCOLOR(cWinColor)
  @                09,          03 TO MAXROW() /2,MAXCOL() /2 DOUBLE
  BoxOver(         09, MAXCOL() /2,   MAXROW() /2,MAXCOL() -3)
  BoxOver(MAXROW() /2,          03,   MAXROW() -9,MAXCOL() /2)
  BoxOver(MAXROW() /2, MAXCOL() /2,   MAXROW() -9,MAXCOL() -3)
  INKEYTRAP(3)

  CLEARWIN(03, 01, MAXROW() -3, MAXCOL() -1)
  FOR i = 3 TO MAXROW() -3 STEP 3
    @ i,01 TO i,MAXCOL() -1 DOUBLE
  NEXT i

  SETCOLOR(cBorderColor)
  u := 3
  l := 9
  d := MAXROW() -3
  r := MAXCOL() -9

  DO WHILE u < d .AND. l < r
    BoxOver(u, l, d, r)
    u += 3
    d -= 3
    l += 9
    r -= 9
  ENDDO
  INKEYTRAP(4)

  SET COLOR TO
  StrWin("Nantucket Tools II  ")
  INKEYTRAP(3)

  IF MAXFONT() > 0
    FOR i = 7 TO 0 STEP -1
      SETFONT(CHARAND(GETFONT(), CHR(255 -2**i)))
      INKEYTRAP(.2)
    NEXT i

    CLS
    INKEYTRAP(1)

    IF MAXPAGE() >= 7                 // EGA 64 KB cannot into this screen size
      Font := REPLICATE(CHR(0), 512)  // 256 characters a' 2 pixel rows
      FOR i = 8 TO 1 STEP -1          // from left to the right
        temp := CHR(SETBIT(0, i))     // set one pixel each
        POSREPL(@Font, temp +temp, 1 +2 *(8 -i))// 1, 3, 5, 7, 9, 11, 13, 15
      NEXT i

      SETFONT(Font, .T.)
      FOR i = 1 TO 500
        @ RANDOM() %MAXROW(), RANDOM() %MAXCOL() SAY CHR(RANDOM() %8)
      NEXT i

      SETBLINK(.T.)
      EGAPALETTE()    // reset
      SET COLOR TO W+/N*
      FOR i = 1 TO 20
        @ RANDOM() %MAXROW(), RANDOM() %MAXCOL() SAY CHR(RANDOM() %8)
      NEXT i

      SET COLOR TO
      INKEYTRAP(2)
      CLS
    ENDIF
  ENDIF
ENDDO

*******************************************************************************

PROCEDURE ExitProc(a, b, c)

 WACLOSE()

 IF ISCOLOR()
   CGA80()
 ELSE
   MONOCHROME()
 ENDIF

 IF .NOT. EMPTY(ScreenVar)
   RESTORE SCREEN FROM ScreenVar
 ENDIF
QUIT

*******************************************************************************

FUNCTION Info(InfoText)
LOCAL Effect

 WSELECT(0)
 SETCOLOR(cBorderColor)

 Effect := RANDOM() %5

 DO CASE
  CASE Effect = 0           // set up message from the middle
    ClearToMid(         15, MAXROW() -1, 1, MAXROW() -1, MAXCOL() -1)
    SAYSPREAD(InfoText, 15, MAXROW() -1)
  CASE Effect = 1
    SAYMOVEIN(CENTER(InfoText, MAXCOL() -1, .T.), 15, MAXROW() -1, 1)
  CASE Effect = 2
    SAYMOVEIN(CENTER(InfoText, MAXCOL() -1, .T.), 15, MAXROW() -1, 1, .T.)
  CASE Effect = 3
    SayTop   (CENTER(InfoText, MAXCOL() -1, .T.),     MAXROW() -1, 1)
  OTHERWISE
    SayRandom(CENTER(InfoText, MAXCOL() -1, .T.),     MAXROW() -1, 1)
 ENDCASE

RETURN( .T. )

*******************************************************************************

FUNCTION ClearToMid(Delay, Top, Left, Bottom, Right)

 DO WHILE Left <= Right
   CLEARWIN(Top, Left,  Bottom, Left)
   CLEARWIN(Top, Right, Bottom, Right)
   MILLISEC(Delay)
   Left++
   Right--
 ENDDO

RETURN( .T. )

*******************************************************************************

FUNCTION ColorToMid(Delay, Top, Left, Bottom, Right, NewColor, OldColor)

 DO WHILE Left <= Right
   COLORWIN(Top, Left,  Bottom, Left,  NewColor, OldColor)
   COLORWIN(Top, Right, Bottom, Right, NewColor, OldColor)
   MILLISEC(Delay)
   Left++
   Right--
 ENDDO

RETURN( .T. )

*******************************************************************************

FUNCTION SayTop(cRowText, nRow, nCol)
LOCAL i, cRowTextOld, nColNum

 nColNum := LEN(cRowText)
 FOR i = 0 TO nRow -1
   cRowTextOld := SCREENSTR(i, nCol, nColNum)
   @ i, nCol SAY cRowText
   MILLISEC(MAXROW() -i)
   STRSCREEN(cRowTextOld, i, nCol)
 NEXT i
 @ nRow, nCol SAY cRowText

RETURN( .T. )

*******************************************************************************

FUNCTION SayRandom(cRowText, nRow, nCol)
LOCAL RandomPos, RandomStr, TextLen

 @ nRow, nCol SAY BLANK(cRowText, .T.)
 nCol   += COUNTLEFT(cRowText)
 cRowText  := REMALL(cRowText)
 TextLen   := LEN(cRowText)
 RandomStr := ""
 DO WHILE LEN(RandomStr) <TextLen
   RandomPos := RANDOM() %TextLen +1
   IF AT(CHR(RandomPos), RandomStr) =0
     RandomStr += CHR(RandomPos)
     @ nRow, nCol +RandomPos -1 SAY SUBSTR(cRowText, RandomPos, 1)
   ENDIF
 ENDDO

RETURN( .T. )

*******************************************************************************

FUNCTION GrafSet(Row, Col)
LOCAL Byte, Pos

 Pos  := 1 +(NumCol *INT(Row /CHARPIX()) +INT(Col /8)) *CHARPIX() +Row %CHARPIX()
 Byte := SETBIT(ASCPOS(GrafFont, Pos), 8 -Col %8)
 POSREPL(@GrafFont, CHR(Byte), Pos)

RETURN( .T. )

*******************************************************************************

FUNCTION StrWin(String)

 _SAYWRAP(LEFT(REPLICATE(String,;
          (SCREENSIZE() /2) /LEN(String) +1),;
          (SCREENSIZE() /2)), 0, 0)

RETURN( NIL )

*******************************************************************************

FUNCTION BoxOver(u, l, d, r)
 LOCAL old, new, new_c

 SAVE SCREEN TO old
 @ u,l TO d,r DOUBLE
 SAVE SCREEN TO new
 new_c := CHARODD(new)
 CHARRELREP(box_1, CHARODD(old), box_2, @new_c, box_3)

RETURN( SCREENMIX(new_c, CHAREVEN(new), 0, 0) )

*******************************************************************************
* Eof WINDEMO.PRG
