*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : CRTGRP.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 02/10/92
* Author      : Ralf Saborowski
* Description : Source code for NNETCRTGRP()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : CRTGRP can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               CT.LIB.
*
**************************************************************************
#include "ctnnet.ch"

FUNCTION NNETCRTGRP(cName,cVollName,cnServer)
  LOCAL lOut:=.F.
  LOCAL i
  LOCAL cOldServer:=NNETSNAME()

  IF VALTYPE(cnServer)='C' .AND. !NNETSETSRV(cnServer)
    RETURN(lOut)
  ENDIF

  IF NNETCRTOBJ(cName,OBJ_GROUP)

    // Full name specified?
    IF VALTYPE(cVollName)='C'
      NNETCRTPRP(cName,OBJ_GROUP,'IDENTIFICATION')
      NNETWRTITM(cName,OBJ_GROUP,'IDENTIFICATION',cVollName)
    ENDIF

    // create members property
    NNETCRTPRP(cName,OBJ_GROUP,"GROUP_MEMBERS",PRP_SET)

    lOut=.T.
  ENDIF

  NNETSETSRV(cOldServer)
RETURN(lOut)