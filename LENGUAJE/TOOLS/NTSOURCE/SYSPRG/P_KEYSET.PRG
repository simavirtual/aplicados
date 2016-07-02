*************** Source code Nantucket Tools II / 5.0 ***********************
*
* Program     : P_KEYSET.PRG
* Copyright   : (c) 1991, 1992 Nantucket Corp.  All rights reserved.
* Date        : 01/15/92
* Author      : Lothar Bongartz
* Description : source code for SAVESETKEY() and RESTSETKEY()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : P_KEYSET can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               NT250.LIB.
*
**************************************************************************

FUNCTION SAVESETKEY()
  LOCAL i, n, cKeyList := _KEYLIST(), aKeySet

  aKeySet := {_KEYLIST()}

  n := LEN(cKeyList)

  FOR i = 1 TO n STEP 2
    AADD( aKeySet, SETKEY( BIN2I( SUBSTR( cKeyList, i, 2 ) ) ) )
  NEXT

RETURN( aKeySet )

**************************************************************************

FUNCTION RESTSETKEY(aKeySet)
  LOCAL i, n, cKeyList

  _CLEARKEY()

  IF LEN(aKeySet) > 0
    cKeyList := aKeySet[1]
    n := LEN(cKeyList)

    FOR i = 1 TO n STEP 2
      SETKEY( BIN2I( SUBSTR( cKeyList, i, 2 ) ), aKeySet[(i +3) /2] )
    NEXT
  ENDIF

RETURN( .T. )

**************************************************************************
**************************************************************************
* EOF P_KEYSET.PRG
