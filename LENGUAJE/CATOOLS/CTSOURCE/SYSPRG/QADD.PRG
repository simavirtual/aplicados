*********** Source code for CA-Clipper Tools / 5.2 functions **************
*
* Program     : QADD.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 04/13/92
* Author      : Ralf Saborowski
* Description : Source code for NNETADDQUS(), NNETADDQOP(), NNETADDQSV(),
*               NNETREMQUS(), NNEREMQOP(), NNETREMQSV()
* Compiling   : /l /m /n /w /v /r
*
* Linking     : QADD can be added to the .OBJ file list during
*               linking and replaces the module with the same name in
*               CT.LIB.
*
**************************************************************************
#include "ctnnet.ch"

FUNCTION NNETADDQUS(cQueue,acBenutzer,cnServer)
RETURN(suzi_q(cQueue,acBenutzer,'Q_USERS',cnServer,.T.))

FUNCTION NNETADDQOP(cQueue,acOp,cnServer)
RETURN(suzi_q(cQueue,acOp,'Q_OPERATORS',cnServer,.T.))

FUNCTION NNETADDQSV(cQueue,acServer,cnServer)
RETURN(suzi_q(cQueue,acServer,'Q_SERVERS',cnServer,.T.))

FUNCTION NNETREMQUS(cQueue,acBenutzer,cnServer)
RETURN(suzi_q(cQueue,acBenutzer,'Q_USERS',cnServer,.F.))

FUNCTION NNETREMQOP(cQueue,acOp,cnServer)
RETURN(suzi_q(cQueue,acOp,'Q_OPERATORS',cnServer,.F.))

FUNCTION NNETREMQSV(cQueue,acServer,cnServer)
RETURN(suzi_q(cQueue,acServer,'Q_SERVERS',cnServer,.F.))

// Oh Suzi Q, I still love you, my Suzi Q....
STATIC FUNCTION suzi_q(cQueue,acObj,cPropName,cnServer,lModus)
  LOCAL nAnzahl:=0
  LOCAL i
  LOCAL cOldServer:=NNETSNAME()

  IF VALTYPE(cnServer)!='U' .AND. !NNETSETSRV(cnServer)
    RETURN(0)
  ENDIF

  IF VALTYPE(acObj)='A'
    FOR i = 1 TO LEN(acObj)
      IF aktion(cQueue,_NNETQTYPE(),cPropName,acObj[i],lModus)
        nAnzahl++
      ENDIF
    NEXT i
  ELSE
    nAnzahl=IF(aktion(cQueue,_NNETQTYPE(),cPropName,acObj,lModus),1,0)
  ENDIF

  NNETSETSRV(cOldServer)

RETURN(nAnzahl)

STATIC FUNCTION aktion(cQueue,nTyp,cPropName,cObj,lModus)
  LOCAL lErfolg

  IF lModus
    lErfolg=NNETADDSET(cQueue,nTyp,cPropName,cObj)
  ELSE
    lErfolg=NNETDELSET(cQueue,nTyp,cPropName,cObj)
  ENDIF

RETURN(lErfolg)