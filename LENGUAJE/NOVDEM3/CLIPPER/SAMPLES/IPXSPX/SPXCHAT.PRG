
******************************************************************************
*                                                                            *
* SPXCHAT.PRG - demonstration program for NOVLIB's SPX functions             *
* Copyright (C) 1993 ASM Inc     .  All Rights Reserved.                     *
* by Goth                                                                    *
*                                                                            *
* Usage:                                                                     *
* To connect: SPXCHAT <USRGETNME>                                             *
* To Listen: SPXCHAT                                                         *
*                                                                            *
* a chat program for two or more workstations to chat with each other        *
*                                                                            *
* IMPORTANT NOTE:                                                            *
*                                                                            *
* When linking using EXOSPACE, you must include the line:                    *
*                                                                            *
* EXO PAC IPX,IPXCT                                                          *
*                                                                            *
* Due to a bug in earlier versions of ExoSpace the SPX functions only work   *
* with ExoSpace versions 1.0e or greater.                                    *
*                                                                            *
*                                                                            *
******************************************************************************


PUBLIC cSBuffer, cRBuffer, nConnNo, nMyConnNo, cFarAddress, nKey, nMemOld, nMemNew, nCol, nSecs, nRConnNo, nSConnNo

parameters CmdLine


CmdLine = iif(type("CmdLine") = "U", "", CmdLine)

#include "novlib.ch"

clear

set escape on                             // can't see why we bother with all this
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

  cFarAddress := WSNETADRGET( nConnNo )+WSNDEADRGET( nConnNo )+"4545"

  ? "Trying to connect"

  nConnNo = SPXConnect( cFarAddress )

  if( NWERRORGET() != 0 )
    ? "Error connecting to partner",NWERRORGET()
    quit
  endif

  nConnNo = SPXConnect( cFarAddress )

  if( NWERRORGET() != 0 )
    ? "Error connecting to partner",NWERRORGET()
    SPXDisconnect(1)
    quit
  endif

else
  ? "Listening....."

  nConnNo = SPXConnect()

  if( NWERRORGET() != 0 )
    ? NWERRORGET()
    ? "No one there"
    quit
  endif

  nConnNo = SPXConnect()

  if( NWERRORGET() != 0 )
    ? NWERRORGET()
    SPXDisconnect(1)
    ? "No one there"
    quit
  endif

endif

set cursor off

cFarAddress := substr( SPXAdrGet(nConnNo), 1, 8 ) + ":" + substr( SPXAdrGet(nConnNo), 9, 12 ) +;
                                                    ":" + substr( SPXAdrGet(nConnNo), 21, 4 )

@1,0 to 1,79

@13,0 to 13,79

@22,0 to 22,79 double

set color to "w/n,w/n"

@12,0 say "R>"
@21,0 say "S> <ENTER> to send or <ESC> to quit"

nMemNew := memory(0)
nCol := 0

SPXEvtIni( "ONSPX" )

nRConnNo = 1

do while .t.

  nMemOld := nMemNew

  nMemNew = memory(0)

  @0,0 say "M1:"+ltrim(str(nMemOld))+;
           " M2:"+ltrim(str(nMemNew))+;
           " NE:"+str( NWERRORGET(), 4 )+;
           " CN:"+ltrim(str(SPXConnGet(nRConnNo)))+;
           " SN:"+ltrim(NOVSTRHEXGET(SPXSktGet(nRConnNo)))+;
           " FA:"+cFarAddress

  nSecs := seconds()

  // this version polls for incoming packets

  do while( nKey := InKey() ) == 0

    // this is all diagnostic stuff

    size = 0
    cRBuffer := SPXPktGet(nRConnNo, @size)

    if ( NWERRORGET() == 0 )

      cFarAddress := substr( SPXAdrGet(nRConnNo), 1, 8 ) + ":" + substr( SPXAdrGet(nRConnNo), 9, 12 ) +;
                                                        ":" + substr( SPXAdrGet(nRConnNo), 21, 4 )

      scroll( 3,0,12,79,1 )
//      @ 12,0 say "R("+ltrim(str(nRConnNo))+")> "+cRBuffer
      @ 12,0 say "R("+ltrim(str(nRConnNo))+")><"+ltrim(str(size))+"> "+cRBuffer
    else
      if nSecs != seconds()
        nSecs := seconds()
        @ 24,0 clear
        @ 24, nCol say "SPX Polling !"
        if nCol < 79
          nCol++
        else
          nCol := 0
        endif
      endif
    endif

    if( nRConnNo < 10 )
      nRConnNo++
    else
      nRConnNo = 1
    endif

  enddo

  if lastkey() = 27
    exit
  endif

  nSConnNo := 0
  cSBuffer := space(71)

  set cursor on

  @21,2 clear to 21,79
  @21,2 say "Enter Connection No:" get nSConnNo range 1, 10

  read

  @21,2 clear to 21,79
  @21,2 say "Enter Message:" get cSBuffer

  read

  set cursor off

  if lastkey() = 27
    exit
  endif

  SPXPktSnd( nSConnNo, ALLTRIM(cSBuffer) )

  if( NWERRORGET() != 0 )
    cSBuffer := "Error: Connection number not valid, or partner has terminated connection"
  endif


  @21, 0 say "S("+ltrim(str(nSConnNo))+")> "+cSBuffer

  scroll(14,0,21,79,1)
  @21,0 say "S> <ENTER> to send or <ESC> to quit"

enddo

SPXDisconnect(1)
SPXDisConnect(2)

set color to

set cursor on

@ 24,0

RETURN

FUNCTION ONSPX()  // this is the event routine

static nECol := 0

  @ 23,0 clear
  @ 23, nECol say "SPX Event !"
  if nECol < 79
    nECol++
  else
    nECol := 0
  endif

RETURN

