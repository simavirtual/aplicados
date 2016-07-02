*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : USRGRP.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 02/10/92
* Author      : Ralf Saborowski
* Description : Source code for NNETADDGRP(),NNETREMGRP()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : USRGRP can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               CT.LIB.
*
**************************************************************************
#include "ctnnet.ch"

FUNCTION NNETADDGRP(cGruppe,acBenutzer,cnServer)
RETURN(USRGRP(acBenutzer,cnServer,{|x|ADDUSR2GRP(cGruppe,x)}))

FUNCTION NNETREMGRP(cGruppe,acBenutzer,cnServer)
RETURN(USRGRP(acBenutzer,cnServer,{|x|REMUSRFRGRP(cGruppe,x)}))


STATIC FUNCTION USRGRP(acBenutzer,cnServer,bAktion)
  LOCAL nOut:=0
  LOCAL i
  LOCAL cOldServer:=NNETSNAME()

  IF VALTYPE(cnServer)!='U' .AND. !NNETSETSRV(cnServer)
    RETURN(0)
  ENDIF

  IF VALTYPE(acBenutzer)='A'
    FOR i = 1 TO LEN(acBenutzer)
      IF EVAL(bAktion,acBenutzer[i])
        nOut++
      ENDIF
    NEXT i
  ELSE
    nOut=IF(EVAL(bAktion,acBenutzer),1,0)
  ENDIF

  NNETSETSRV(cOldServer)
RETURN(nOut)

STATIC FUNCTION ADDUSR2GRP(cGruppe,cBenutzer)
  LOCAL lOut:=.F.

  IF NNETADDSET(cGruppe,OBJ_GROUP,'GROUP_MEMBERS',cBenutzer)
    NNETADDSET(cBenutzer,OBJ_USER,"GROUPS_I'M_IN",cGruppe,OBJ_GROUP)
    NNETADDSET(cBenutzer,OBJ_USER,"SECURITY_EQUALS",cGruppe,OBJ_GROUP)
    lOut=.T.
  ENDIF

RETURN(lOut)

STATIC FUNCTION REMUSRFRGRP(cGruppe,cBenutzer)
  LOCAL lOut:=.F.

  IF NNETDELSET(cGruppe,OBJ_GROUP,'GROUP_MEMBERS',cBenutzer)
    NNETDELSET(cBenutzer,OBJ_USER,"GROUPS_I'M_IN",cGruppe,OBJ_GROUP)
    NNETDELSET(cBenutzer,OBJ_USER,"SECURITY_EQUALS",cGruppe,OBJ_GROUP)
    lOut=.T.
  ENDIF

RETURN(lOut)