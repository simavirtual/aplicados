*************** Sample programs for Nantucket Tools II / 5.0 ****************
*
* Program     : NANSPEED.PRG
* Copyright   : (c) 1991, Nantucket Corp.  All rights reserved.
* Date        : 08/07/91
* Author      : Lothar Bongartz
* Description : Nantucket Computer Speed Test
* Compiling   : CLIPPER NANSPEED /l /m /v
* Linking     : RTLINK FI NANSPEED LIB NT250
*
* Remarks     : in multitasking mode (e.g. Windows Dos Box), it is not
*               possible to determine the processor speed exactly.
*               In this case, a 0 value can be determined.
*
**************************************************************************

#define MHZ_Tic     1014
#define AT_PC          1.61
#define FAME_SIZE     61
#define FAME_COUNT    10
#define INFO_SIZE   FAME_COUNT * FAME_SIZE

**************************************************************************

LOCAL i, nDuration, nDiskspeed, cExeInfo, nExeSize, nScale, nMHZ, lTemp
LOCAL cScreen, cComputer, cOwner, cFame
LOCAL nCounter := 0, nKeyVal := 0, nMinDuration := 256
LOCAL lMultitasking := .F.

**************************************************************************

MEMVAR GetList

**************************************************************************

CSETREF(.T.)
SET SCOREBOARD OFF
SET CONFIRM ON
IF GETCOUNTRY() = 49
  SET DATE GERMAN
ENDIF

nExeSize := FILESIZE(EXENAME())
cFame := FILESTR(EXENAME(), , nExeSize -(INFO_SIZE +2))

IF COM_CRC(cFame) =0
  nExeSize -= INFO_SIZE +2
  cFame := LEFT(cFame, INFO_SIZE)
  CHARNOT(@cFame)
ELSE
  cFame := REPLICATE(CHR(255) +SPACE(FAME_SIZE -1), FAME_COUNT)
ENDIF

IF ISCOLOR()
  SETCOLOR("GR+/B, , , N/GB*")
ELSE
  SETCOLOR("W/N  , , , N/W*")
ENDIF

SETCANCEL(.F.)                  // no Alt-C

SET CURSOR OFF
CLEAR

ENHANCED()
@ 24,  2 SAY "F1"
@ 24, 15 SAY "ESC"

STANDARD()
@ 24,  5 SAY " Help  "
@ 24, 19 SAY " End  "
@ 24, 36 SAY  DATE()


@  1, 0 SAY CENTER("NANTUCKET SPEED TEST")

@  4, 2 SAY "CPU speed comparable to an AT at Mhz:"
@  6, 0
FOR i = 1 TO 16
  DISPOUT(STR(i *16, 5))
NEXT

SETPOS(7, 0)
FOR i = 1 TO 16
  DISPOUT("ÄÄÄÄÅ")
NEXT

@ 15, 0 TO 15, 79

FOR i = 1 TO 256 /AT_PC STEP 12
  nScale := AT_PC *i *5 /16
  @ 15, nScale    SAY "Å"
  @ 16, nScale -2 SAY STR(i, 3) +"x"
NEXT
@ 17, 0
@ 18, 2 SAY "CPU speed in comparison to a PC with 4.77 Mhz   "
@ 20, 2 SAY "duration of the last CPU speed test in millisec:"
@ 21, 2 SAY "disk speed relativ to a PC disk drive:"


