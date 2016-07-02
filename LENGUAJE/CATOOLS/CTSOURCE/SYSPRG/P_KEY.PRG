*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : P_KEY.PRG
* Copyright   : (c) 1991-93, Computer Associates International.
*               All rights reserved.
* Date        : 07/06/91
* Author      : Lothar Bongartz
* Description : Source code for _SAVEKEY() and _RESTKEY()
*               _SAVEKEY() and _RESTKEY() are compatibility functions,
*               used within CT.CH for CSETKEY().
*
* Compiling   : /l /m /n /w /v /r
*
* Linking     : P_KEY can be added to the .OBJ file list during linking
*               and replaces the module with the same name in CT.LIB.
*
**************************************************************************

FUNCTION _SAVEKEY()
  LOCAL aKeySet := SAVESETKEY()

  AADD( aKeySet, _GETCKEY() )

RETURN( aKeySet )

**************************************************************************

FUNCTION _RESTKEY(aKeySet)

  _SETCKEY(aKeySet[LEN(aKeySet)])

RETURN( RESTSETKEY(aKeySet) )

**************************************************************************
**************************************************************************
* EOF P_KEY.PRG

