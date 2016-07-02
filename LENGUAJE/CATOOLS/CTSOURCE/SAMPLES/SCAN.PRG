*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : SCAN.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Author      : Ralf Saborowski
* Description : Primitive bindery scanner.
*               Compile, run and wonder....
* Compiling   : CLIPPER SCAN
* Linking     : RTLINK FI SCAN LIB CT
*
*******************************************************************
#include "ctnnet.ch"

STATIC aTypes:={  'Wild',;
                  'Unkown',;
                  'User',;
                  'Group',;
                  'Print-Queue',;
                  'File-Server',;
                  'Job-Server  ',;
                  'Gateway',;
                  'Print-Server',;
                  'Archive-Queue',;
                  'Archive-Server',;
                  'Job-Queue',;
                  'Admin',;
                  'Bridge-Server',;
                  'Adv. Print-Server'  }

STATIC aTypeCodes:={OBJ_WILD,;
                    OBJ_UNKNOWN,;
                    OBJ_USER,;
                    OBJ_GROUP,;
                    OBJ_PRINTQUEUE,;
                    OBJ_FILESERVER,;
                    OBJ_JOBSERVER,;
                    OBJ_GATEWAY,;
                    OBJ_PRINTSERVER,;
                    OBJ_ARCHIVEQUEUE,;
                    OBJ_ARCHIVESERVER,;
                    OBJ_JOBQUEUE,;
                    OBJ_ADMIN,;
                    OBJ_BRIDGESERVER,;
                    OBJ_ADVPRINTSERVER }


FUNCTION main()

  LOCAL id:=-1
  LOCAL cName
  LOCAL nType,nId,nSec

  WHILE .T.
    nType=OBJ_WILD

    IF EMPTY(cName:=NNETSCNBIN('*',@nType,@id,,@nSec))
      EXIT
    ENDIF

    ? PADR(cName,20)+TYPE2STR(nType)+'0x'+NTOC(nSec,16)

  ENDDO

RETURN(NIL)


FUNCTION TYPE2STR(nTyp)
  LOCAL i,cOut

  IF (i:=ASCAN(aTypeCodes,nTyp))>0
    cOut=aTypes[i]
  ELSE
    cOut='Unknown'
  ENDIF

RETURN(PADR(cOut,30))
