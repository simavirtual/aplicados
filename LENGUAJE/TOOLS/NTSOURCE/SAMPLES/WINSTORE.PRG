*********** Sample programs for Nantucket Tools II / 5.0      ************
*
* Program     : WINSTORE.PRG
* Copyright   : (c) 1991, Nantucket  Corp.  All rights reserved.
* Date        : 02/02/91
* Author      : Lothar Bongartz / Michael Peters
* Description : Saving/loading of complete windows including position,
*               colors, cursor etc.
*
* Compiling   : CLIPPER WINSTORE
* Linking     : RTLINK FI WINSTORE, NT2US50 LIB NT250
* Remarks     : see further notes within the program code
*
*               ATTENTION!
*               If there are used ALIAS names for the .DBF-files
*               with more than 8 characters, the allocated .WIN-
*               file can not be located definitely any more!
*
*               Number of lines and columns have to be the
*               same (see at WINREST())
*
*               The number of the window is always RECNO() -1.
*
*               The contents of the window can be packed.
*               At packing method 0, CHARODD() and CHAREVEN()
*               should be used before!
*
*               As the setting for WSETSHADOW() is mostly the
*               same, it will not be saved!
*
**************************************************************************
*
* Example: Savin window in a file
*
* structure for the WINDOW-database
* To save the data as compact as possible, all fields have been
* created as character fields (also the fields for numeric values!)
*
* Field  Field-Name  Type       Width
*    1  WHANDLES    Character      1    values for WALIAS()
*    2  WTOP        Character      1    values for WOPEN()
*    3  WLEFT       Character      1
*    4  WBOTTOM     Character      1
*    5  WRIGHT      Character      1
*    6  WFTOP       Character      1    values for WFORMAT()
*    7  WFLEFT      Character      1
*    8  WFBOTTOM    Character      1
*    9  WFRIGHT     Character      1
*   10  WCURSOR     Character      4    value  for RESTCURSOR()
*   11  WCOLOR      Character     33    value  for SETCOLOR()
*   12  WOFFSET     Character      4    values for FILESTR()
*   13  WLENGTH     Character      2
*** Total **                      53
*
***********************************************************************

LOCAL i, nHandle, cWList

