*************** Source code Nantucket Tools II / 5.0 ***********************
*
* Program     : P_OURGET.PRG
* Copyright   : (c) 1991, Nantucket Corp.  All rights reserved.
* Date        : 07/06/91
* Author      : Lothar Bongartz
* Description : Source code for GETINPUT()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : P_OURGET can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               NT250.LIB.
*
**************************************************************************

FUNCTION GETINPUT(xSource, nRow, nCol, lSay, xSay, cPic, bValid, bWhen)
LOCAL nOldRow := ROW(), nOldCol := COL(), GetList[1]

  IF nRow = NIL
    nRow := nOldRow
  ENDIF
  IF nCol = NIL
    nCol := nOldCol
  ENDIF
  IF lSay = NIL
    lSay := .F.
  ENDIF

  SetPos(nRow, nCol)

  IF xSay <> NIL
    DispOut(xSay)
    nCol := COL() +1
    SetPos(nRow, nCol)
  ENDIF

  IF xSource = NIL
    RETURN( "" )
  ENDIF

  GetList[1] := _GET_(xSource, "_GETINPUT", cPic, bValid, bWhen)

  ReadModal(GetList)

  IF lSay
    SetPos(nRow, nCol)
    DispOut(xSource)
  ENDIF

  SetPos(nOldRow, nOldCol)

RETURN( xSource )

**************************************************************************
**************************************************************************
* EOF P_OURGET.PRG

