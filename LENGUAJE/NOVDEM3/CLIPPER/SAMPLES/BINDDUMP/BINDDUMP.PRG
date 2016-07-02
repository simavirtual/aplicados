
* BindDump.prg - Demo for NOVLIB V3.0 bindery functions.
* Copyright (c) 1994,1995 ASM Inc.
* Originally written by Ian Hill.

external OBJSECGET,PRPSECGET,OBJFLGGET,PRPFLGGET,SETPRPVALGET,OBJNMEGET
external ITMPRPBYTGET,ITMPRPVALGET, ITMPRPSTRGET

func binddump
parameters cCmdLine1,cCmdLine2,cCmdLine3,cCmdLine4,cCmdLine5

PUBLIC aBindTypes := { ;
                        "USERS",;
                        "USER GROUPS",;
                        "PRINT QUEUES",;
                        "FILE SERVERS",;
                        "JOB SERVERS",;
                        "GATEWAYS",;
                        "PRINT SERVERS",;
                        "ARCHIVE QUEUES",;
                        "ARCHIVE SERVERS",;
                        "JOB QUEUES";
                      }

PUBLIC nObjectType,cObjectName,cPropName,cDestSet,nObjectID
PUBLIC cCmdLine1,cCmdLine2,cCmdLine3,cCmdLine4,cCmdLine5
PUBLIC nStart,nFinish,cSearchName,aMode
PUBLIC lt,lp,lf,lv,ll

la := iif( PCOUNT() == 0 ,.T.,.F. )

lt := iif( WasPassed("T") ,.T.,.F.)
lp := iif( WasPassed("P") ,.T.,.F.)
lf := iif( WasPassed("F") ,.T.,.F.)
lv := iif( WasPassed("V") ,.T.,.F.)
ll := iif( WasPassed("L") ,.T.,.F.)


if lf .or. la
  set(_SET_PRINTFILE,"BindDump.Dat")
  set(_SET_PRINTER,.T.)
endif

if lp
  set(_SET_PRINTER,.T.)
endif

clear
? "BindDump Copyright (c) 1992-96 ASM Inc.  All Rights Reserved"
?
if ( WasPassed("?") )
  ? "Usage: BindDump <options>"
  ?
  ? "Options: /P = Echo to printer             /F = Echo to file BindDump.Dat"
  ? "         /T = Include Trustee assignments /L = Include Login scripts"
  ? "         /V = Include Properties and their values"
  ? "         /? = Help"
  ?
  ? "Example: BindDump /F /V /T /L"
  ?
  ? "         Will create a file called BindDump.Dat, containing a list of"
  ? "         the complete contents of the Bindery Files including all the"
  ? "         properties and their values, and directory trustee lists."
  ? "         To run this program, you should be logged in as Supervisor."
  ?
  quit
endif
if WSCONNUMGET() == 0
  ? "Error, not connected to a Novell Network"
  quit
endif


nStart := 1
nFinish := 101
cSearchName := "*"

? "Bindery contents and Trustee assignment listing"
? "for Fileserver",FSNMEGET(),"running NetWare version",NWVERNUMGET()
?
use prop
index on Name to prop
go top

aMode :=array(2,lastrec())

do while !eof()
  aMode[1,recno()] := alltrim(Name)
  aMode[2,recno()] := alltrim(Format)
  skip
enddo

for nObjectType = nStart to nFinish
  BindGet()
next
? replicate(chr(240),80)
Set Printer Off
return



FUNCTION BindGet()
LOCAL cTitle,cOptions,aBindList,nCounter, nObjectFlag, nObjectSec

aBindList := {}

cObjectName := FSOBJLST( cSearchName, nObjectType, .T. )

do while !empty( cObjectName )

  aadd( aBindList, cObjectName )
  cObjectName := FSOBJLST( "", nObjectType, .F. )

enddo

cTitle := {|| QOut(replicate("=",79)), QOut("BINDERY OBJECT TYPE:",;
              " "+ltrim(str(nObjectType))+" ",;
              iif(nObjectType < 11,aBindTypes[nObjectType],"UNKNOWN")),;
              cTitle := {||NIL},NIL}

cOptions := {|| iif( lv .or. la, Properties(),NIL),;
                iif( lt .or. la, Trustees(),NIL),;
                iif( ll .or. la, ReadLogin( nObjectID, nObjectType ),NIL)}

nCounter = 1

do while ( nCounter <= len( aBindList ) )
  eval( cTitle )
  cObjectName := aBindList[nCounter]
  nObjectFlag := OBJFLGGET(cObjectName,nObjectType)
  nObjectSec := OBJSECGET(cObjectName,nObjectType)
  nObjectID := OBJIDGET(cObjectName,nObjectType)
  ? replicate("-",79)
  ?
  ? "Bindery Object Name:",cObjectname
  ? "Bindery Object ID  :",ltrim(NOVSTRHEXGET(nObjectID))
  ? "Static/Dynamic Flag:",Flags(nObjectFlag)
  ? "Object Security    :",SecurityCheck(nObjectSec)
  ?
  eval( cOptions )
  nCounter++
