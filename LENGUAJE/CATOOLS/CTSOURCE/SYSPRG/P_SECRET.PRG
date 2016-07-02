*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : P_SECRET.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 01/15/92
* Author      : Lothar Bongartz
* Description : Source code for GETSECRET()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : P_SECRET can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               CT.LIB.
*
**************************************************************************

STATIC _cGetSecret, _nRow, _nCol, _G, _nMaxLen, _nWSelect

**************************************************************************

FUNCTION GETSECRET(cSource, nRow, nCol, lSay, xSay, cPic, bValid, bWhen)
LOCAL nOldRow := ROW(), nOldCol := COL(), GetList[1], cOldTrap

  _nRow := IF(nRow = NIL, nOldRow, nRow)
  _nCol := IF(nCol = NIL, nOldCol, nCol)

  IF lSay = NIL
    lSay := .F.
  ENDIF

  SetPos(_nRow, _nCol)

  IF xSay <> NIL
    DispOut(xSay)
    _nCol := COL() +1
    SetPos(_nRow, _nCol)
  ENDIF

  IF CSETDELI()
    _nCol++
  ENDIF

  _cGetSecret := cSource

  GetList[1] := _GET_(_cGetSecret, "_CGETSECRET", cPic, bValid, bWhen)
  GetList[1]:row :=255

  _G := GetList[1]

  _nWSelect := WSELECT()
  _nMaxLen := MAXCOL() +1 - _nCol

  cOldTrap := TRAPINPUT("_SECRET")
  ReadModal(GetList)
  TRAPINPUT(cOldTrap)

  IF .NOT. lSay
    UNSELECTED()
  ENDIF

  @ _nRow, _nCol SAY RANGEREPL(33, 31, _cGetSecret, "*")
  STANDARD()

  SetPos(nOldRow, nOldCol)


RETURN( _cGetSecret )

**************************************************************************

PROCEDURE _SECRET
LOCAL lOldDSETWINDOW

  IF WSELECT() = _nWSelect .AND. READVAR() == "_CGETSECRET"

    _G:assign()

    lOldDSETWINDOW :=DSETWINDOW(.T.)
    SAYSCREEN(RANGEREPL(33, 31, LEFT(_cGetSecret, _nMaxLen), "*"), _nRow, _nCol)
    DSETWINDOW(lOldDSETWINDOW)
    SetPos(_nRow, COL())

  ENDIF

RETURN

**************************************************************************
**************************************************************************
* EOF P_SECRET.PRG
