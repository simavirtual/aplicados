// slist.prg
//
// this program uses NOVLIB functions to emulate NetWare's SLIST.EXE
// command line utility.
//
// by Goth.
//
#include "novlib.ch"

LOCAL cDefServer, cServerName, cNode, cAddress, cStatus, nCounter, nServerCount

cDefServer = FSNMEGET()
nServerCount := 0

if !empty( cDefServer )

  ? "Known NetWare File Servers                      Network   Node Address Status"
  ? "--------------------------                      -------   ------------ ------"

  cServerName := FSOBJLST( "*", OT_FILE_SERVER, .T. )

  do while !empty( cServerName )

    cNode := "["
    nServerCount++
    for nCounter = 1 to 4
      cNode := cNode + right( NOVSTRHEXGET( ITMPRPBYTGET( cServerName,;
                 OT_FILE_SERVER, "NET_ADDRESS", nCounter ) ), 2 )
    next

    cNode := cNode + "]"

    cAddress := "["

    for nCounter = 5 to 10
      cAddress := cAddress + right( NOVSTRHEXGET( ITMPRPBYTGET( cServerName,;
                 OT_FILE_SERVER, "NET_ADDRESS", nCounter ) ), 2 )
    next

    cAddress := cAddress + "]"

    cStatus := ""

    if ( cDefServer == cServerName )
      cStatus := "Default"
    elseif FSCONIDGET( cServerName ) > 0
      cStatus := "Attached"
    endif

    ? padr( cServerName, 36 )+"           "+cNode+cAddress+cStatus

    cServerName := FSOBJLST("", OT_FILE_SERVER, .F.)

  enddo

  ?
  ? "Total of "+LTRIM(STR(nServerCount))+" file servers found"

endif