DO WHILE nKeyVal <> 27
  IF lMultitasking
    nDuration := 80000 / SPEED()
  ELSE
    SETTIC(.T.)

    FOR i = 1 TO 183
      lTemp := .T.                // without math processor
                                  // without memory management
                                  // without constant folding
    NEXT i

    SETTIC()
    nDuration := GETTIC()
    IF nDuration =0
      lMultitasking := .T.
      @ 20, 61 SAY "(Multitasking)"
      LOOP
    ENDIF
  ENDIF

  nMinDuration := MIN(nMinDuration, nDuration)

  DO CASE
  CASE nKeyVal = 0
    nMHZ   := MHZ_Tic /nDuration
    nScale := nMHZ *5 /16

    @ 09, 0 CLEAR TO 13, 79
    @ 11, 00 SAY REPLICATE("Û", nScale)

    nScale := MIN(nScale, MAXCOL() -2)
    @ 09, nScale -4 SAY STR(nMHZ, 6, 1)
    @ 13, nScale -3 SAY STR(nMHZ /AT_PC, 5, 1)

    @ 20, 54 SAY STR(nDuration, 4)

    IF nCounter = 0
      nCounter ++
      BACKGROUND()
      @23, 00 SAY CENTER("testing disk speed", .T.)
      nDiskspeed := DISKSPEED()
      IF nDiskspeed >500
        nDiskspeed := INT((DISKSPEED() +DISKSPEED() +nDiskspeed) /3)
      ENDIF
      STANDARD()
      @23, 00
      @21, 53 SAY STR(nDiskspeed /100, 7, 1) +"x"
    ENDIF

    @ 24, 70 SAY TIME()

  CASE nKeyVal = 28
    SAVE SCREEN TO cScreen
    ShowFame(cFame)
    INKEY(0)
    RESTORE SCREEN FROM cScreen
  OTHERWISE
    SOUND( 1000, 100, 70, 10, 500, 1200)
  ENDCASE

  nKeyVal := INKEY()

ENDDO


FOR i = 0 TO FAME_COUNT -1
  IF nMinDuration <ASCPOS(cFame, i *FAME_SIZE +1)
    cFame := POSINS(cFame,;
             CHR(nMinDuration) +L2BIN(nDiskspeed) +DTOS(DATE()) +SPACE(48),;
             i *FAME_SIZE +1)
    SAVE SCREEN TO cScreen
    ShowFame(cFame)

    cComputer := SPACE(20)
    cOwner    := SPACE(28)
    @ i +13, 29 GET cComputer
    @ i +13, 50 GET cOwner

    SET CURSOR ON
    READ
    SET CURSOR OFF

    RESTORE SCREEN FROM cScreen
    IF UPDATED()
      POSREPL(@cFame, cComputer +cOwner, i *FAME_SIZE +14)
      cFame :=LEFT(cFame, INFO_SIZE)
      CHARNOT(@cFame)
      STRFILE(cFame + CHARSWAP(I2BIN(COM_CRC(cFame))), EXENAME(), .T., nExeSize)
    ENDIF
    EXIT
  ENDIF
NEXT i

@24, 0
@23, 0
RETURN          // QUIT

**************************************************************************

FUNCTION ShowFame(cFame)
LOCAL i, nRow, nDuration, nDiskspeed

 CLEAR

 @ 0, 0 TO  7, 79 DOUBLE
 @ 1, 2 SAY "An AT at 6 Mhz is 3.4 times as fast as a PC."
 @ 3, 2 SAY "The disk performance is determined by direct reading of adjoining"
 @ 4, 2 SAY "sectors; this value is then independent of the order of the disk "
 @ 5, 2 SAY "files. Sporadic read errors decline the result. Other read errors"
 @ 6, 2 SAY "or network drives result in a 0 value."

 @ 8, 0 TO 23, 79 DOUBLE
 @ 9, 1 SAY CENTER("ððð HALL OF FAME ððð")
 @11, 7 SAY "Mhz   Disk  Date      Computer Model       Owner "

 FOR i = 0 TO FAME_COUNT -1
   nRow := i +13
   @ nRow, 1 SAY STR(i +1, 2)
   nDuration := ASCPOS(cFame, i *FAME_SIZE + 1)
   IF nDuration < 255                    // 255 = blank entry
     @ nRow,  4 SAY STR(MHZ_Tic /nDuration, 6, 1)
     nDiskspeed := BIN2L(SUBSTR(cFame, i *FAME_SIZE + 2,  4))
     @ nRow, 11 SAY STR(nDiskspeed /100, 6, 1)
     @ nRow, 19 SAY STOD(SUBSTR(cFame, i *FAME_SIZE + 6,  8))
     @ nRow, 29 SAY SUBSTR(cFame,      i *FAME_SIZE +14, 20)
     @ nRow, 50 SAY SUBSTR(cFame,      i *FAME_SIZE +34, 28)
   ENDIF
 NEXT i

 @ 24, 2 SAY "The order is only depending on the Mhz value."

RETURN ( NIL )

**************************************************************************
* EOF   NANTSPEED.PRG


