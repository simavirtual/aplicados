*********** Sample programs for CA-Clipper Tools / 5.2 ************
*
* Program     : RPRINTER.PRG
* Copyright   : (c) 1992-93, Computer Associates International.
*               All rights reserved.
* Date        : 06/05/92
* Author      : Ralf Saborowski
* Description : RPRINTER Emulation demo using CA Clipper Tools'
*               print server and Point To Point Communication
*               functions.
*
*               Configure an unused printer of a print server
*               as remote printer and then call RPRINTER with
*               the name of the print server and the number
*               of the remote printer:
*
*               RPRINTER <PrintServerName> <PrinterNumber> [<FileServer>]
*
*               Any output directed to the specified remote printer
*               will be displayed on the screen after that.
*
* Compiling   : CLIPPER RPRINTER
* Linking     : RTLINK FI RPRINTER LIB CT
*
*******************************************************************

#include "ctnnet.ch"

PARAMETERS  cPServer,nPrinter,cFServer


LOCAL aInfo                   // Return value of NNETPSRRP()
LOCAL nHandle,nSocket
LOCAL cNetAdr,cProp


IF PCOUNT()<2
  ?
  ? 'Usage: RPRINTER <PrintServerName> <PrinterNumber> [<FileServer>]'
  ?
  QUIT
ENDIF

nPrinter=VAL(nPrinter)

IF VALTYPE(cFServer)='C'
  IF !NNETSETSRV(cFServer)
    ?
    ? 'Invalid File Server specified!'
    ?
    QUIT
  ENDIF
ENDIF

BEGIN SEQUENCE

  // Get inter netaddress of print server
  IF EMPTY(cProp:=NNETRDITM(cPServer,OBJ_ADVPRINTSERVER,'NET_ADDRESS',,.T.))
    ? 'Print Server does not exist!'
    BREAK
  ENDIF

  cNetAdr=HEXTOSTR(LEFT(cProp,10))

  // request remote printer
  aInfo=NNETPSRRP(cPServer,nPrinter)

  // successfull full?
  IF LEN(aInfo)=0
    ? 'Remote-Printer'+STR(nPrinter,4)+' not available!'
    BREAK
  ENDIF

  // open any socket
  nSocket=OPENSOCK(0)

  // setup SPX connection to print server,
  // target socket number is aInfo[10]

  nHandle=SPXESTBCON(nSocket,512,512,cNetAdr,aInfo[10],512)

  PPCWRITE(nHandle,CHR(nPrinter)+CHR(1)+CHR(1)+CHR(0)+CHR(0))

  IF !nnetpssrm(cPServer,nPrinter,.t.)
    ?
    ? 'Error setting up connection! Error code:',nnetpserr()
    ?
    QUIT
  ENDIF

  ?
  WHILE INKEY()=0
    IF PPCRECCNT(nHandle)>0
      ?? PPCREAD(nHandle)
      PPCWRITE(nHandle,CHR(nPrinter)+CHR(1)+CHR(1)+CHR(0)+CHR(0))
    ENDIF
  ENDDO

  wait

  PPCCANCEL(nHandle)
  CLOSESOCK(nSocket)

END

RETURN               // That's all folks!