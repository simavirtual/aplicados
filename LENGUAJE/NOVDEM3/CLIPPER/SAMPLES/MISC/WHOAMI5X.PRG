/*
 * WHOAMI emulator for Clipper 5.x and NOVLIB 3.x
 * By Steve Busey 03/01/95
 * Updated:       03/05/96 mgs
 *
 * Build:
 *    CLIPPER whoami5x /n/m
 *    BLINKER fi whoami5x li novlibcl, novlib /q
 *
 * Run with "WHOAMI5X /?" to see available options.
 *
 */

#include "novlib.ch"

#define pCRLF       chr(13)+chr(10)

#define pSYNTAX     1
#define pSERVER     2
#define pSECURITY   3
#define pGROUPS     4
#define pCONTINUOUS 5
#define pWORKGROUPS 6
#define pALL        7

STATIC cFSName, nConn, cUser, aFlags


function start( cP1, cP2, cP3, cP4, cP5, cP6, cP7 )
  LOCAL i, nSavePref
  
  aFlags := ParseCmdLine( cP1, cP2, cP3, cP4, cP5, cP6, cP7 )
  
  if aFlags[pSYNTAX]
    LineOut( "Usage:" )
    LineOut( "WHOAMI5X [Server] [/Security] [/Groups] [/WorkGroups] [/All] [/Continuous] [/?]")
    LineOut( "" )
    retu(Nil)
  endif
  
  // if no fileserver specified
  if empty( aFlags[pSERVER] )
    for i := 1 to 8
      if GetInfo(i)
        if aFlags[pSECURITY]
          ShowSecurity( cUser )
        endif
        
        if aFlags[pGROUPS]
          ShowGroups( cUser )
        endif
        LineOut( "" )
        LineOut( "" )
      endif
    next
  else
    i := FSCONIDGET( aFlags[pSERVER] )
    if i==0
      tone(900,.1)
      ?? "You are not attached to server "+upper(aFlags[pSERVER])+"." 
      LineOut( "" )
    else
      if GetInfo(i)
        if aFlags[pSECURITY]
          ShowSecurity( cUser )
        endif
        
        if aFlags[pGROUPS]
          ShowGroups( cUser )
        endif
      endif
      
      LineOut( "" )
      LineOut( "" )
    endif
  endif
  
  return(Nil)

function ParseCmdLine( cP1, cP2, cP3, cP4, cP5, cP6, cP7 )
  LOCAL aTemp, i, cParm
  
  aTemp := array(7)
  afill( aTemp, .f. )
  aTemp[pSERVER] := ""
  
  CheckParm( cP1, aTemp )
  CheckParm( cP2, aTemp )
  CheckParm( cP3, aTemp )
  CheckParm( cP4, aTemp )
  CheckParm( cP5, aTemp )
  CheckParm( cP6, aTemp )
  CheckParm( cP7, aTemp )
  
  if aTemp[pALL]
    aTemp[pSECURITY]   := .t.
    aTemp[pGROUPS]     := .t.
    aTemp[pWORKGROUPS] := .t.
  endif
  
  return( aTemp )

function CheckParm( cParm, aTempFlags )
  LOCAL i, j, nPos, cVal, aVals
  
  if empty(cParm)
    return(Nil)
  else
    // split parms up if multiple are run together
    cParm  := strtran( cParm, "/", pCRLF + "/")
    if left(cParm,2) == pCRLF
      cParm := substr(cParm,3)
    endif
    j      := mlcount(cParm)
    for i  := 1 to j
      cVal := upper( alltrim(memoline( cparm,,i)))
      if left(cVal,1) == "/"
        DO CASE
            
          CASE cVal=="/S" .or. cVal=="/SECURITY"
            aTempFlags[pSECURITY]   := .t.
            
          CASE cVal=="/G" .or. cVal=="/GROUPS"
            aTempFlags[pGROUPS]     := .t.
            
          CASE cVal=="/W" .or. cVal=="/WG" .or. cVal=="/WORKGROUPS"
            aTempFlags[pWORKGROUPS] := .t.
            
          CASE cVal=="/A" .or. cVal=="/ALL"
            aTempFlags[pALL]        := .t.
            
          CASE cVal=="/C" .or. cVal=="/CONTINUOUS"
            aTempFlags[pCONTINUOUS] := .t.
            
          CASE cVal=="/?"
            aTempFlags[pSYNTAX]     := .t.
            
        ENDCASE
        
      else     // no slash, must be server
        aTempFlags[pSERVER] := cParm

      endif
    next
  endif
  
  return(Nil)

