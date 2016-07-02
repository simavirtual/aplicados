#include "novlib.ch"

//
//
// By Goth & Malc
//
// Additional material by Dennis & Marvin at Lange Financial Corp.
//
//
//
//

FUNCTION NlAttach( a, b )

  LOCAL nOffset,cServerName,cUserName,nServerNum,nOldServer

  if ( "/" $ a )
    nOffset := at( "/", a )
    cServerName := substr( a, 1, nOffset - 1 )
    cUserName := substr( a, nOffset + 1 )
  else
    cServerName := a
  endif

  if !(b == NIL)
    nOldServer := FSPREFCONGET()
    nServerNum := FSWSATTACH( cServerName )
    FSPREFCONSET( nServerNum )
    FSWSLOGIN( cUserName, b )
    FSPREFCONSET( nOldServer )
  else
    FSWSATTACH( cServerName )
  endif

  RETURN( NIL )

//////////////////////////////////////////////////////////////////////////////

FUNCTION NlSetPass( a, b, c )

  LOCAL nOldServer,nOffset,cServerName,cUserName

  nOldServer := FSPREFCONGET()

  if !( c == NIL )
    if ( "/" $ a )
      nOffset := at( "/", a )
      cServerName := substr( a, 1, nOffset - 1 )
      cUserName := substr( a, nOffset + 1 )
    else
      cServerName := a
      cUserName = WSLOGNMEGET()
    endif
    FSPREFCONSET( FSCONIDGET( cServerName ) )
    USRPASSCHG( cUserName, b, c )
  else
    USRPASSCHG( WSLOGNMEGET(), a, b )
  endif

  FSPREFCONSET( nOldServer )

  RETURN( NIL )

//////////////////////////////////////////////////////////////////////////////

