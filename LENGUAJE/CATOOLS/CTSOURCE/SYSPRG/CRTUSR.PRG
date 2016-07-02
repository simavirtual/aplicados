*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : CRTUSR.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 02/10/92
* Author      : Ralf Saborowski
* Description : Source code for NNETCRTUSR()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : CRTUSR can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               CT.LIB.
*
**************************************************************************
#include "ctnnet.ch"

FUNCTION NNETCRTUSR(cName,cPass,cVollName,lSuper,cnServer)
  LOCAL lOut:=.F.
  LOCAL i
  LOCAL cOldServer:=NNETSNAME()
  LOCAL cMail
  LOCAL cIdProp:='IDENTIFICATION'
  LOCAL cLoginProp:='LOGIN_CONTROL'
  LOCAL cSecProp:='SECURITY_EQUALS'
  LOCAL cGroup:="GROUPS_I'M_IN"
  LOCAL cEvery:='EVERYONE'

  IF VALTYPE(cnServer)='C' .AND. !NNETSETSRV(cnServer)
    RETURN(lOut)
  ENDIF

  IF NNETCRTOBJ(cName)
    // create properties
    NNETCRTPRP(cName,OBJ_USER,'PASSWORD',PRP_ITEM,68)
    NNETCPASS(cName,OBJ_USER,'',IF(VALTYPE(cPass)='C',cPass,''))

    NNETCRTPRP(cName,OBJ_USER,cSecProp,PRP_SET,50)

    // Full name specified?
    IF VALTYPE(cVollName)='C'
      NNETCRTPRP(cName,OBJ_USER,cIdProp)
      NNETWRTITM(cName,OBJ_USER,cIdProp,cVollName)
    ENDIF

    // Create groups property
    NNETCRTPRP(cName,OBJ_USER,cGroup,PRP_SET)

    // add group EVERYONE
    NNETADDSET(cName,OBJ_USER,cGroup,cEvery,OBJ_GROUP)
    NNETADDSET(cName,OBJ_USER,cSecProp,cEvery,OBJ_GROUP)

    // create LOGIN_CONTROL property
    NNETCRTPRP(cName,OBJ_USER,cLoginProp)
    NNETWRTITM(cName,OBJ_USER,cLoginProp,;
               REPLICATE(CHR(0),4)+NNETRDITM('SUPERVISOR',,'USER_DEFAULTS',1,.T.))

    IF VALTYPE(lSuper)='L' .AND. lSuper
       NNETADDSET(cName,OBJ_USER,cSecProp,"SUPERVISOR",OBJ_USER)
    ENDIF
    lOut=.T.

    cMail='SYS:MAIL/'+REMLEFT(NNETUSERID(cName),'0')

    // create mail directory and set trustee rights
    IF NNETVER()<'3'
      NNETMKDIR(cMail,'RWOCDSMP')
      NNETTRUST(cName,OBJ_USER,cMail,'RWOCDSM')
    ELSE
      NNETMKDIR(cMail,'SMFAECWR')
      NNETTRUST(cName,OBJ_USER,cMail,'RWCESM')
    ENDIF

  ENDIF

  NNETSETSRV(cOldServer)
RETURN(lOut)