enddo

return NIL




FUNCTION SecurityCheck( cType )
LOCAL cSecString,cSecurity
LOCAL cRights := {;
                    "Anyone ",;
                    "Logged ",;
                    "Object ",;
                    "Supervisor ",;
                    "NetWare ";
                 }
cSecurity := ltrim(NOVSTRHEXGET(cType))
cSecString := cRights[val(right(cSecurity,1))+1]+"Read, "+;
              cRights[val(left(cSecurity,1))+1]+"Write"
return cSecString




FUNCTION Flags( cType )
LOCAL cFlagTypes := {;
                      "(Static)(Item)",;
                      "(Dynamic)(Item)",;
                      "(Static)(Set)",;
                      "(Dynamic)(Set)";
                    }
return cFlagTypes[cType+1]




FUNCTION WasPassed( cTestPar )
LOCAL cElement,nCounter := 0,lRetVal := .F.
do while ( ++nCounter < 6 )
  cElement := "cCmdLine"+str(nCounter,1)
  if ( valtype( &cElement. ) != "U" ) .and. (cTestPar $ upper(&cElement.))
    lRetVal := .T.
    exit
  endif
enddo
return ( lRetVal )



FUNCTION ReadLogin( uObject, nObjectType )
LOCAL nFileHandle,nFileLen,cLogScript,nLenPointer,cFileName

nObjectID := iif( valtype( uObject ) == "C",;
                  OBJIDGET( uObject,nObjectType ), uObject )

if nObjectType == 1
  cFileName := WSDRVNETGET()+":\MAIL\"+ltrim(NOVSTRHEXGET(nObjectID))+"\LOGIN"
elseif nObjectType == 4
  cFileName := WSDRVNETGET()+":\PUBLIC\NET$LOG.DAT"
else
  return NIL
endif
if file( cFileName )
  nFileHandle := fopen( cFileName )
  if ferror() == 0
    nFileLen := fseek(nFileHandle,0,2)
    fseek(nFileHandle,0)
    cLogScript := space(nFileLen)
    if fread(nFileHandle,@cLogScript,nFileLen) == nFileLen
      cLogScript := alltrim(strtran(cLogScript,chr(26)))
      ? iif(nObjectType == 1,"User's","System"),"login script:"
      ?
      ? cLogScript
    else
      ? "Error reading File ",cFileName
    endif
    fclose(nFileHandle)
  else
    ? "Error opening file ",cFileName
  endif
else
  ? "Can't find file ",cFileName
endif
?
return NIL



FUNCTION Properties()
LOCAL nSetVal,nOffSet,cPropValue,nPointer,aPropList,nCounter,nMarker, nNulPos

aPropList := {}
nCounter := 1

if OBJPRPTST(cObjectName,nObjectType)
  ? "Properties:"
  ?

  cPropName := OBJPRPLST( cObjectName, nObjectType, "*", .T. )

  do while !empty( cPropName )

    aadd( aPropList, cPropName )
    cPropName := OBJPRPLST("", nObjectType, "*", .F. )

  enddo

  do while ( nCounter <= len( aPropList ) )

    cPropName := aPropList[nCounter]
    ? padr(cPropName,15),"->",Flags(PRPFLGGET(cObjectName, nObjectType, cPropName)),;
                              SecurityCheck(PRPSECGET(cObjectName, nObjectType, cPropName))
    if PRPVALTST(cObjectName, nObjectType, cPropName)
      ? "Values :"
      nMarker := 0
      nMarker := ascan( aMode[1], cPropName )
      if( nMarker == 0 )
        nMarker := ascan( aMode[1], "UNKNOWN" )
      endif
      nOffset := 1
      do while .T.
        cPropValue := eval(&(aMode[2,nMarker]),cObjectName,nObjectType,cPropName,nOffSet++)
        if (NWERRORGET()=0)                    // if no error
          nNulPos = AT(CHR(0),cPropValue)   // 128 byte binary string - scan for a NULL string terminator
          if nNulPos > 1                    // If there was a NULL
             cPropValue = LEFT(cPropValue,nNulPos-1) // Dump rubbish after the NULL
          endif
          if col() > 70 .or. nOffSet == 2
            qout( space(9)+cPropValue )
          else
            qqout( space(2)+cPropValue )
          endif
        else
          exit
        endif
      enddo
      ?
    endif
    nCounter++
  enddo
endif
return NIL




FUNCTION Trustees()
LOCAL cBindCode,nVolumeNum,cTrustPath
nVolumeNum := 0
? "Trustee Assignments:"
?
do while !empty( VOLNMEGET(nVolumeNum) )
  cBindCode := {||l := OBJDIRLST(nVolumeNum,nObjectID, .T.),;
                                cBindCode := {||OBJDIRLST(nVolumeNum,nObjectID,.F.)},l}
  do while !empty( cTrustPath := eval( cBindCode ) )
    ? padr(cTrustPath,60),NOVRGTSTR(DIRACCRTGET())
  enddo
  nVolumeNum++
enddo
?
return NIL
