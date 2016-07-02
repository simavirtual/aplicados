*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : QPROP.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 04/13/92
* Author      : Ralf Saborowski
* Description : Source code for NNETQUSERS(), NNETQOPS(), NNETQDIR(),
* Compiling   : /l /m /n /w /v /r
*
* Linking     : QPROP can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               CT.LIB.
*
**************************************************************************
#include "ctnnet.ch"

FUNCTION NNETQUSERS(cQueue,cnServer)
RETURN(q(cQueue,'Q_USERS',cnServer))

FUNCTION NNETQOPS(cQueue,cnServer)
RETURN(q(cQueue,'Q_OPERATORS',cnServer))

FUNCTION NNETQDIR(cQueue,cnServer)
  LOCAL cOut
  LOCAL cProp:='Q_DIRECTORY'

  IF VALTYPE(cnServer)='U'
    cOut=NNETRDITM(cQueue,_NNETQTYPE(),cProp)
  ELSE
    cOut=NNETRDITM(cQueue,_NNETQTYPE(),cProp,cnServer)
  ENDIF
RETURN(cOut)

STATIC FUNCTION Q(cQueue,cProp,cnServer)  // Hey, where's Suzi...?
  LOCAL cOldServer:=NNETSNAME()
  LOCAL i
  LOCAL aOut:={}

  IF VALTYPE(cnServer)!='U' .AND. !NNETSETSRV(cnServer)
    RETURN(aOut)
  ENDIF

  aOut=NNETRDSET(cQueue,_NNETQTYPE(),cProp)
  FOR i = 1 TO LEN(aOut)
    aOut[i]=NNETOBJNAM(aOut[i])
  NEXT i

  NNETSETSRV(cOldServer)
RETURN(aOut)