function GetInfo(i)
  LOCAL dLogin, ctLogin, nHour, cHour, cMin, cTime
  
  cFSName := FSNMEGET( i )
  if !empty( cFSName )
    FSPREFCONSET( i )
    nConn := WSCONNUMGET()
    cUser := WSLOGNMEGET( nConn )
    if empty( cUser )
      ?? "You are attached to server", cFSName
      ?? ", connection", ltrim(str(nConn))
      ?? ", but not logged in."
    else
      ?? "You are user", cUser, "attached to server", cFSName
      ?? ", connection", ltrim( str( nConn )) + "."
    endif
    LineOut( "Server "+ cFSName+ " is running NetWare v" + ltrim( NWVERNUMGET() ))
    ?? " ("
    ?? ltrim(str( FSCONMAXGET( ) )),"user)."
    
    if aFlags[pWORKGROUPS] 
      if UsrGrpMgrTst( cUser )
        LineOut( "You are a workgroup manager." )
      endif
    endif
    
    dLogin := WSLOGDTEGET()
    if !empty( dLogin )
      LineOut( "Login time: " + cdow( dLogin ))
      ?? "  "
      ?? cmonth( dLogin ), str( day( dLogin ), 2 )
      ctLogin := WSLOGTMEGET()
      nHour := val(left(ctLogin,2))
      if nHour == 0 .or. nHour == 12
        cHour := " 12"
      else
        cHour := " " + ltrim( str(int(nHour%12)))
      endif
      cMin  := substr( ctLogin, 4, 2 )
      cTime := cHour + ":" + cMin + iif( nHour>11," pm" , " am" )
      ?? ",", str( year( dLogin ), 4), cTime
    endif
  endif
  
  return( !empty(cFSName) )

function ShowSecurity( cUserID )
  LOCAL cPropName, cObjectName, nObjectType, cPropValue, nOffset
  LOCAL bSecurity := {|a,b,c,d| OBJNMEGET( SETPRPVALGET(a,b,c,d))}
  LOCAL nObjID, nObjTyp
  
  LineOut( "You are security equivalent to the following:" )
  
  cObjectName := cUserID
  nObjectType := OT_USER 
  cPropName   := "SECURITY_EQUALS"
  
  if PRPVALTST( cObjectName, nObjectType, cPropName )
    nOffset := 1
    do while .T.
      cPropValue := eval( bSecurity, cObjectName, nObjectType, cPropName, nOffSet++ )
      if !empty( cPropValue )
        LineOut( "    "+ cPropValue)
        nObjID := OBJIDGET( cPropValue, OT_USER_GROUP )
        if nObjID== -1
          nObjID := OBJIDGET( cPropValue, OT_USER )
        endif
        nObjTyp := OBJTYPGET( nObjID )
        if nObjTyp == OT_USER
          ?? " (User)"
        elseif nObjTyp == OT_USER_GROUP
          ?? " (Group)"
        endif
      else
        exit
      endif
    enddo
  endif
  
  return(Nil)

function ShowGroups( cUserID )
  LOCAL nOffset, cGroups
  
  LineOut( "You are a member of the following groups:" )
  nOffset := 1
  cGroups := USRGRPLST( cUserID, nOffset )
  do while !empty( cGroups )
    LineOut( "    " + cGroups )
    nOffset++
    cGroups := USRGRPLST( cUserID, nOffset )
  enddo
  
  return(Nil)

function LineOut( cStr )
  STATIC nLinesShown := 0, nVidLines   := 22
  LOCAL nKey, nRow
  
  // if CONTINUOUS flag is set, we can skip this part
  if  !aFlags[pCONTINUOUS] .and.  ( nLinesShown >= nVidLines )
    nLinesShown := 0
    
    nRow := row()
    ? "Press any key to continue ... ('C' for continuous)" 
    nKey := inkey(0)
    @ nRow,0 say space(80)
    @ nRow-1,0 say ""
    if upper(chr(nKey)) == "C"
      aFlags[pCONTINUOUS] := .T. 
    endif 
  endif
  
  nLinesShown++
  ? cStr
  
  return(Nil)
