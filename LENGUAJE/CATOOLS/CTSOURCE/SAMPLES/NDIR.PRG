*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : NDIR.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : Don't know...
* Author      : Ralf Saborowski
* Description : Simple extended directory utility for network
*               drives. Will display extended directory informations
*               for the current drive, if it is a network drive.
*
* Compiling   : CLIPPER NDIR
* Linking     : RTLINK FI NDIR LIB CT
*
*******************************************************************

#include "ctnnet.ch"

LOCAL aFiles
LOCAL aSalFiles
LOCAL aDirs
LOCAL i,cAnswer


IF ISBIT(NNETMAPMOD(),8)

  ? 'No Network drive!'
  QUIT

ENDIF

?
?
? 'Files in '+NNETMAPINF()+':'
?
? 'Name                Size    Creation  LastUpd  Owner'
? '===================================================='

aFiles=NNETFILES()

FOR i=1 TO LEN(aFiles)

  ?  PADR(aFiles[i,NF_NAME],14)
  ?? aFiles[i,NF_SIZE]
  ?? '    '
  ?? aFiles[i,NF_CREADATE]
  ?? '  '
  ?? aFiles[i,NF_UPDDATE]
  ?? ' '+aFiles[i,NF_OWNER]

NEXT i


?
WAIT

?
?
? 'Directories in '+NNETMAPINF()+':'
?
aDirs=NNETDIRS(,,.T.)

? 'Name          Creation  LastUpd  Owner'
? '======================================='

FOR i=1 TO LEN(aDirs)

  ?  PADR(aDirs[i,ND_NAME],14)
  ?? aDirs[i,ND_CREADATE]
  ?? '  '
  ?? aDirs[i,ND_UPDDATE]
  ?? ' '+aDirs[i,ND_OWNER]

NEXT i


?
WAIT

?
?
? 'Salvageable files in '+NNETMAPINF()+':'
?
? 'Name                Size    Del. Date  Del. Time  Deletor'
? '========================================================='

aSalFiles=NNETSALLST()

FOR i=1 TO LEN(aSalFiles)

  ?  PADR(aSalFiles[i,SAL_NAME],14)
  ?? aSalFiles[i,SAL_SIZE]
  ?? '    '
  ?? aSalFiles[i,SAL_DATE]
  ?? '   '
  ?? aSalFiles[i,SAL_TIME]
  ?? '   '+aSalFiles[i,SAL_DELETOR]

NEXT i

?

ACCEPT 'Purge all (YES/NO) ? ' TO cAnswer

IF UPPER(cAnswer)=="YES"
  AEVAL(aSalFiles,{|x|NNETPURGE(x[SAL_NAME])})
ENDIF