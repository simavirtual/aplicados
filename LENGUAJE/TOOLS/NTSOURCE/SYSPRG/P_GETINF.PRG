*************** Source code Nantucket Tools II / 5.0 ***********************
*
* Program     : P_GETINF.PRG
* Copyright   : (c) 1991, 1992 Nantucket Corp.  All rights reserved.
* Date        : 01/15/92
* Author      : Lothar Bongartz
* Description : Source code for GET functions
* Compiling   : /l /m /n /w /v /r
*
* Linking     : P_GETINF can be added to the .OBJ file list during linking
*               and replaces the module with the same name in NT250.LIB.
*
* Remarks     : As already mentioned within the documentation, the
*               following functions are simply to realize under Clipper 
*               5.0.  They have been retained in Tools for compatibility
*               reasons only.
*
**************************************************************************

MEMVAR GetList

**************************************************************************

FUNCTION SAVEGETS
  LOCAL cList := GetList
  GetList := {}
RETURN( cList )

**************************************************************************

FUNCTION RESTGETS(cList)
RETURN( (GetList := cList) <> NIL )

**************************************************************************

FUNCTION COUNTGETS
RETURN( LEN(GetList) )

**************************************************************************

FUNCTION CURRENTGET
  LOCAL i, n := LEN(GetList)

  FOR i = 1 TO n
    IF GetList[i] == getactive()
      RETURN( i )
    ENDIF
  NEXT i

RETURN( 0 )

**************************************************************************

FUNCTION GETFLDROW(nGetNum)
  IF nGetNum = NIL
    nGetNum := CURRENTGET()
  ENDIF
  IF nGetNum < 1 .OR. nGetNum > LEN(GetList)
    RETURN( -1 )
  ENDIF
RETURN( GetList[nGetNum]:row )

**************************************************************************

FUNCTION GETFLDCOL(nGetNum)
  IF nGetNum = NIL
    nGetNum := CURRENTGET()
  ENDIF
  IF nGetNum < 1 .OR. nGetNum > LEN(GetList)
    RETURN( -1 )
  ENDIF
RETURN( GetList[nGetNum]:col )

**************************************************************************

FUNCTION GETFLDVAR(nGetNum)
  IF nGetNum = NIL
    nGetNum := CURRENTGET()
  ENDIF
  IF nGetNum < 1 .OR. nGetNum > LEN(GetList)
    RETURN( "" )
  ENDIF
RETURN( GetList[nGetNum]:name )

**************************************************************************
**************************************************************************
* EOF P_GETINF.PRG