FUNCTION NlLogin( a, b )

  // commands not supported

  // #, too much hassle, things like CAPTURE are handled anyway
  // BREAK, you cant stop this one
  // DOS BREAK, you can add this one yourself if you want
  // PAUSE, whats the point
  // PCCOMPATIBLE, it is
  // REM[ARK], ignored anyway
  // SHIFT, not sure what it does !


  LOCAL nFileHandle,nFileLen,cText,nLenPointer,cFileName,cLine,nOffset, aItem
  LOCAL lReturnVal,nLineOff,nOldPrefID, i, cDelDrive, cLoginTime, dLoginDate
  PRIVATE cServer,cUser,cPassword,nOldServer,nNewServer
  PRIVATE xHOUR,xHOUR24,xMINUTE,xSECOND,xAM_PM,xMONTH,xMONTH_NAME,xDAY
  PRIVATE xDAY_OF_WEEK,xNDAY_OF_WEEK,xYEAR,xSHORT_YEAR,xLOGIN_NAME
  PRIVATE xFULL_NAME,xSTATION,xP_STATION,xGREETING_TIME,xOS_VERSION,xOS
  PRIVATE xMACHINE,xSMACHINE,xERROR_LEVEL,xMEMBER_OF,xPASSWORD_EXPIRES


  // actually login //

  if ( ( "/" $ a ) .OR. ( "\" $ a ) )
    nOffset := at( "/", a ) + at( "\", a )       // don't say anything !!
    cServer := substr( a, 1, nOffset - 1 )
    cUser := substr( a, nOffset + 1 )
  else
    cUser := a
    cServer := ""
  endif

  if !( b == NIL )
    cPassword := b
  else
    cPassword := ""
  endif

  if !( cServer == "" )
    if ( ( nOldPrefID := FSWSATTACH( cServer ) ) > 0 )
      FSPREFCONSET( nOldPrefID )
      if !(FSWSLOGIN( cUser,cPassword ))
        RETURN(.f.)
      endif
    else
      RETURN(.f.)
    endif
  else
    FSWSLOGOUT(FSPREFNMEGET(),.F.)
    if !(FSWSLOGIN( cUser,cPassword ))
      RETURN(.f.)
    endif
  endif

  // set up NetwareAlike variables

  cLoginTime := WSLOGTMEGET()
  dLoginDate := WSLOGDTEGET()

  xHOUR24        := substr(cLoginTime,1,2)
  xMINUTE        := substr(cLoginTime,4,2)
  xSECOND        := substr(cLoginTime,7,2)
  xAM_PM         := if( val(xHOUR24) <= 12, "AM", "PM" )
  xHOUR          := if( val(xHOUR24) <= 12, xHOUR24, str(val(xHOUR24) - 12, 2 ) )
  xMONTH         := str(month(dLoginDate),2)
  xMONTH_NAME    := cmonth(dLoginDate)
  xDAY           := str(day(dLoginDate),2)
  xDAY_OF_WEEK   := cdow(dLoginDate)
  xNDAY_OF_WEEK  := dow(dLoginDate)
  xYEAR          := str(year(dLoginDate),4)
  xSHORT_YEAR    := right(xYEAR,2)
  xLOGIN_NAME    := WSLOGNMEGET()
  xFULL_NAME     := USRFULNMEGET(WSLOGNMEGET())
  xSTATION       := ltrim(str(WSCONNUMGET()))
  xP_STATION     := WSNDEADRGET()
  xGREETING_TIME := "Good "+if( xAM_PM == "AM" , "morning", if( val(xHOUR24) > 17 ,"evening","afternoon"))
  xOS            := WSOSNMEGET()
  xOS_VERSION    := WSOSVERGET()
  xMACHINE       := WSLNGNMEGET()
  xSMACHINE      := WSSHTNMEGET()

  // look for system login script //

  DRVDIRMAP("SYS:PUBLIC",WSDRVNETGET() )
  cFileName := WSDRVNETGET() + ":" + "\PUBLIC\NET$LOG.DAT"

  if file( cFileName )

    nFileHandle := fopen( cFileName )

    if ferror() == 0

      nFileLen := fseek(nFileHandle,0,2)
      fseek(nFileHandle,0)

      cText := space(nFileLen)

      // might as well read the whole file in //

      if fread(nFileHandle,@cText,nFileLen) == nFileLen
        cText := alltrim(strtran(cText,chr(26),chr(13))) + chr(13)
      endif

      // here goes //

      do while (.t.)

        // find the end of the line //

        nOffset := at( chr(13), cText )

        if ( nOffset == 0 )
          exit
        endif

        cLine := upper(alltrim( substr( cText,1,nOffset-1) ))
        cText := alltrim( substr( cText, nOffset ) )

        if !NlParser( cLine )
          EXIT
        endif

      enddo

      fclose(nFileHandle)

    endif

  endif

  // look for user's login script //

  cText := ""

  cFileName := WSDRVNETGET() + ":" + "\MAIL\"+ltrim(NOVSTRHEXGET(WSLOGIDGET()))+"\LOGIN"

  if file( cFileName )

    nFileHandle := fopen( cFileName )

    if ferror() == 0

      nFileLen := fseek(nFileHandle,0,2)
      fseek(nFileHandle,0)

      cText := space(nFileLen)

      if fread(nFileHandle,@cText,nFileLen) == nFileLen
        cText := alltrim(strtran(cText,chr(26),chr(13))) + chr(13)
      endif

      // here goes //

      do while (.t.)

        // find the end of the line //

        nOffset := at( chr(13), cText )

        if ( nOffset == 0 )
          exit
        endif

        cLine := upper(alltrim( substr( cText,1,nOffset-1) ))
        cText := alltrim( substr( cText, nOffset ) )

        if !NlParser( cLine )
          EXIT
        endif

      enddo

      fclose(nFileHandle)

    endif

  endif

  RETURN(.t.)

//////////////////////////////////////////////////////////////////////////////

FUNCTION ChkIfComparison( cLine )

  LOCAL lPerformIF, cGroup
  MEMVAR xLOGIN_NAME, xP_STATION, xSMACHINE

  cLine := substr( cLine, at( "IF ", cLine ) + 3 )

  DO CASE

    CASE ( '"%LOGIN_NAME"' == left( cLine, 13) )
      lPerformIF := ( xLOGIN_NAME $ cLine )

    CASE ( '"%P_STATION"' == left( cLine, 12) )
      lPerformIF := ( xP_STATION $ cLine )

    CASE ( 'MEMBER OF' == left( cLine, 9) )
      cGroup := substr(cLine,at('"',cLine)+1,;
        (rat('"',cLine)) - (at('"',cLine)+1))
      lPerformIF := GRPUSRTST(WSLOGNMEGET(),cGroup)

    CASE ( '"%SMACHINE"' == left( cLine, 11) )
      lPerformIF := ( xSMACHINE $ cLine )

    OTHERWISE
      lPerformIF := .F.

  ENDCASE

  RETURN( lPerformIF )

//////////////////////////////////////////////////////////////////////////////

FUNCTION NlParser( cLine )

  LOCAL lMapRoot,lMapInsert,lMapDelete,lMapNext,nLPTNum, itemcnt
  LOCAL cnt,strlen,item,nSord,cDord,cLowVar,cHighVar
  LOCAL nLineOff
  LOCAL cServer,nNewServer,nOldServer,cUser,cPassword,Substring,GotKey,Char
  STATIC lPerformIF, lIfStarted, aIfStack, cBatch

  lIfStarted := iif( valtype(lIfStarted) == 'U', .F., lIfStarted )
  lPerformIF := iif( valtype(lPerformIF) == 'U', .F., lPerformIF )

  If lIfStarted
    DO CASE
      CASE ("END" == left( cLine, 3 ) )
        PopIF( @aIfStack )
        if empty(aIfStack)
          lPerformIF := .F.
          lIFStarted := .F.
        endif
        RETURN( .T. )
      CASE ("ELSE" == left( cLine, 4 ) ) .and. lPerformIF
        lPerformIF := .F.
        RETURN( .T. )
      CASE ("ELSE" == left( cLine, 4 ) ) .and. !lPerformIF
        lPerformIF := .T.
        RETURN( .T. )
      CASE ("IF" == left( cLine, 2 ) ) .and. !lPerformIF
        Push( @aIfStack, cLine )
        RETURN( .T. )
    ENDCASE
  endif

  if lPerformIF .OR. !lIfStarted
    DO CASE

      CASE ( "REM" == left( cLine, 3 ) )

        // need this in case valid lines are rem'ed out


      CASE ("IF" == left( cLine, 2 ) )
        Push( @aIfStack, cLine )
        lPerformIF := ChkIfComparison( cLine )
        lIfStarted := .T.

/*  sorry !, when CA fix the bug in ALERT() this should work */
/*
  CASE ( "WRITE" $ cLine )

     cLine := substr( cLine, at( "WRITE ", cLine ) + 6 )
     if cLine <> '""'
        cLine := strtran( cLine, "%LOGIN_NAME", xLOGIN_NAME )
        cLine := strtran( cLine, "%GREETING_TIME", xGREETING_TIME )
        cLine := strtran( cLine, '"', '' )
        alert( cLine )
    endif
*/

      CASE ( "COMSPEC" $ cLine )

        nLineOff := at( "=", cLine )
        cLowVar := substr( cLine ,1 ,nLineOff-1)
        cHighVar := substr( cLine, nLineOff+1 )

        if ( nSord := val( substr( cLine, nLineOff+2 ))) > 0
          cDord := SCHORDDRVGET( nSord )
          cHighVar := cDord + substr( cLine, at(":",cLine) )
        endif

        WSENVVARSET( cLowVar, cHighVar )

      CASE ( "SET" $ left( cLine, 7 ) )          // in case of DOS SET

        cLine := substr( cLine, at( "SET ", cLine ) + 4 )
        cLine := strtran( cLine, chr(34) )
        nLineOff := at( "=", cLine )

        cLine := strtran( cLine, "%OS_VERSION", xOS_VERSION )
        cLine := strtran( cLine, "%OS", xOS )
        cLine := strtran( cLine, "%STATION", xSTATION )
        cLine := strtran( cLine, "%MACHINE", xMACHINE )
        cLine := strtran( cLine, "%SMACHINE", xSMACHINE )
        cLine := strtran( cLine, "%LOGIN_NAME", xLOGIN_NAME )

        WSENVVARSET( substr( cLine ,1 ,nLineOff-1), substr( cLine, nLineOff+1 ) )

      CASE ( "DRIVE" == left( cLine, 5 ) )

        cLine = substr( cLine, at( "DRIVE ", cLine ) + 6, 1 )

        DrvCurSet( cLine )

      CASE ( "MAP" == left( cLine, 3 ) )

        cLine = substr( cLine, at( "MAP ", cLine ) + 4 )

        lMapRoot := .F.
        lMapInsert := .F.
        lMapDelete := .F.
        lMapNext := .F.

        DO CASE

          CASE ( "ROOT" == left( cLine, 4 ) )
            lMapRoot = .T.
          CASE ( "INS" == left( cLine, 3 ) )
            lMapInsert = .T.
          CASE ( ("DEL" == left( cLine, 3 )) .OR. ("REM" == left( cLine, 3 )) )
            lMapDelete = .T.
          CASE ( "NEXT" == left( cLine, 4 ) )
            lMapNext = .T.

        ENDCASE

        cLine := substr( cLine, at( " ", cLine ) + 1 )

        cLine := strtran( cLine, "%OS_VERSION", xOS_VERSION )
        cLine := strtran( cLine, "%OS", xOS )
        cLine := strtran( cLine, "%MACHINE", xMACHINE )
        cLine := strtran( cLine, "%SMACHINE", xSMACHINE )
        cLine := strtran( cLine, "%LOGIN_NAME", xLOGIN_NAME )

        NLMap( lMapRoot,lMapInsert,lMapDelete,lMapNext,cLine )

      CASE ( "ATTACH" == left( cLine, 6 ) )      // be careful, this assumes that the
        // users password is the same on all
        // servers

        cLine = substr( cLine, at( "ATTACH ", cLine ) + 7 )

        if at( "/", cLine ) > 0
          cServer = left( cLine, at( "/", cLine ) - 1 )
          cLine = substr( cLine, at( "/", cLine ) + 1 )
        endif

        if ( nNewServer := FSWSATTACH( cServer )) > 0
          nOldServer = FSPREFCONGET()
          FSPREFCONSET( nNewServer )
          FSWSLOGIN( cUser, cPassword )
          FSPREFCONSET( nOldServer )
        endif

      CASE ( "INCLUDE" $ cLine )

        // we'll let you work this out for yourself //

      CASE ( "CAPTURE" $ cLine )

        declare aitem[2,20]
        cLine = substr( cLine, at( "CAPTURE", cLine ) + 9 )

        strlen := len( cLine )
        itemcnt := 0
        cnt = 1
        substring = ""
        gotkey = .f.

        do while .t.

          char := substr(cLine,cnt,1)

          if ! (char $ "/ =")
            substring = substring + char
          endif

          cnt++

          if (cnt > strlen)
            char = " "                           // frig for end of string
          endif

          if ((char $ "= " ) .and. len(substring) > 0)

            if (char = "=")

              itemcnt++
              aitem[KEYWORD,itemcnt] := substring
              gotkey := .t.
              substring = ""

            else                                 // a space

              if !(gotkey)

                itemcnt++
                aitem[KEYWORD,itemcnt] := substring
                // might want to just in case there isn't one
                aitem[KEYVALUE,itemcnt] := ""

              else

                aitem[KEYVALUE,itemcnt] := substring

              endif

              gotkey=.f.
              substring = ""

            endif

          endif

          if (cnt>strlen)
            exit
          endif

        enddo

        if ( aitem[KEYWORD,1] == NIL )
          CapJob()
        elseif ( (itemcnt := ascan( aitem[KEYWORD], "J" ) ) > 0 )
          CapJob( aitem[KEYVALUE,itemcnt] )
        else

          itemcnt := ascan( aitem[KEYWORD], "L" )

          nLPTNum := iif( itemcnt == 0, 1, val( aitem[KEYVALUE,itemcnt]) )

          itemcnt := ascan( aitem[KEYWORD], "S" )

          FSPREFCONSET( iif( itemcnt == 0, FSPREFCONGET(), FSCONIDGET(aitem[KEYVALUE,itemcnt]) ) )

          CAPEND( nLPTNum )

          if ( itemcnt := ascan( aitem[KEYWORD], "P" ) ) > 0
            CAPFSPRNSET( nLPTNum, val( aitem[KEYVALUE,itemcnt]) )
          elseif ( itemcnt := ascan( aitem[KEYWORD], "Q" ) ) > 0
            CAPQUESET( nLPTNum, QUEIDGET(aitem[KEYVALUE,itemcnt]) )
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "FF" ) ) > 0
            CAPFMFDSET( nLPTNum, .T. )
            adel( aitem[KEYWORD], itemcnt )
            adel( aitem[KEYVALUE], itemcnt )
          else
            if ( itemcnt := ascan( aitem[KEYWORD], "FORMF" ) ) > 0
              CAPFMFDSET( nLPTNum, .T. )
              adel( aitem[KEYWORD], itemcnt )
              adel( aitem[KEYVALUE], itemcnt )
            endif
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "F" ) ) > 0
            CAPFRMNMESET( nLPTNum,aitem[KEYVALUE,itemcnt] )
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "C" ) ) > 0
            CAPCOPIESSET( nLPTNum, val(aitem[KEYVALUE,itemcnt]) )
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "TI" ) ) > 0
            CAPTMEOUTSET( nLPTNum, val(aitem[KEYVALUE,itemcnt])*18 )
            adel( aitem[KEYWORD], itemcnt )
            adel( aitem[KEYVALUE], itemcnt )
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "NAM" ) ) > 0
            CAPBANNMESET( aitem[KEYVALUE,itemcnt] )
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "T" ) ) > 0
            CAPTABFLGSET( nLPTNum, .T. )
            CAPTABSIZSET( nLPTNum, val(aitem[KEYVALUE,itemcnt]) )
          endif

          if ( itemcnt := ascan( aitem[KEYWORD], "B" ) ) > 0
            CAPBANTXTSET( nLPTNum, aitem[KEYVALUE,itemcnt] )
          endif

          if ascan( aitem[KEYWORD], "K" ) > 0
            CAPKEEPSET( nLPTNum, .T. )
          endif

          if ( ( ascan( aitem[KEYWORD], "NFF" ) > 0 ) .OR. ( ascan( aitem[KEYWORD], "NOFORM" ) > 0 ) )
            CAPFMFDSET( nLPTNum, .F. )
          endif

          if ( ( ascan( aitem[KEYWORD], "NT" ) > 0 ) .OR. ( ascan( aitem[KEYWORD], "NOTAB" ) > 0 ) )
            CAPTABFLGSET( nLPTNum, .F. )
          endif

          if ( ( ascan( aitem[KEYWORD], "NB" ) > 0 ) .OR. ( ascan( aitem[KEYWORD], "NOBAN" ) > 0 ) )
            CAPBANFLGSET( nLPTNum, .F. )
          endif

          CAPSTART(nLPTNum)

        endif

    ENDCASE
  endif

  RETURN( .T. )

