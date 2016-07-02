// a sort of ndir/xtree prog that lists deleted files
// in a specified dir, and their info.
//
// usage DDIR < directory spec >
//
// ie: DDIR SYS:PUBLIC
//
// by Goth
//

#include "fileio.ch"
#include "inkey.ch"
#define STACK_TOP      1
#define FILE_LINE      1
#define FILE_HANDLE    2
#define FILE_PATH      3
#define CR             chr(13)
#define LF             chr(10)
#define CRLF           chr(13)+chr(10)
#define MAX_LINE_LEN   256
#define fset( nHandle ) fseek( nHandle, 0, FS_SET )
#define fptr( nHandle ) fseek( nHandle, 0, FS_RELATIVE )
#define fend( nHandle ) fseek( nHandle, 0, FS_END )

LOCAL cName, cScanPath, cTemp
PUBLIC aStack, cPath, nHandle

parameters cCommand

SET DATE BRITISH

aStack := {}

CLEAR SCREEN
cPath := DRVPTHGET( DRVCURGET() )
cPath := strtran( cPath, "/", "\" )

if ( cCommand == NIL )
  cName := ""
else
  cCommand := upper(cCommand)
  if ( ":" $ cCommand )
    if !( ":\" $ cCommand )
      cCommand := strtran( cCommand, ":", ":\" )
    endif
  endif
  if !( "\" $ cCommand )
    cName := "\"+cCommand
  else
    if ( ":" $ cCommand )
        cPath := DRVPTHGET(left(cCommand, 1 ))
        cTemp := right( cCommand, LEN(cCommand) - at(":", cCommand) )
        cPath := cPath + cTemp
    else
        cPath := left( cCommand, rat( "\", cCommand ) - 1 )
    endif
    cName := substr( cCommand, rat( "\", cCommand ) )
  endif
endif
cPath := strtran(cPath, "/", "\")
if right(alltrim(cPath), 1) == "\"
    cPath := left(cPath, rat("\", cPath) - 1)
endif

nHandle := fcreate( "DDIR.LOG", FC_NORMAL )

? "Scanning Directories, please be patient"
?
?

do while .T.

  cScanPath := cPath + cName    // cScanPath is the currently used directory

  FindDir( cPath + "\*" )       // get all sub directories and push to stack

  DispFile( cScanPath )         // list files from current directory

  cPath := PopStack()           // get next directory

  if empty( cPath )             // if nothing left on stack
    exit                        // exit loop
  endif

enddo

?

fclose( nHandle )

browser()

CLEAR SCREEN

// DELETE FILE "DDIR.LOG"

QUIT


FUNCTION PushStack( cElement )   // pushes directory onto directory stack

aadd( aStack, "" )
ains( aStack, STACK_TOP )
aStack[STACK_TOP] := cElement

return( NIL )


FUNCTION PopStack()             // pops next directory from directory stack

LOCAL cElement

cElement := aStack[STACK_TOP]
adel( aStack, STACK_TOP )

return( cElement )


FUNCTION FindDir( cScanPath )        // gets next list of directories and
                                     // pushes them on directory stack
LOCAL cName, nCounter, cTemp

nCounter := 0

cName := DIRSUBDIRLST( cScanPath )
?cName
do while !( empty( cName ) )

  nCounter++

    cTemp := strtran((cPath + cName), "/", "\")
  PushStack( cPath +"\"+ cName )

  cName := DIRSUBDIRLST()

enddo

asort( aStack, 1, nCounter )         // sort them into alphabetical order

return( NIL )


FUNCTION DispFile( cScanPath )

LOCAL cName, aFiles, nCounter, nOffset, nRow, cBuffer
LOCAL dDate, cTime, nDName, dADate, cATime, nAName, dMDate, cMTime, cMName
LOCAL dACDate, cMask, cAtt

aFiles := {}

nRow := row()

cBuffer := FSNMEGET()+"/"+cPath

@ nRow, 0 clear
@ nRow, 0 say "  "+strtran(cBuffer, "/", "\")

FileWrite( cBuffer+CRLF )

cName := ""
cName := alltrim(DIRDFLLST( cScanPath ))

do while !( empty( cName ) )

  @ nRow, 0 say Wheel()             // it looks pretty !

  nOffset := at( ".", cName )

  if nOffset > 0
    cName := (padr(left(cName,nOffset - 1), 8)+;
        padr(substr(cName, nOffset), 4, " "))
  else
    cName := padr( cName, 12 )
  endif

  dDate   := DFLDELDTEGET()
  dTime   := DFLDELTMEGET()
  nDName  := DFLDELIDGET()
  dADate  := DFLARCDTEGET()
  cATime  := DFLARCTMEGET()
  nAName  := DFLARCIDGET()
  dMDate  := DFLMODDTEGET()
  cMTime  := DFLMODTMEGET()
  cMName  := DFLMODIDGET()
  dACDate := DFLACCDTEGET()
  cAtt    := NOVATTSTR(DFLATTGET())

  aadd( aFiles, cName+"^"+dtoc(dDate)+"^"+dTime+"^"+OBJNMEGET(nDName)+"^"+dtoc(dADate)+;
                      "^"+cATime+"^"+OBJNMEGET(nAName)+"^"+dtoc(dMDate)+"^"+cMTime+;
                      "^"+OBJNMEGET(cMName)+"^"+dtoc(dAcDate)+"^"+cAtt )
  cName := ""
  cName := alltrim(DIRDFLLST())
enddo

@ nRow, 0 say " "

asort( aFiles )                     // sort them into alphabetical order

for nCounter = 1 to len( aFiles )

@ nRow, 0 say Wheel()

  cBuffer :=  "  "+aFiles[nCounter]
  FileWrite( cBuffer+CRLF )

next

@ nRow, 0 say " "

cBuffer := FSNMEGET()+"/"+cPath
FileWrite( "*"+cBuffer+CRLF )

return( NIL )


FUNCTION Wheel()

LOCAL cValue
STATIC nCounter := 1

DO CASE
  CASE nCounter == 1
    cValue := "-"
  CASE nCounter == 2
    cValue := "\"
  CASE nCounter == 3
    cValue := "|"
  CASE nCounter == 4
    cValue := "/"
ENDCASE

nCounter := if( nCounter == 4, 1, ++nCounter )

return( cValue )


FUNCTION FileWrite( cBuffer )

LOCAL nLength, lRetVal

nLength := len( cBuffer )
lRetVal := .F.

if fwrite( nHandle, cBuffer, nLength ) == nLength
  lRetVal := .T.
endif

return( lRetVal )


FUNCTION FileInit( cFileName )

LOCAL aFStruct := array(3)

if ( aFStruct[FILE_HANDLE] := fopen( cFileName ) ) > 0
  fend( aFStruct[FILE_HANDLE] )
  GoFirst( aFStruct )
else
  aFStruct := NIL
endif

return( aFStruct )


FUNCTION GoFirst( aFStruct )

LOCAL cLine
LOCAL nHandle := aFStruct[FILE_HANDLE]

fset( nHandle )
FreadLn( nHandle, @cLine )
aFStruct[FILE_LINE] := cLine

if left( cLine, 1 ) != " "
  aFStruct[FILE_PATH] := strtran( cLine, "*", "")
endif

fset( nHandle )

return( NIL )


FUNCTION GoLast( aFStruct )

LOCAL nHandle := aFStruct[FILE_HANDLE]

fend( nHandle )
GoPrevLn( aFStruct )

return( NIL )


FUNCTION FreadLn( nHandle, cBuffer )

LOCAL nEOL, nRead, nSavePos

cBuffer := space( MAX_LINE_LEN )  // space for new data

nSavePos := fptr( nHandle )       // save current position of pointer

nRead := fread( nHandle, @cBuffer, MAX_LINE_LEN )  // read in buffer

if ( nEOL := at( CRLF, substr( cBuffer, 1, nRead ))) = 0
else                     // if there is a CR
  cBuffer := substr( cBuffer, 1, nEOL - 1 )    // trunkate line to nearest CR
  fseek( nHandle, nSavePos + nEOL + 1, FS_SET )    // move pointer to end of line
endif

return( nRead != 0 )


FUNCTION CurLine( aFStruct )
LOCAL nOffset, cLine

if( left( aFStruct[FILE_LINE],1 ) != "*" )
  nOffset := at("^",aFStruct[FILE_LINE] )
  if( nOffset > 0 )
    cLine := substr( aFStruct[FILE_LINE], 1, nOffset-1 )
  else
    cLine := aFStruct[FILE_LINE]
  endif
else
  cLine := ""
endif

return( cLine )


FUNCTION GoPrevLn( aFStruct )

LOCAL nHandle, nOrigPos, nMaxRead, nNewPos, lMoved, cBuffer, nWhereCRLF
LOCAL nPrev, cTemp

nHandle := aFStruct[FILE_HANDLE]   // get file handle
nOrigPos := fptr( nHandle )        // get current file pointer

if nOrigPos == 0                   // is it at beginning of file
  lMoved := .F.                    // yes then can't go back
else
  lMoved := .T.
  fseek( nHandle, -2, FS_RELATIVE ) // move file pointer back one byte
  cTemp := space(2)                 // set up buffer
  fread( nHandle, @cTemp, 2)        // read in one character
  if cTemp == CRLF                    // is it CR
    fseek( nHandle, -2, FS_RELATIVE ) // yes go back another character
  endif
  nMaxRead := min( MAX_LINE_LEN, fptr( nHandle ) )  // whats less max length or file pointer pos
  cBuffer := space( nMaxRead )                      // set up buffer
  nNewPos := fseek( nHandle, -nMaxRead, FS_RELATIVE ) // move back by buffer length
  fread( nHandle, @cBuffer, nMaxRead )
  nWhereCRLF := rat( CRLF, cBuffer )    // find the last CR
  if nWhereCRLF == 0                  // if there isnt one
    nPrev := nNewPos                  // save new position
    aFStruct[FILE_LINE] := cBuffer    // copy buffer
  else
    nPrev := nNewPos + nWhereCRLF + 1             // point to first char after lst CR
    aFStruct[FILE_LINE] := substr( cBuffer, nWhereCRLF + 2 )  // copy sub buffer
  endif
  fseek( nHandle, nPrev, FS_SET )     // set pointer to beginning of current line

  if left( aFStruct[FILE_LINE], 1 ) != " "
    aFStruct[FILE_PATH] := strtran(aFStruct[FILE_LINE], "*", "")
  endif

endif

return( lMoved )


FUNCTION FileSkip( nNum, aFStruct )

LOCAL nSkipped := 0

if nNum > 0
  do while nSkipped != nNum .AND. GoNextLn( aFStruct )
    nSkipped++
  enddo
else
  do while nSkipped != nNum .AND. GoPrevLn( aFStruct )
    nSkipped--
  enddo
endif

return( nSkipped )


FUNCTION GoNextLn( aFStruct )

LOCAL nHandle, nSavePos, cBuffer, lMoved, nNewPos

nHandle := aFStruct[FILE_HANDLE]      // get handle
nSavePos := fptr( nHandle )           // save position
cBuffer := " "

fseek( nHandle, len( aFStruct[FILE_LINE]) + 2, FS_RELATIVE ) // len of current line + 1
nNewPos := fptr( nHandle )            // move pointer to beginning of next line

if FreadLn( nHandle, @cBuffer )       // read in new buffer
  lMoved := .T.                       // moved is now .T.
  aFStruct[FILE_LINE] := cBuffer      // transfer buffer
  fseek( nHandle, nNewPos, FS_SET )   // set pointer back to beginning of current line
else
  lMoved := .F.                       // unable to move
  fseek( nHandle, nSavePos, FS_SET )  // put pointer back to where it was
endif

  if left( aFStruct[FILE_LINE], 1 ) != " "
    aFStruct[FILE_PATH] := strtran(aFStruct[FILE_LINE],"*","")
  endif

return( lMoved )


FUNCTION Browser()

LOCAL oB, oBc, nKey, lConfirm, aFStruct, lExit, cArea
LOCAL nTop, nLeft, nBottom, nRight, nOffset, cFileLine
LOCAL cPathNear, cPathFar, lDir, cFileName
LOCAL cDate, cTime, cName, cADate, cATime, cAName, cMDate, cMTime, cMName
LOCAL cACDate, cMask, cAtt


nTop := 2
nLeft := 46
nBottom := 16
nRight := 78

CLEAR SCREEN

aFStruct := FileInit( "DDIR.LOG" )

lConfirm := SET( _SET_CONFIRM, .t. )

@ 0, 0 to maxrow()-1, maxcol() double

oB := TBrowseNew( 1, 1, maxrow() - 2 , maxcol() - 1 )
ob:colorSpec := "W/N, B+/W, W+/B, R+/N, B+/W, B/W, W/B"
oBc := TBColumnNew(, { || CurLine( aFStruct ) } )
oBc:width := 80
oBc:colorBlock := { | cLine | if( left( cLine, 1 ) != " " , {4,5}, {1,2} ) }

oB:addColumn( oBc )

oB:goTopBlock    := { || GoFirst( aFStruct ) }
oB:goBottomBlock := { || GoLast( aFStruct ) }
oB:skipBlock     := { | n | FileSkip( n, aFStruct ) }

lExit := .F.

cPathFar := ""
cPathNear := ""

do while !lExit

  do while !oB:stabilize()
  enddo

  cFileLine := aFStruct[FILE_LINE]                   // save line

  if aFStruct[FILE_PATH] == strtran(aFStruct[FILE_LINE],"*","" )
    cPathFar := aFStruct[FILE_PATH]
  else
    nOffset := at( "^", cFileLine )                    // find first caret
    cFileName := substr( cFileLine, 1, nOffset-1 )     // strip name out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    cFileName :=  strtran( cFileName, " ", "" )        // filter out spaces
    cPathFar := aFStruct[FILE_PATH]+"\"+cFileName      // make far path
  endif

  lDir := if( aFStruct[FILE_LINE] == aFStruct[FILE_PATH], .T., .F. )

  @ maxrow(), 1 clear to maxrow(), 79
  @ maxrow(), 1 say ltrim( cPathFar )

  cPathNear := substr( cPathFar, at( "/", cPathFar ) + 1 )

  cArea := savescreen( nTop, nLeft, nBottom, nRight )
  @ nTop, nLeft clear to nBottom, nRight
  @ nTop, nLeft to nBottom, nRight

  SET COLOR TO "BG/N, N/W"

  @ nTop+1, nLeft+1  say "File Name     : "
  @ nTop+2, nLeft+1  say "Date Deleted  : "
  @ nTop+3, nLeft+1  say "Time Deleted  : "
  @ nTop+4, nLeft+1  say "File Deletor  : "
  @ nTop+5, nLeft+1  say "Date Archived : "
  @ nTop+6, nLeft+1  say "Time Archived : "
  @ nTop+7, nLeft+1  say "Archived By   : "
  @ nTop+8, nLeft+1  say "Date Modified : "
  @ nTop+9, nLeft+1  say "Time Modified : "
  @ nTop+10, nLeft+1 say "Modified By   : "
  @ nTop+11, nLeft+1 say "Last Accessed : "
  @ nTop+12, nLeft+1 say "Attributes "

 if !empty( CurLine( aFStruct )) .AND. right( cPathNear, 1 ) != ":"

    SET COLOR TO "GR+/N, N/W"

    nOffset := at( "^", cFileLine )                    // find next caret
    cDate := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cTime := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cName := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cADate := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cATime := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cAName := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cMDate := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cMTime := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cMName := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    nOffset := at( "^", cFileLine )                    // find next caret
    cACDate := substr( cFileLine, 1, nOffset-1 )         // strip info out
    cFileLine := substr( cFileLine, nOffset+1 )        // truncate line to beyond caret
    cAtt := cFileLine


    @ nTop+1, nLeft+17  say if( lDir, "", cFileName )
    @ nTop+2, nLeft+17  say if( lDir, "", cDate )
    @ nTop+3, nLeft+17  say if( lDir, "", cTime )
    @ nTop+4, nLeft+17  say if( lDir, "", cName )
    @ nTop+5, nLeft+17  say if( lDir, "", cADate )
    @ nTop+6, nLeft+17  say if( lDir, "", cATime )
    @ nTop+7, nLeft+17  say if( lDir, "", cAName )
    @ nTop+8, nLeft+17  say if( lDir, "", cMDate )
    @ nTop+9, nLeft+17  say if( lDir, "", cMTime )
    @ nTop+10, nLeft+17 say if( lDir, "", cMName )
    @ nTop+11, nLeft+17 say if( lDir, "", cACDate )
    @ nTop+12, nLeft+12 say if( lDir, "", cAtt  )

  endif

  SET COLOR TO

  nKey := inkey(0)

  restscreen( nTop, nLeft, nBottom, nRight, cArea )

  do case
    case ( nKey == K_RETURN .and. oB:stable() )
    case ( nKey == K_DOWN );       oB:down()
    case ( nKey == K_UP );         oB:up()
    case ( nKey == K_PGDN );       oB:pageDown()
    case ( nKey == K_PGUP );       oB:pageUp()
    case ( nKey == K_CTRL_PGUP );  oB:goTop()
    case ( nKey == K_CTRL_PGDN );  oB:goBottom()
    case ( nKey == K_RIGHT );      oB:right()
    case ( nKey == K_LEFT );       oB:left()
    case ( nKey == K_HOME );       oB:home()
    case ( nKey == K_END );        oB:end()
    case ( nKey == K_CTRL_LEFT );  oB:panLeft()
    case ( nKey == K_CTRL_RIGHT ); oB:panRight()
    case ( nKey == K_CTRL_HOME );  oB:panHome()
    case ( nKey == K_CTRL_END );   oB:panEnd()
    case ( nKey == K_ESC );        lExit := .T.
  endcase


enddo

SET( _SET_CONFIRM, lConfirm )

fclose( aFStruct[FILE_HANDLE] )

return( Nil )



