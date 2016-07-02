
******************************************************************************
*                                                                            *
* IPXCHAT.PRG - demonstration program for NOVLIB's IPX functions             *
* Copyright (C) 1993 ASM Inc     .  All Rights Reserved.                     *
* by Goth                                                                    *
*                                                                            *
* Usage: IPXCHAT <UserName>                                                  *
*                                                                            *
* a chat program for two workstations to chat with each other                *
*                                                                            *
******************************************************************************


PUBLIC cSBuffer, cRBuffer, nConnNo, nMyConnNo, cFarAddress, nKey, nMemOld, nMemNew, nCol, nSecs
PUBLIC cAddress

parameters CmdLine


CmdLine = iif(type("CmdLine") = "U", "", CmdLine)

#include "novlib.ch"

clear

set escape on                 // can't see why we bother with all this
set scoreboard off
setcancel(.t.)
set cursor on
set date british
set confirm on
set wrap on

if !empty(CmdLine)

  nConnNo := USRCONLST( CmdLine )
  nMyConnNo := WSCONNUMGET()

  if !( nConnNo > 0 )
    ? "User "+CmdLine+" not logged in"    // this will work even if he's not
    quit                                  // but you'll need to find his
  else                                    // physical address
    do while ( ( nConnNo := USRCONLST() ) == nMyConnNo )
    enddo
  endif

  cFarAddress := WSNETADRGET( nConnNo )+WSNDEADRGET( nConnNo )+"5555"

  ? IPXSktOpn()

  if( NWERRORGET() != 0 )
    ? "IPX Error."
    quit
  endif

else

  ? "Usage: IPXCHAT <UserName>"
  quit
endif

set cursor off

cAddress := substr( cFarAddress, 1, 8 ) + ":" + substr( cFarAddress, 9, 12 ) + ":" + substr( cFarAddress, 21, 4 )

@1,0 to 1,79

@13,0 to 13,79

@22,0 to 22,79 double

set color to "w/n,w/n"

@12,0 say "R>"
@21,0 say "S>"

nMemNew := memory(0)
nCol := 0

IPXEvtIni( "ONIPX" )

do while .t.

  nMemOld := nMemNew

  nMemNew = memory(0)

  @0,0 say " NE:"+str( NWERRORGET(), 4 )+;
           " SN:"+ltrim(NOVSTRHEXGET(IPXSktNumGet()))+;
           " FA:"+cAddress

  nSecs := seconds()

  do while( nKey := inkey() ) == 0

    datalen = 0

    cRBuffer := IPXPktGet(@datalen)

    if ( NWERRORGET() == 0 )
      scroll( 3,0,12,79,1 )
      @ 12,0 say "R> "+cRBuffer
    else
      if nSecs != seconds()
        nSecs := seconds()
        @ 24,0 clear
        @ 24, nCol say "IPX Polling !"
        if nCol < 79
          nCol++
        else
          nCol := 0
        endif
      endif
    endif

  enddo

  if lastkey() = 27
    exit
  endif

  if lastkey() != 13

    cSBuffer = chr( nKey ) + space(71)

    @21,3 get cSBuffer

    clear typeahead

    KEYBOARD chr(4)

    set cursor on

    read

    set cursor off

    IPXPktSnd( cFarAddress, ALLTRIM(cSBuffer) )

    if lastkey() = 27
      exit
    endif

  endif

  scroll(14,0,21,79,1)
  @21, 0 say "S>"

enddo

IPXSktCls()

set color to

set cursor on

@ 24,0

RETURN

FUNCTION ONIPX()  // this is the event

static nECol := 0

  @ 23,0 clear
  @ 23, nECol say "IPX Event !"
  if nECol < 79
    nECol++
  else
    nECol := 0
  endif

RETURN