//////////////////////////////////////////////////////////////////////////////

FUNCTION Push( aArray, xItem )

  aArray := iif( valtype(aArray) == 'A', aArray, {} )
  aadd( aArray, xItem)

  RETURN( NIL )

//////////////////////////////////////////////////////////////////////////////

FUNCTION PopIF( aArray )

  LOCAL nLen, lReturn

  if empty(aArray)
    lReturn := .F.
  else
    nLen := len(aArray)
    lReturn := aArray[nLen]
    aDel(aArray, nLen)
    aSize(aArray, nLen - 1)
  endif

  RETURN( lReturn )


//////////////////////////////////////////////////////////////////////////////

FUNCTION NlGrant( a, b, c, d, e, f, g, h, i, j, k, l, m, n )

  LOCAL nRights, nObjectType, cPath, nOffset, cDrive, cFullPath

  nRights := 0
  nObjectType := 1

  if !( a == NIL )                               // ALL
    nRights := 511
  elseif !( b == NIL )                           // NO RIGHTS
    nRights := 0
  else
    if !( c == NIL )                             // SUPERVISORY
      nRights += 256
    endif
    if !( d == NIL )                             // READ
      nRights += 1
    endif
    if !( e == NIL )                             // WRITE
      nRights += 2
    endif
    if !( f == NIL )                             // CREATE
      nRights += 8
    endif
    if !( g == NIL )                             // ERASE
      nRights += 16
    endif
    if !( h == NIL )                             // MODIFY
      nRights += 32
    endif
    if !( i == NIL )                             // FILE SCAN
      nRights += 64
    endif
    if !( j == NIL )                             // ACCESS CONTROL
      nRights += 128
    endif
  endif

  if !( k == NIL )
    cPath := k
    nOffset := at(":", cPath )
    if ( nOffset > 0 )
      if ( nOffset == 2 )
        cDrive = left( cPath, 1 )
        cPath := substr( cPath, 3 )
        cFullPath := DRVPTHGET( DRVDIRHANGET( cDrive ) )
        cFullPath := StrTran( cFullPath, "/", "\" )
        if ( left( cPath, 1 ) == "\" )
          nOffset := at( ":", cFullPath )
          cFullPath := left( cFullPath, nOffset )
          cPath := cFullPath + substr( cPath, 2 )
        else
          cPath := cFullPath + "\" + cPath
        endif
      endif
    else
      cPath := DRVPTHGET(DRVDIRHANGET(DRVCURSET()))+"\"+k
    endif
  else
    cPath := DRVPTHGET(DRVDIRHANGET(DRVCURSET()))
  endif

  if !( m == NIL )
    nObjectType := 2
  endif

  RETURN( DIROBJADD( OBJIDGET( n, nObjectType ), cPath, nRights ) )


FUNCTION NWPath( cDOSPath )

  LOCAL nOffset, cDrive, cPath, cFullPath

  cPath := cDOSPath

  nOffset := at(":", cPath )

  if ( nOffset > 0 )
    if ( nOffset == 2 )
      cDrive = left( cPath, 1 )
      cPath := substr( cPath, 3 )
      cFullPath := DRVPTHGET( DRVDIRHANGET( cDrive ) )
      cFullPath := StrTran( cFullPath, "/", "\" )
      if ( left( cPath, 1 ) == "\" )
        nOffset := at( ":", cFullPath )
        cFullPath := left( cFullPath, nOffset )
        cPath := cFullPath + substr( cPath, 2 )
      else
        cPath := cFullPath + "\" + cPath
      endif
    endif
  else
    cPath := DRVPTHGET(DRVDIRHANGET(DRVCURGET()))+"\"+cDOSPath
  endif

  RETURN( cPath )


//////////////////////////////////////////////////////////////////////////////

FUNCTION NlMap( a, b, c, d, e )

  LOCAL nOldPrefID,cPath,cServer,nOffset,cDrive,nSearchOrd,nRetValue,nLastDrive,nServ

  nOldPrefID := FSPREFCONGET()

  cPath := upper(alltrim(e))

  if ( nOffset := at( ":",cPath ) ) > 0

    if (!( rat( ":",cPath ) > nOffset ) .or. ( d )) .and. !( c )
      cDrive := DRVNXTFREGET()
    else
      cDrive := substr( cPath,1,nOffset-1 )
    endif

    if len( cDrive ) > 1

      nSearchOrd := val(right(cDrive,1))

      if left( cDrive, 1 ) == "S"

        cDrive := ""

      elseif left( cDrive, 1 ) == "*"

        nLastDrive := WSDRVLOCGET() + nSearchOrd
        nSearchOrd := 0

        cDrive := chr( nLastDrive + 64 )

      endif

    else

      nSearchOrd := 0

    endif

    nOffset := at( "=", cPath )

    cPath := substr( cPath,nOffset+1 )

  else

    RETURN( .f. )

  endif

  if ( nOffset := at( "/",cPath) ) > 0

    if at( ":",cPath ) > nOffset

      cServer := substr( cPath,1,nOffset-1 )

      FSPREFCONSET( FSCONIDGET( cServer ) )
      nServ = FSPREFCONGET()

      if !( nServ > 0 )

        RETURN( .f. )

      endif

      cPath := substr( cPath,nOffset+1 )

    endif

  endif


  DO CASE

    CASE ( c )

      if nSearchOrd > 0
        SCHDRVMAPDEL( nSearchOrd )
      else
        DRVMAPDEL( cDrive )
      endif
      nRetValue := 0

    CASE ( a )

      if !( nSearchOrd > 0 )
        nRetValue := DRVROOTMAP( cDrive, cPath )
      else
        nRetValue := 1
      endif

    CASE ( nSearchOrd > 0 )

      if ( b )
        nRetValue := SCHDRVDIRMAP( "", cPath, nSearchOrd )
      else
        SCHDRVMAPDEL( nSearchOrd )
        nRetValue := SCHDRVDIRMAP( "", cPath, nSearchOrd )
      endif

    OTHERWISE

      DRVDIRMAP( cPath, cDrive )

  END CASE

  FSPREFCONSET( nOldPrefID )

  RETURN( nRetValue )

//////////////////////////////////////////////////////////////////////////////

FUNCTION NlCapture( a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p )

  LOCAL nLPTNum

  if ( d == NIL )                                // ( c == NIL )
    if !( p == NIL )
      CapJob( upper( p ) )
    else
      CapJob()
    endif
    RETURN(0)
  endif


/*************************
* set local LPT port No. *
*************************/

  nLPTNum := iif( b == NIL, 1, val(b) )

/********************************
* set up destination fileserver *
********************************/

  FSPREFCONSET( iif( a == NIL, FSPREFCONSET(), FSCONIDGET(a) ) )

/******************************
* cancel any existing capture *
******************************/

  CAPEND( nLPTNum )

/*****************************************
* check for destination printer or queue *
*****************************************/

  if !( c == NIL )
    CAPFSPRNSET( nLPTNum, val(c) )
  elseif !( d == NIL )
    CAPQUESET( nLPTNum, QUEIDGET(d) )
  endif

/*****************
* check for form *
*****************/

  if !( e == NIL )
    CAPFRMNMESET( nLPTNum, e )
  endif

/*****************************
* check for number of copies *
*****************************/

  if !( f == NIL )
    CAPCOPIESSET( nLPTNum, val(f) )
  endif

/********************
* check for timeout *
********************/

  if !( g == NIL )
    CAPTMEOUTSET( nLPTNum, val(g)*18 )
  endif

/************************
* check for banner name *
************************/

  if !( h == NIL )
    CAPBANNMESET( nLPTNum, h )
  endif

/*********************
* check for tab size *
*********************/

  if !( i == NIL )
    CAPTABFLGSET( nLPTNum, .T. )
    CAPTABSIZSET( nLPTNum, val(i) )
  endif

/*******************
* check for banner *
*******************/

  if !( j == NIL )
    CAPBANTXTSET( nLPTNum, j )
  endif

/*****************
* check for keep *
*****************/

  if !( k  == NIL )
    CAPKEEPSET( nLPTNum, .T. )
  endif

/***********************
* check for form feeds *
***********************/

  if !( l == NIL )
    CAPFMFDSET( nLPTNum, .T. )
  endif

/**************************
* check for no form feeds *
**************************/

  if !( m == NIL )
    CAPFMFDSET( nLPTNum, .F. )
  endif

/********************
* check for no tabs *
********************/

  if !( n == NIL )
    CAPTABFLGSET( nLPTNum, .F. )
  endif

/**********************
* check for no banner *
**********************/

  if !( o == NIL )
    CAPBANFLGSET( nLPTNum, .F. )
  endif

  RETURN( CAPSTART(nLPTNum) )


FUNCTION Nlendcap( a, b, c, d )

  LOCAL nLPTNum

/*************************
* set local LPT port No. *
*************************/

  nLPTNum := iif( a == NIL, iif( d == NIL, 1, val(d) ), val(a) )

  if !( d == NIL )
    CAPCANCEL( nLPTNum )
  elseif !( c == NIL ) .and. !( b == NIL )
    CAPCANCEL(1)
    CAPCANCEL(2)
    CAPCANCEL(3)
  endif

  if !( b == NIL )
    CAPEND(1)
    CAPEND(2)
    CAPEND(3)
  else
    CAPEND( nLPTNum )
  endif

  RETURN( NIL )

//////////////////////////////////////////////////////////////////////////////

FUNCTION NLSysTime( a )

  LOCAL nOldServer, nNewServer

  if !(a == NIL)
    nOldServer := FSPREFCONGET()
    nNewServer := FSPREFCONSET( a )
    FSWSSYNC()
    FSPREFCONSET( nOldServer )
  else
    FSWSSYNC()
  endif

  RETURN( NIL )


//////////////////////////////////////////////////////////////////////////////

Function CapJob( cJobName )

  LOCAL cFileName,nFileHandle,nFileLen,cText,nIndexOffset,nOffset
  LOCAL cDefName,cServerName,cQueueName,nTabSize,nCopies,cFormName
  LOCAL lNotifyFlag,nPServerID,cUserName,cBannerName,cDeviceName
  LOCAL cModeName,lBannerFlag,lDataType,lFormFeed,nTimeOut,nPrinterNo
  LOCAL lAutoEndCap,nOldPrefID

  cFileName := WSDRVNETGET() + ":" + "\MAIL\"+;
    ltrim(NOVSTRHEXGET(WSLOGIDGET()))+"\PRINTCON.DAT"

  if file( cFileName )                           // is there a printcon.dat file

    nFileHandle := fopen( cFileName )            // open it

    if ferror() == 0

      nFileLen := fseek(nFileHandle,0,2)         // get length
      fseek(nFileHandle,0)

      cText := space(nFileLen)                   // create buffer

      if !( fread(nFileHandle,@cText,nFileLen) == nFileLen ) // read in file
        RETURN( -1 )                             // oops !
      endif

      // here goes //

      cDefName := substr( cText, 119, 32 )       // skip header
      cDefName := left( cDefName, at( chr(0), cDefName ) -1 ) // default job

      if ( cJobName == NIL )                     // if no job name passed
        cJobName := upper( cDefName )            // make it default job
      endif

      cText := substr( cText, 151 )              // start at begining of index

      if ( nOffset := at( cJobName, upper( cText ) ) ) == 0 // find job
        cJobName := cDefName                     // if not found make it default job
      endif

      nIndexOffset := bin2l(substr( cText, nOffset + 32, 4 ) ) // find offset

      cText := substr( cText, nIndexOffset - 149, 243 ) // get job

      cServerName := substr( cText, 1,  at( chr(0), cText ) - 1 ) // S=
      cText := substr( cText, 49 )
      cQueueName := substr( cText, 1, at( chr(0), cText ) -1 ) // Q=
      cText := substr( cText, 49 )
      nTabSize := bin2i( substr( cText, 1, 1 ) ) // TAB=
      nCopies := bin2i( substr( cText, 2, 2 ) )  // C=
      cText := substr( cText, 4 )
      cFormName := substr( cText, 1, at( chr(0), cText ) -1 ) // form
      cText := substr( cText, 41 )
      lNotifyFlag := if( substr( cText, 1, 1 ) != chr(0) , .T., .F. ) // notify
      nPserverID := bin2l( substr( cText, 2, 4 ) ) // P server
      cText := substr( cText, 6 )
      cUserName := substr( cText, 1, at( chr(0), cText ) -1 ) // user
      cText := substr( cText, 14 )
      cBannerName := substr( cText, 1, at( chr(0), cText ) -1 ) // banner name
      cText := substr( cText, 14 )
      cDeviceName := substr( cText, 1, at( chr(0), cText ) -1 ) // device
      cText := substr( cText, 34 )
      cModeName := substr( cText, 1, at( chr(0), cText ) -1 ) // mode
      cText := substr( cText, 34 )
      lBannerFlag := if( substr( cText, 1, 1 ) != chr(0) , .T., .F. ) // banner
      lDataType := if( substr( cText, 2, 1 ) != chr(0) , .T., .F. ) // type
      lFormFeed := if( substr( cText, 3, 1 ) != chr(0) , .T., .F. ) // FF
      nTimeOut := bin2i( substr( cText, 4, 2 ) ) // TI=
      nPrinterNo := val( chr( asc(substr( cText, 6, 1 )) + 48 ) ) // L=
      lAutoEndCap := if( substr( cText, 7, 1 ) != chr(0) , .T., .F. ) // auto

      fclose(nFileHandle)                        // close file

      CAPEND( nPrinterNo )                       // end existing capture

      nOldPrefID := FSPREFCONGET()                   // save old server

      FSPREFCONSET( FSCONIDGET( cServerName ) )        // set new one

      CAPQUESET( nPrinterNo, QUEIDGET( cQueueName ) ) // set queue

      if !( lDataType )
        CAPTABFLGSET( nPrinterNo, .T. )               // set tabs
        CAPTABSIZSET( nPrinterNo, nTabSize )
      else
        CAPTABFLGSET( nPrinterNo, .F. )
      endif

      CAPCOPIESSET( nPrinterNo, nCopies )           // set copies

      CAPFRMNMESET( nPrinterNo, cFormName )        // set form name

      CAPNFYFLGSET( nPrinterNo, lNotifyFlag )      // set notify

      CAPBANNMESET( nPrinterNo, cUserName )        // set users name on banner

      if ( lBannerFlag )
        CAPBANFLGSET( nPrinterNo, .T. )
        CAPBANTXTSET( nPrinterNo, cBannerName )     // set banner
      else
        CAPBANFLGSET( nPrinterNo, .F. )
      endif

      CAPFMFDGET( nPrinterNo, !(lFormFeed) )     // set form feeds

      CAPTMEOUTSET( nPrinterNo, nTimeout * 18 )    // set time out

      CAPAUTENDSET( nPrinterNo, lAutoEndCap )      // set autoend

      CAPSTART( nPrinterNo )                     // start capture

      FSPREFCONSET( nOldPrefID )                     // put back old server

    endif

  else

    RETURN( -2 )

  endif

  RETURN( 0 )

//////////////////////////////////////////////////////////////////////////////

// this version of send does not support sends across servers

FUNCTION NLSend( a, b, c, d, e, f, g )

  LOCAL x, aGroupList, cObjName, nCounter, nConnCount
  nCounter := 1

  aGroupList := {}

  IF !( a == NIL ) .AND. !( e == NIL )

    DO CASE
      CASE ( e == "CONSOLE" )
        FSMSGSND( a )
      CASE ( e == "EVERYBODY" )
        FOR x = 1 TO 255
          WSMSGSND( x, a )
        NEXT
      CASE !( d == NIL )                         // STATION
        WSMSGSND( val(e), a )
      CASE !( c == NIL )                         // GROUP
        DO WHILE ( .T. )
          cObjName := GRPUSRLST( e, nCounter++ )
          IF !empty( cObjName )
            nConnCount := USRCONLST( cObjName )
            FOR x = 1 TO nConnCount
              aadd( aGroupList, USRCONLST() )
            NEXT
          ELSE
            exit
          ENDIF
        ENDDO
        IF ( LEN( aGroupList ) > 0 )
          FOR x = 1 TO LEN( aGroupList )
            WSMSGSND( aGroupList[x], a )
          NEXT
        ENDIF
      OTHERWISE
        nConnCount := USRCONLST( e )
        FOR x = 1 TO nConnCount
          WSMSGSND( USRCONLST(), a )
        NEXT
      END

    ENDIF

    RETURN( NIL )

FUNCTION NLPURGE( a )

  RETURN( FSFILEPURGE( a ) )

