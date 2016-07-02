*************** Source code Nantucket Tools II / 5.0 ***********************
*
* Program     : P_KEY.PRG
* Copyright   : (c) 1991, Nantucket Corp.  All rights reserved.
* Date        : 07/06/91
* Author      : Lothar Bongartz
* Description : Source code for _SAVEKEY() and _RESTKEY()
*               _SAVEKEY() and _RESTKEY() are compatibility functions,
*               used within NT250.CH for CSETKEY().
*
* Compiling   : /l /m /n /w /v /r
*
* Linking     : P_KEY can be added to the .OBJ file list during linking
*               and replaces the module with the same name in NT250.LIB.
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

