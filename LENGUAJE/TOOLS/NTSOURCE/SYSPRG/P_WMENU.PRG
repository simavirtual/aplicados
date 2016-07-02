*************** Source code Nantucket Tools I + II / 5.0 *******************
*
* Program     : P_WMENU.PRG
* Copyright   : (c) 1991, 1992 Nantucket Corp.  All rights reserved.
* Date        : 01/15/92
* Author      : Lothar Bongartz
* Description : Source code for WINMENU()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : IMPORTANT!
*               When creating the file NT250.PLL with NT250.LNK,
*               P_WMENU is already linked in. If you want to modify
*               P_WMENU and create a new .PLL file, P_WMENU.OBJ
*               must be available and has to be added to the FI
*               command line in NT250.LNK. If you don't want to create
*               a .PLL file, P_WMENU.OBJ can be added to .OBJ file list
*               during linking and replaces the module with the same
*               name in NT250.LIB.
*
* Remarks     : The parameter cP2, cP3, cP4 and cColor are optional.
*               To avoid an overlay of the current output, the
*               function can be modified: Remove the "*" to activate
*               these commands, and deactivate the commands marked with
*               &&* by providing them with "*".
*
**************************************************************************

#define PROMPT_BLANKS   3

**************************************************************************

FUNCTION WINMENU(cHeader, cP1, cP2, cP3, cP4, cColor)
  LOCAL i, nCols, nHeaderRows
  LOCAL nOldWin := WSELECT()
  LOCAL nPCols  := LEN(cP1)
  LOCAL nResult := 1
  LOCAL nWTop, nWLeft, nWBottom, nWRight

* LOCAL nOldRow := WROW() +ROW()
* LOCAL nOldCol := WCOL() +COL()

  IF cP2 <> NIL
    nPCols := nPCols +PROMPT_BLANKS +LEN(cP2)
    IF cP3 <> NIL
      nPCols := nPCols +PROMPT_BLANKS +LEN(cP3)
      IF cP4 <> NIL
        nPCols := nPCols +PROMPT_BLANKS +LEN(cP4)
      ENDIF
    ENDIF
  ENDIF

  nCols := nPCols

  nHeaderRows := NUMTOKEN(cHeader, ";")
  FOR i = 1 TO nHeaderRows
    nCols := MAX(nCols, LEN(TOKEN(cHeader, ";", i)))
  NEXT

  nWBottom := 3 +nHeaderRows
  nWRight  := 3 +nCols

  WSELECT(0)

  nWTop    := WFROW() +((WFLASTROW() -WFROW()) -nWBottom) /2  &&*
  nWBottom += nWTop                                           &&*
                                                              &&*
  nWLeft   := WFCOL() +((WFLASTCOL() -WFCOL()) -nWRight)  /2  &&*
  nWRight  += nWLeft                                          &&*


* IF nOldRow < MAXROW() /2
*    nWTop    := WFLASTROW() -nWBottom
*    nWBottom := WFLASTROW()
* ELSE
*    nWTop := 0
* ENDIF
*
* IF nOldCol < MAXCOL() /2
*    nWLeft  := WFLASTCOL() -nWRight
*    nWRight := WFLASTCOL()
* ELSE
*    nWRight := 0
* ENDIF


  WOPEN(nWTop, nWLeft, nWBottom, nWRight)

  DO CASE
  CASE cCOLOR <> NIL
    SETCOLOR(cColor)
  CASE ISCOLOR()
    SETCOLOR("W+/R, W+/B")
  OTHERWISE
    SETCOLOR("N/W, W/N")
  ENDCASE

  WBOX(1)
  WFORMAT(0, 1, 0, 1)

  FOR i = 1 TO nHeaderRows
    DISPOUT(CENTER(TOKEN(cHeader, ";", i), .T.))
    SETPOS(i, 0)
  NEXT

  @ ROW() +1, (MAXCOL() -nPCols) /2 PROMPT cP1

  IF cP2 <> NIL
    @ROW(), COL() +PROMPT_BLANKS PROMPT cP2
    IF cP3 <> NIL
      @ROW(), COL() +PROMPT_BLANKS PROMPT cP3
      IF cP4 <> NIL
        @ROW(), COL() +PROMPT_BLANKS PROMPT cP4
      ENDIF
    ENDIF
  ENDIF

  MENU TO nResult

  WCLOSE()
  WSELECT(nOldWin)

RETURN( nResult )

**************************************************************************
**************************************************************************
* EOF P_WMENU.PRG