**************************************************************************
*
** create an array of windows **

 SETBLINK(.F.)
 SETCLEARB(177)
 SETCOLOR("B/W")
 CLEAR SCREEN

 SETCLEARB("#")
 SETCOLOR("GB/W")

 WMODE(.T., .T., .T., .T.)
 WBOARD(1, 2, 22, 69)
 @ 1, 2 CLEAR TO 22, 69

 SETCLEARB(" ")
 SETCOLOR("")
 WSETSHADOW("N+/N")

  FOR i = 0 TO 9
   WOPEN(2*i, 2*i, i +11, 5*i +20, .T.)
   SETCOLOR(NTOC(i +6))
   WBOX(12)
  NEXT i

 @ 0, 0 SAY CENTER("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

 WSELECT(0)
  @ MAXROW(), 0
  @ MAXROW(), 0 SAY CENTER("create new windows  Ù")
 INKEY(0)
*
* save all existing windows
*
 USE windows
 ZAP
 nHandle := FCREATE(LEFT(ALIAS(), 8) + ".win")    // new .WIN-file


* Within the following loop, we had to fall back to the function
* _WSTACK, which is not documented til now.
* Please not, that this kind of function calls could be changed
* in further versions of Clipper Tools!

 cWList := _WSTACK()
  FOR i = 1 TO LEN(cWList)
   APPEND BLANK
   WSELECT(ASCPOS(cWList, i))
   WINSAVE(nHandle)
  NEXT i
 FCLOSE(nHandle)


 WSELECT(0)
  @ MAXROW(), 0
  @ MAXROW(), 0 SAY CENTER("all windows have been saved  Ù")
 INKEY(0)
*
* discard all windows (close)
*
 WACLOSE()
  @ MAXROW(), 0
  @ MAXROW(), 0 SAY CENTER("all windows are closed  Ù")
 INKEY(0)
*
* recover all windows
*
 USE windows
 LOCATE FOR WHandle = CHR(0)
 WINREST()
 GO TOP

 DO WHILE .NOT. EOF()
    IF WHandle == CHR(0)         // first or last record
       WSELECT(0)
    ELSE
       WINREST()
    ENDIF
    SKIP
 ENDDO

 @ MAXROW(), 0
 @ MAXROW(), 0 SAY CENTER("all windows have been recovered  Ù")
 INKEY(0)
RETURN

**************************
* Die Funktion WINSAVE
*
* The function takes as basis, that the database ist already open
* and selected. The pointer has to be positioned.
*
* Functions:
*
* All window coordinates will be saved in a new record of the
* selected database.
* All formattings, e.g. created by WBOX(), will be discarded
* and the complete window area will be saved in a variable
* with SAVE SCREEN. This variable will be added to a separate
* file (low level access), named like the database file, but with
* the extension .WIN.
* Offset and length of these data will be saved in two fields
* of the new added record.
*
FUNCTION WINSAVE(nHandle)
LOCAL cWinScreen, nOffset, nLength


 REPLACE ;
   WHandle  WITH CHR(WSELECT()),;
   wtop     WITH CHR(WROW())         ,wleft   WITH CHR(WCOL()),;
   wbottom  WITH CHR(WLASTROW())     ,wright  WITH CHR(WLASTCOL()),;
   wftop    WITH CHR(WFROW(.T.))     ,wfleft  WITH CHR(WFCOL(.T.)),;
   wfbottom WITH CHR(WFLASTROW(.T.)) ,wfright WITH CHR(WFLASTCOL(.T.)),;
   wcursor  WITH L2BIN(SAVECURSOR()),;
   wcolor   WITH SETCOLOR()




  WFORMAT()                  // take back formattings ...
  SAVE SCREEN TO cWinScreen  //  ... and save window area in a var.

  WFORMAT(ASC(wftop), ASC(wfleft), ASC(wfbottom), ASC(wfright))


 nLength :=LEN(cWinScreen)
 IF nLength = BIN2I(wlength)               // former record?
   nOffset := BIN2L(woffset)               // former position
   nOffset := FSEEK(nHandle, nOffset, 0)   // relative beg. of file
 ELSE
   nOffset := FSEEK(nHandle, 0, 2)         // relative end of file
 ENDIF                                     // append

 IF FWRITE(nHandle, cWinScreen) <> nLength
   nLength := 0                            // "empty" at write error
 ENDIF

 REPLACE ;
   woffset WITH L2BIN(nOffset),;
   wlength WITH I2BIN(nLength)

 RETURN(nLength > 0)

**************************
* The function WINREST
*
* The function takes as basis, that the database ist already open
* and selected. The record pointer has to be positioned.
*
* Functions:
*
* The window will be reopened at the coordinates WTOP, WLEFT, WBOTTOM
* and WRIGHT. At a complete screen, the screen format can be set
* optionally via SETMODE() (Note: This does not work, when the
* format is specific for the video adapter!)
* The saved window area will be loaded from the .WIN file
* and presented in the former defined window area (RESTORE SCREEN).
* All settings like formattings, cursor or colors will be
* set corresponding to the saved values.
*
FUNCTION WINREST()

LOCAL nWinNum

 nWinNum := ASC(WHandle)            // Window handle from record

 IF nWinNum > 0                     // One window ?
   WOPEN(ASC(wtop), ASC(wleft), ASC(wbottom), ASC(wright))
   WALIAS(nWinNum)                  // recover former handle
 ELSE
   WSELECT(0)
*  IF MAXROW() <> ASC(wbottom) .OR. MAXCOL() <> ASC(wright)
*    SETMODE(ASC(wbottom) + 1, ASC(wright) + 1)
*  ENDIF
 ENDIF

*
* verify MAXROW() and MAXCOL()
*


 RESTORE SCREEN FROM FILESTR(LEFT(ALIAS(), 8) + ".win",;
                             BIN2I(wlength), BIN2L(woffset))

 IF nWinNum > 0
   WFORMAT(ASC(wftop), ASC(wfleft), ASC(wfbottom), ASC(wfright))
 ELSE
   WBOARD(ASC(wftop), ASC(wfleft),;
           MAXROW() -ASC(wfbottom), MAXCOL() -ASC(wfright))
 ENDIF

 RESTCURSOR(BIN2L(wcursor))
 SETCOLOR(wcolor)
RETURN(.T.)

